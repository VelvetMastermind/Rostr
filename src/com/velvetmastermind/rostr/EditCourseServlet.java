package com.velvetmastermind.rostr;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.appengine.api.datastore.Entity;
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
		boolean bResult = false;
		Course editCourse = rostrUtilities.getCourse(req.getParameter("assignNumber"));	
		if (editCourse==null) {
			rostrUtilities.redirect(resp, "ADMIN/ADMIN_ClassesError.jsp");
		} 
		else {
			rostrUtilities.deleteCourse(editCourse.getClassNumber());
			try{Thread.sleep(3);}catch(Exception e){}
			editCourse.setClassName(req.getParameter("assignClassName"));
			editCourse.setInstructor(req.getParameter("assignInstructor"));
			editCourse.setHours(req.getParameter("assignTime"));
			editCourse.setRoom(req.getParameter("assignRoom"));
			editCourse.setUnits(req.getParameter("assignUnits"));
			editCourse.setSection(req.getParameter("assignSection"));
			editCourse.setDays(req.getParameter("assignDays"));
			editCourse.setClassNumber(req.getParameter("assignNumber"));
			Entity e = rostrUtilities.createEntity("course");
			while(!bResult){
				bResult = rostrUtilities.addCourseToDatastore(e, editCourse);
			}
			try{Thread.sleep(3);}catch(Exception p){}
			rostrUtilities.redirect(resp, "/ADMIN/ADMIN_Classes.jsp");
			
		}
	}
}
