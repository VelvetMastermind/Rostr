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
			ArrayList<String> errors = new ArrayList<String>();
			ArrayList<String> days = new ArrayList<String>();
			String username = "";
			String password = "";
			String pantherID = "";
			String roomNumber = "";
			String phoneNumber = "";
			String email = "";
			String skills = "";
			String officeHoursBegin = "";
			String officeHoursEnd = "";
			String monday = "";
			String tuesday = "";
			String wednesday= "";
			String thursday = "";
			String friday = "";
	        username = req.getParameter("fullName");
	        password = req.getParameter("newPassword");
	        pantherID = req.getParameter("pantherID");
	        email = req.getParameter("email"); 
	        roomNumber = req.getParameter("roomNumber");
	        phoneNumber = req.getParameter("phoneNumber");
			skills = req.getParameter("skills");
	        officeHoursBegin = req.getParameter("officeHoursBegin");
	        officeHoursEnd = req.getParameter("officeHoursEnd");
	        monday = req.getParameter("monday");
	        tuesday = req.getParameter("tuesday");
	        wednesday = req.getParameter("wednesday");
	        thursday = req.getParameter("thursday");
	        friday = req.getParameter("friday");
	        days.add(monday);
	        days.add(tuesday);
	        days.add(wednesday);
	        days.add(thursday);
	        days.add(friday);
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

	        success = rostrUtilities.addUserToDatastore(e, username, email, password, pantherID, roomNumber, phoneNumber, officeHoursBegin, officeHoursEnd, days, skills, iAccessLevel, ds);
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
