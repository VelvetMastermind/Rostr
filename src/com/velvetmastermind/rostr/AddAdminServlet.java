/**
 * Adds an admin to the datastore.
 * Used in beginning of production to have a login for
 * our web application.
 *
 * @author Andrew Budziszek
 */
package com.velvetmastermind.rostr;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;

@SuppressWarnings("serial")
public class AddAdminServlet extends HttpServlet
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
    		ArrayList<String> officeHours = new ArrayList<String>();
	        String username = "admin";
	        String password = "admin";
	        int iAccessLevel = 1;
	        boolean createdAdmin = false;
	
	        DatastoreService ds = rostrUtilities.getDatastore();
	        Entity e = rostrUtilities.createEntity("user"); 

	        createdAdmin = rostrUtilities.addUserToDatastore(e, username, "admin", password, "admin", "N/A", "N/A", "N/A", "THIS;THAT;THEM", officeHours,"N/A", iAccessLevel, ds); 
	        if(iAccessLevel != -1 && iAccessLevel != 1 && iAccessLevel != 2 && iAccessLevel != 3) 
	        {
	        	createdAdmin = false;
	        	System.out.println("AddAdminServlet(doPost) INVALID ACCESS LEVEL!"); 
	        }
	        if(createdAdmin)
	            resp.getWriter().println("Created administrator!");
	        else
	            resp.getWriter().println("Error creating administrator or administrator already exists...");
	        
    	}
    	catch(Exception ex){
    		System.out.println("AddAdminServlet(doPost) exception.");
    		rostrUtilities.redirect(resp, "LOGIN/LOGIN_LandingERROR.jsp");
    	}
    }
    
}
