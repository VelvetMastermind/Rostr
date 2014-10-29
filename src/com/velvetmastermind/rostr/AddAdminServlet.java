package com.velvetmastermind.rostr;

import java.io.IOException;
import java.util.ArrayList;
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
public class AddAdminServlet extends HttpServlet
{
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
    {
    	resp.sendRedirect("LOGIN/LOGIN_Landing.html");
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException
    {
        String username = "admin";
        String password = "admin";
        boolean foundError = false;

        DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
        Entity e = new Entity("user");

        System.out.println("Creating admin...");
        Query q = new Query("user");
        Query usernameCheck = new Query("user").setFilter(new Query.FilterPredicate("username", FilterOperator.EQUAL, username));
        List<Entity> userCheck = ds.prepare(usernameCheck).asList(FetchOptions.Builder.withDefaults());
        if(!userCheck.isEmpty()) {
            System.out.println("Admin has already been created...");
            foundError = true;
        }
        if (foundError) {
            resp.sendRedirect("LOGIN/LOGIN_LandingERROR.html");
        } else {
            //
            // TODO - create administrator
            //
            e.setProperty("username", username);
            e.setProperty("password", password);
            ds.put(e);
            resp.getWriter().println("Created administrator!");
        }
    }

}
