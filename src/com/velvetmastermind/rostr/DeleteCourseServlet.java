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
public class DeleteCourseServlet extends HttpServlet
{
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		boolean bResult = false;
		bResult =  rostrUtilities.deleteCourse(req.getParameter("confirmDelete"));	
		if (!bResult) {
			rostrUtilities.redirect(resp, "ADMIN/ADMIN_ClassesDeleteError.jsp");
		} 
		else {
			rostrUtilities.redirect(resp, "/ADMIN/ADMIN_Classes.jsp");
		}
	}
}
