package com.velvetmastermind.rostr;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.search.Query;
import com.google.appengine.api.urlfetch.FetchOptions;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query.FilterOperator;
import java.util.Arrays;
import java.util.List;

@SuppressWarnings("serial")
public class EditProfile extends HttpServlet
{
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
    {
        rostrUtilities.redirect(resp, "ADMIN/ADMIN_Landing.jsp");
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

            DatastoreService datastore = rostrUtilities.getDatastore();
            com.google.appengine.api.datastore.Query gaeQuery = new com.google.appengine.api.datastore.Query("user");
            PreparedQuery pq = datastore.prepare(gaeQuery);
            List<Entity> list = pq.asList(com.google.appengine.api.datastore.FetchOptions.Builder.withDefaults());
            Entity currentUser = null;
            String name = "";

            for(Entity user: list)
            {
                if(user.getProperty("pantherID").equals(pantherID)) {
                    currentUser = user;
                    datastore.delete(user.getKey());
                    break;
                }
            }
            datastore = rostrUtilities.getDatastore();
            if(currentUser != null) {
                if(rostrUtilities.addUserToDatastore(currentUser, username, email, currentUser.getProperty("password").toString(), pantherID, roomNumber, phoneNumber, officeHoursBegin, officeHoursEnd, days, skills, Integer.parseInt(currentUser.getProperty("accessLevel").toString()), rostrUtilities.getDatastore()))
                    success = true;
            }

            if(success)
                rostrUtilities.redirect(resp, "ADMIN/ADMIN_MyProfile.jsp?success=yes");
            else
                rostrUtilities.redirect(resp, "ADMIN/ADMIN_MyProfile.jsp?success=no");

        }
        catch(Exception ex){
            System.out.println("AddAdminServlet(doPost) exception.\n" + ex.getMessage());
            rostrUtilities.redirect(resp, "LOGIN/LOGIN_LandingERROR.jsp");
        }
    }

}
