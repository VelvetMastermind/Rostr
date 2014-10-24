package com.velvetmastermind.rostr;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet
{
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		//
		// TOOD - do login (form display)
		//
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		//
		// TODO - do login processing
		//
		String username = "";
		username = req.getParameter("username");
		String password = "";
		password = req.getParameter("password");

		boolean foundError = false;

		if (username.length() == 0 || password.length() == 0) {
			foundError = true;
		}

		DatastoreService ds = DatastoreServiceFactory.getDatastoreService(); 
		Entity e = new Entity("user");
		
		Query q = new Query("user");
		List<Entity> users = ds.prepare(q).asList(FetchOptions.Builder.withDefaults());
		Query usernameCheck = new Query("user").setFilter(new Query.FilterPredicate("username", FilterOperator.EQUAL, username));
		List<Entity> userCheck = ds.prepare(usernameCheck).asList(FetchOptions.Builder.withDefaults()); 
		if(userCheck.isEmpty()){
			foundError = true;
		}
		e = userCheck.get(0);
		if(password != e.getProperty("password"))
			foundError = true;
		
		
		if (foundError) {
			resp.sendRedirect("LOGIN/LOGIN_error.html");
		} else {
			//
			// TODO - Permissions handling
			//
			//if(permissions == 1 || 2 || etc....) then redirect correctly...
			resp.sendRedirect("ADMIN/ADMIN_Landing.html");
		}
		
	}
}
