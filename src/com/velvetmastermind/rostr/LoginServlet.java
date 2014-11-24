package com.velvetmastermind.rostr;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet
{
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		//
		// TODO - do login processing
		//
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		boolean foundError = false;
		boolean userExists = false;

		if (!validUsername(username) || !validPassword(password)) {
			foundError = true;
		}
		
		userExists = rostrUtilities.userExists(username); 
		if(!userExists)
		{
			foundError = true;
			System.out.println("LoginServlet(doPost) Username does not exist...");
		}
		else if(!password.equals(rostrUtilities.getPassword(username)))
		{
			foundError = true;
			System.out.println("Password is incorrect...");
		}
			
		if (foundError || (rostrUtilities.getAccessLevel(username) != 0)) {
			rostrUtilities.redirect(resp, "LOGIN/LOGIN_LandingERROR.jsp");
		} 
		else {
			//
			// TODO - Permissions handling
			//
			//if(permissions == 1 || 2 || etc....) then redirect correctly...
			rostrUtilities.redirect(resp, "ADMIN/ADMIN_Landing.jsp");
		}
	}
	
	private boolean validUsername(String sUsername) {
		boolean bResult = false;
		
		try
		{
			bResult = true;
			if(sUsername.length() == 0) {
				System.out.println("LoginServlet(validPassword) Invalid password...");
				bResult = false;
			}
		}
		catch(Exception ex)
		{
			System.out.println("LoginServlet(validUsername) exception.\n" + ex.getMessage());
		}
		
		return bResult; 
	}
	
	private boolean validPassword(String sPassword) {
		boolean bResult = false;
		
		try
		{
			bResult = true;
			if(sPassword.length() == 0) {
				bResult = false;
				System.out.println("LoginServlet(validPassword) Invalid password...");
			}
		}
		catch(Exception ex)
		{
			System.out.println("LoginServlet(validPassword) exception. \n" + ex.getMessage());
		}
		
		return bResult; 
	}
}
