package com.velvetmastermind.rostr;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;

@SuppressWarnings("serial")
public class AddNewUserServlet extends HttpServlet
{
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
    {
    	rostrUtilities.redirect(resp, "LOGIN/LOGIN_Landing.jsp");
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException
    {
    	try
    	{
	        String username = req.getParameter("fullName");
	        String password = req.getParameter("newPassword");
	        String pantherID = req.getParameter("pantherID");
	        String roomNumber = req.getParameter("roomNumber"); 
	        String phoneNumber = req.getParameter("phoneNumber");
	        String officeHours = req.getParameter("officeHours");
	        int iAccessLevel = -1;
	        boolean success = false;
	
	        DatastoreService ds = rostrUtilities.getDatastore();
	        Entity e = rostrUtilities.createEntity("user"); 

	        success = rostrUtilities.addUserToDatastore(e, username, password, pantherID, roomNumber, phoneNumber, officeHours, iAccessLevel, ds);
	        if(success)
	            resp.getWriter().println("Created user!");
	        else
	            resp.getWriter().println("Error creating user or user already exists...");
	        
    	}
    	catch(Exception ex){
    		System.out.println("AddAdminServlet(doPost) exception.");
    		rostrUtilities.redirect(resp, "LOGIN/LOGIN_LandingERROR.jsp");
    	}
    }
    
}
