package com.velvetmastermind.rostr;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;

@SuppressWarnings("serial")
public class ApprovePendingUserServlet extends HttpServlet
{
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
    {
    	rostrUtilities.redirect(resp, "ADMIN/ADMIN_Landing.jsp");
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException
    {
    	boolean error = false;
    	DatastoreService ds = rostrUtilities.getDatastore(); 
    	
    	try
    	{
    		Entity user = rostrUtilities.getUserByUsername(req.getParameter("confirmApprove"));
    		int newAccessLevel = Integer.parseInt(req.getParameter("newAccessLevel")); 
    		
    		if(user == null)
    			error = true;
    		else{
    			user.setProperty("accessLevel", newAccessLevel);
    			ds.put(user); 
    		}
	        
	        if(error)
	        	rostrUtilities.redirect(resp, "ADMIN/ADMIN_PendingUsersError.jsp");
	        else
	        	rostrUtilities.redirect(resp, "ADMIN/ADMIN_PendingUsersSuccess.jsp");
	        
    	}
    	catch(Exception ex){
    		System.out.println("AddAdminServlet(doPost) exception.");
    		rostrUtilities.redirect(resp, "ADMIN/ADMIN_PendingUsersError.jsp");
    	}
    }
    
}
