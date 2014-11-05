package com.velvetmastermind.rostr;

import org.jsoup.Jsoup;
import org.jsoup.nodes.*;
import org.jsoup.select.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;

import java.util.List;
import com.google.appengine.api.datastore.PreparedQuery;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class UpdateCoursesServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		//
		// TOOD - do login (form display)
		//
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		boolean failSafe = false;
		while (!failSafe) {
			try {
				boolean isClass = false;
				String className = "";
				String instructor = "";
				String hours = "";
				String room = "";
				String units = "";
				String section = "";
				String days = "";
				String courseNumber = "";
				ArrayList<Course> parsedCourses = new ArrayList<Course>();
				Elements classes = new Elements();

				Document doc = Jsoup.connect("http://www4.uwm.edu/schedule/index.cfm?a1=subject_details&subject=COMPSCI&strm=2149").get();
				Elements table = doc.getElementsByTag("table");
				DatastoreService datastore = rostrUtilities.getDatastore();
				Query gaeQuery = new Query("course");
				PreparedQuery pq = datastore.prepare(gaeQuery);
				List<Entity> list = pq.asList(FetchOptions.Builder
						.withDefaults());
				for (Entity x : list) {
					datastore.delete(x.getKey());
				}
				for (Element element : table) {
					String elementHTML = element.toString();
					if (elementHTML.contains("COMPSCI")) {
						classes.add(element);
					}
				}
				classes.remove(0);
				for (Element course : classes) {
					for (Element child : course.getAllElements()) {
						if (child.tagName().equals("span")
								&& child.className().equals("subhead")) {
							className = child.html();
						} else if (child.tagName().equals("tr")
								&& child.className().equals("body copy")
								&& (child.attr("bgcolor").equals("#F4F4F4") || child
										.attr("bgcolor").equals("#ffffff"))) {
							Elements children = child.children();
							instructor = children.get(8).html();
							hours = children.get(5).html();
							room = children.get(9).html();
							units = children.get(2).html();
							section = children.get(3).html();
							days = children.get(6).html();
							courseNumber = children.get(4).html();
							Course newCourse = new Course(className,
									instructor, hours, room, units, section,
									days, courseNumber);
							if (section.indexOf("LEC") > -1 || section.indexOf("IND") > -1) {
								newCourse.isClass = true;
							}
							else{
								newCourse.setInstructor("");
							}
							parsedCourses.add(newCourse);
						}

					}
				}
				for(Course cCourse: parsedCourses){
					Entity e = rostrUtilities.createEntity("course");
					rostrUtilities.addCourseToDatastore(e, cCourse);
				}
				failSafe = true;
				rostrUtilities.redirect(resp, "/ADMIN/ADMIN_Classes.jsp");

			} catch (Exception e) {

			}
		}
	}
}
