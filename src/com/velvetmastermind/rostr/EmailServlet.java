package com.velvetmastermind.rostr;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@SuppressWarnings("serial")
public class EmailServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		String [] idividualEmails;
		String individualEmailInput = req.getParameter("emailRecipients");
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		String msgBody = req.getParameter("sendMessage");
		String groupRecipients = req.getParameter("groupRecipients");
		if (groupRecipients != null) {
			if (groupRecipients.equals("0")) {
				DatastoreService ds = rostrUtilities.getDatastore();
				Query gaeQuery = new Query("user");
				PreparedQuery pq = ds.prepare(gaeQuery);
				List<Entity> list = pq.asList(FetchOptions.Builder
						.withDefaults());
				for (Entity user : list) {
					String recipientEmail = (String) user.getProperty("email");
					try {
						Message msg = new MimeMessage(session);
						msg.setFrom(new InternetAddress("velvetmastermind@gmail.com", "Rostr"));
						msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
						msg.setSubject("Rostr Administration: Attention Required");
						msg.setText(msgBody);
						Transport.send(msg);
					} catch (AddressException ex) {

					} catch (MessagingException ex) {

					}
				}
			} else if (groupRecipients.equals("1")) {
				DatastoreService ds = rostrUtilities.getDatastore();
				Query gaeQuery = new Query("user");
				PreparedQuery pq = ds.prepare(gaeQuery);
				List<Entity> list = pq.asList(FetchOptions.Builder
						.withDefaults());
				for (Entity user : list) {
					Long accessLevel = (Long) user.getProperty("accessLevel");
					if(accessLevel == 1){
						String recipientEmail = (String) user.getProperty("email");
						try {
							Message msg = new MimeMessage(session);
							msg.setFrom(new InternetAddress("velvetmastermind@gmail.com", "Rostr"));
							msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
							msg.setSubject("Rostr Administration: Attention Required");
							msg.setText(msgBody);
							Transport.send(msg);
						} catch (AddressException ex) {

						} catch (MessagingException ex) {

						}
					}
				}
			} else if (groupRecipients.equals("2")) {
				DatastoreService ds = rostrUtilities.getDatastore();
				Query gaeQuery = new Query("user");
				PreparedQuery pq = ds.prepare(gaeQuery);
				List<Entity> list = pq.asList(FetchOptions.Builder
						.withDefaults());
				for (Entity user : list) {
					Long accessLevel = (Long) user.getProperty("accessLevel");
					if(accessLevel == 2){
						String recipientEmail = (String) user.getProperty("email");
						try {
							Message msg = new MimeMessage(session);
							msg.setFrom(new InternetAddress("velvetmastermind@gmail.com", "Rostr"));
							msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
							msg.setSubject("Rostr Administration: Attention Required");
							msg.setText(msgBody);
							Transport.send(msg);
						} catch (AddressException ex) {

						} catch (MessagingException ex) {

						}
					}
				}
			}
		}
		if(!individualEmailInput.equals("")){
			idividualEmails = individualEmailInput.split(";");
			for(int i=0; i<idividualEmails.length; ++i){
				try {
					Message msg = new MimeMessage(session);
					msg.setFrom(new InternetAddress("velvetmastermind@gmail.com", "Rostr"));
					msg.addRecipient(Message.RecipientType.TO, new InternetAddress(idividualEmails[i]));
					msg.setSubject("Rostr Administration: Attention Required");
					msg.setText(msgBody);
					Transport.send(msg);
				} catch (AddressException ex) {

				} catch (MessagingException ex) {

				}
			}
		}
		resp.sendRedirect("ADMIN/ADMIN_Landing.jsp");
	}
}