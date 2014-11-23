package com.velvetmastermind.rostr;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;
import com.sun.org.apache.xalan.internal.xsltc.dom.ArrayNodeListIterator;

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
			ArrayList<String> errors = new ArrayList<>();
			String username = "";
			String password = "";
			String pantherID = "";
			String roomNumber = "";
			String phoneNumber = "";
			String officeHours = "";
	        username = req.getParameter("fullName");
	        password = req.getParameter("newPassword");
	        pantherID = req.getParameter("pantherID");
	        roomNumber = req.getParameter("roomNumber");
	        phoneNumber = req.getParameter("phoneNumber");
	        officeHours = req.getParameter("officeHours");
	        int iAccessLevel = -1;
	        boolean success = false;

			if(username.length() == 0)
				errors.add("Username is invalid!");
			if(password.length() < 6 || password.length() > 20)
				errors.add("Invalid password! (Password must be 6-20 characters long)");
			if(pantherID.length() == 0)
				errors.add("pantherID is invalid!");
	
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
