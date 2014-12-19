package com.velvetmastermind.rostr;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

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
			String email = "";
			String officeHours = "";
			String skills = "";
	        username = req.getParameter("fullName");
	        password = req.getParameter("newPassword");
	        pantherID = req.getParameter("pantherID");
	        email = req.getParameter("email"); 
	        roomNumber = req.getParameter("roomNumber");
	        phoneNumber = req.getParameter("phoneNumber");
	        officeHours = req.getParameter("officeHours");
			skills = req.getParameter("skills");
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

	        success = rostrUtilities.addUserToDatastore(e, username, email, password, pantherID, roomNumber, phoneNumber, officeHours, skills, iAccessLevel, ds);
	        if(success)
	            rostrUtilities.redirect(resp, "LOGIN/LOGIN_addUserSuccess.jsp");
	        else
	            rostrUtilities.redirect(resp, "LOGIN/LOGIN_addUserFail.jsp");
	        
    	}
    	catch(Exception ex){
    		System.out.println("AddAdminServlet(doPost) exception.\n" + ex.getMessage());
    		rostrUtilities.redirect(resp, "LOGIN/LOGIN_LandingERROR.jsp");
    	}
    }
    
}
