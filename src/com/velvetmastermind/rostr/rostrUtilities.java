package com.velvetmastermind.rostr;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;

public class rostrUtilities {
	
	public static Entity createEntity(String sName){
    	return new Entity(sName);
    }
	
	public static Query createQuery(String sLabel){
    	return new Query(sLabel); 
    }
	
	public static DatastoreService getDatastore(){
    	return DatastoreServiceFactory.getDatastoreService();
    }
	
	public static boolean userExists(String sUsername) {
    	boolean bResult = false;
    	DatastoreService ds = getDatastore();
    	
    	Query usernameCheck = new Query("user").setFilter(new Query.FilterPredicate("username", FilterOperator.EQUAL, sUsername));
        List<Entity> userCheck = ds.prepare(usernameCheck).asList(FetchOptions.Builder.withDefaults());
        if(!userCheck.isEmpty()) {
            System.out.println("Found user " + sUsername + "!");
            bResult = true;
        }
    	
    	return bResult;
    }
	
	public static boolean courseExists(String courseNumber) {
    	boolean bResult = false;
    	DatastoreService ds = getDatastore();
    	
    	Query usernameCheck = new Query("course").setFilter(new Query.FilterPredicate("courseNumber", FilterOperator.EQUAL, courseNumber));
        List<Entity> userCheck = ds.prepare(usernameCheck).asList(FetchOptions.Builder.withDefaults());
        if(!userCheck.isEmpty()) {
            System.out.println("Admin has already been created...");
            bResult = true;
        }
    	
    	return bResult;
    }
	
	public static String getPassword(String sUsername) {
		DatastoreService ds = getDatastore();
		
		Query usernameCheck = new Query("user").setFilter(new Query.FilterPredicate("username", FilterOperator.EQUAL, sUsername));
        List<Entity> userCheck = ds.prepare(usernameCheck).asList(FetchOptions.Builder.withDefaults());
        Entity e = userCheck.get(0);
        
        return (String)e.getProperty("password");        
	}
	
	public static boolean addUserToDatastore(Entity e, String sUsername, String sPassword, int iAccessLevel, DatastoreService ds) {
    	boolean bResult = false;
    	
    	try
    	{
    		if(userExists(sUsername))
    			throw new IllegalStateException("addUserToDatastore exception! user already exists..."); 
    		
    		e.setProperty("username", sUsername);
            e.setProperty("password", sPassword);
            if(iAccessLevel != 1 && iAccessLevel != 2 && iAccessLevel != 3)
            	throw new IllegalStateException("Invalid access level!(" + iAccessLevel + ")");
            e.setProperty("accessLevel", iAccessLevel);
            ds.put(e);
            bResult = true;
    	}
    	catch(Exception ex) 
    	{
    		System.out.println("rostrUtilities(addUserToDatastore) exception. Failed to add user to datastore...");
    		System.out.println(ex.getMessage()); 
    	}
    	
    	return bResult;
    }
	
	public static boolean addCourseToDatastore(Entity e, Course course) {
    	boolean bResult = false;
    	
    	try
    	{
    		DatastoreService ds = getDatastore();
    		courseExists(course.getClassNumber());
    		e.setProperty("className", course.getClassName());
            e.setProperty("instructor", course.getInstructor());
            e.setProperty("hours", course.getHours());
            e.setProperty("room", course.getRoom());
            e.setProperty("units", course.getUnits());
            e.setProperty("section", course.getSection());
            e.setProperty("days", course.getDays());
            ds.put(e);
            bResult = true;
    	}
    	catch(Exception ex) 
    	{
    		System.out.println("rostrUtilities(addUserToDatastore) exception. Failed to add user to datastore...");
    		System.out.println(ex.getMessage()); 
    	}
    	
    	return bResult;
    }
	
	public static void redirect(HttpServletResponse resp, String sPath) throws IOException {
		resp.sendRedirect(sPath);
	}

}
