package com.velvetmastermind.rostr;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;

@SuppressWarnings("serial")
public class EditCourseServlet extends HttpServlet
{
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		//
		// TODO - do login processing
		//
		String className = req.getParameter("assignClassName");
		String instructor = req.getParameter("assignInstructor");
		String hours = req.getParameter("assignTime");
		String room = req.getParameter("assignRoom");
		String units = "";
		String section = req.getParameter("assignSection");
		String days = req.getParameter("assignDays");
		String classNumber = req.getParameter("assignNumber");
		
		Course editCourse = new Course(className, instructor, hours, room, units, section, days, classNumber);
		boolean foundError = false;
		if(!rostrUtilities.courseExists(classNumber)){
			foundError = true;
		}	
		if (foundError) {
			//rostrUtilities.redirect(resp, "ADMIN_ContactsError.jsp");
		} 
		else {
			//
			// TODO - Permissions handling
			//
			//if(permissions == 1 || 2 || etc....) then redirect correctly...
			DatastoreService ds = rostrUtilities.getDatastore();
			Query gaeQuery = new Query("course");
			PreparedQuery pq = ds.prepare(gaeQuery);
			List<Entity> list = pq.asList(FetchOptions.Builder
					.withDefaults());
			for (Entity x : list) {
				if(x.getProperty("courseNumber").equals(classNumber)){
					ds.delete(x.getKey());
				}
			}
			Entity e = rostrUtilities.createEntity("course");
			rostrUtilities.addCourseToDatastore(e, editCourse);
			rostrUtilities.redirect(resp, "/ADMIN/ADMIN_Classes.jsp");
			
		}
	}
}
