package com.velvetmastermind.rostr;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@SuppressWarnings("serial")
public class AddContactServlet extends HttpServlet
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
