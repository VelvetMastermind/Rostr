package com.google.appengine.tools.development.testing; 

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;

import static com.google.appengine.api.datastore.FetchOptions.Builder.withLimit;

import com.google.appengine.api.datastore.Query;
import com.google.appengine.tools.development.testing.LocalDatastoreServiceTestConfig;
import com.google.appengine.tools.development.testing.LocalServiceTestHelper;
import com.velvetmastermind.rostr.Course;
import com.velvetmastermind.rostr.rostrUtilities;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class LocalDatastoreTest {

    private final LocalServiceTestHelper helper =
        new LocalServiceTestHelper(new LocalDatastoreServiceTestConfig());

    @Before
    public void setUp() {
        helper.setUp();
    }

    @After
    public void tearDown() {
        helper.tearDown();
    }

    // run this test twice to prove we're not leaking any state across tests
    private void doTest() {
        DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
        assertEquals(0, ds.prepare(new Query("yam")).countEntities(withLimit(10)));
        ds.put(new Entity("yam"));
        ds.put(new Entity("yam"));
        assertEquals(2, ds.prepare(new Query("yam")).countEntities(withLimit(10)));
    }
    
	@Test
	public void testadduser() {
		DatastoreService ds = rostrUtilities.getDatastore();
		Entity e = new Entity("user");
		
		String sUsername = "testUser00";
		String sPassword = "testPass";
		int iAccessLevel = 1;
		
		//Adding user 0
		e.setProperty("username", "testUser01");
        e.setProperty("password", "testPass");
        e.setProperty("accessLevel", 1);
        ds.put(e);
		
		
		
		//Adding user 1
		e.setProperty("username", sUsername);
        e.setProperty("password", sPassword);
        e.setProperty("accessLevel", iAccessLevel);
        ds.put(e);
        
    	
    	assertFalse("addUser should've returned false1...", com.velvetmastermind.rostr.rostrUtilities.addUserToDatastore(e, sUsername, sPassword, 1, ds));
    	assertFalse("addUser should've returned false", com.velvetmastermind.rostr.rostrUtilities.addUserToDatastore(e, sUsername, sPassword, iAccessLevel, ds));
    	assertFalse("addUser should've returned false", com.velvetmastermind.rostr.rostrUtilities.addUserToDatastore(e, sUsername, "ha", iAccessLevel, ds));
    	assertTrue("addUser should be true", com.velvetmastermind.rostr.rostrUtilities.addUserToDatastore(e, "testjames", "testpassword", 1, ds));
    	assertTrue("addUser should be true again duh", com.velvetmastermind.rostr.rostrUtilities.addUserToDatastore(e, "testjames2", "testpasswordagain", 1, ds));
    	assertTrue("addUser should be true for the third time", com.velvetmastermind.rostr.rostrUtilities.addUserToDatastore(e, "testjames3", "testpasswordlast", 1, ds));
	}
	
	@Test
	public void testaddcourse()
	{
		
		DatastoreService ds = rostrUtilities.getDatastore();
		Entity e = new Entity("course");
		Entity ee = new Entity("course");
		Entity eee = new Entity("course");
		
		
		 String TclassName = "h";
		 String Tinstructor = "h";
		 String Thours = "h";
		 String Troom = "h";
		 String Tunits = "h";
		 String Tsection = "h";
		String Tdays = "h";
		 String TclassNumber = "z"; 
		 
		 
		 e.setProperty("className", TclassName);
         e.setProperty("instructor", Tinstructor);
         e.setProperty("hours", Thours);
         e.setProperty("room", Troom);
         e.setProperty("units", Tunits);
         e.setProperty("section", Tsection);
         e.setProperty("days", Tdays);
         e.setProperty("courseNumber", TclassNumber);
         ds.put(e);
		
		
		Course testCourse1 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, TclassNumber);
		Course testCourse2 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "5");
		Course testCourse3 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "x");
		Course testCourse4 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, TclassNumber);
		Course testCourse5 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "a");
		Course testCourse6 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "b");
		Course testCourse7 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "c");
		Course testCourse8 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "d");
		Course testCourse9 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "e");
		Course testCourse10 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "f");
		Course testCourse11 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "g");
		Course testCourse12 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "h");
		Course testCourse13 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "i");
		Course testCourse14 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "j");
		Course testCourse15 = new Course(TclassName, Tinstructor, Thours, Troom, Tunits, Tsection, Tdays, "k");
		
		
		
		
		//com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse2);
		
		assertFalse("addCourse should be false0", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse1 ));
		assertTrue("addCourse should be true1", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse3 ));
		assertTrue("addCourse should be true2", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(ee,testCourse2 ));
		assertFalse("addCourse should be false1", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse2 ));
		assertFalse("addCourse should be false2", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse3 ));
		
		assertTrue("addCourse should be true3", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse4 ));
		assertFalse("addCourse should be false3", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse4 ));
		
		assertTrue("addCourse should be true4", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse5 ));
		assertFalse("addCourse should be false4", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse5 ));	
		
		assertTrue("addCourse should be true5", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse6 ));
		assertFalse("addCourse should be false5", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse6 ));
		
		assertTrue("addCourse should be true6", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse7 ));
		assertFalse("addCourse should be false6", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse7 ));
		
		assertTrue("addCourse should be true7", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse8 ));
		assertFalse("addCourse should be false7", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse8 ));
		
		assertTrue("addCourse should be true8", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse9 ));
		assertFalse("addCourse should be false8", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse9 ));
		
		assertTrue("addCourse should be true9", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse10 ));
		assertFalse("addCourse should be false9", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse10 ));
		
		assertTrue("addCourse should be true10", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse11 ));
		assertFalse("addCourse should be false10", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse11 ));
		
		assertTrue("addCourse should be true11", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse12 ));
		assertFalse("addCourse should be false11", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse12 ));
		
		assertTrue("addCourse should be true12", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse13 ));
		assertFalse("addCourse should be false12", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse13 ));
		
		assertTrue("addCourse should be true13", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse14 ));
		assertFalse("addCourse should be false13", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse14 ));
		
		assertTrue("addCourse should be true14", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse15 ));
		assertFalse("addCourse should be false14", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse15 ));
		
		assertTrue("addCourse should be true15", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse4 ));
		assertFalse("addCourse should be false15", com.velvetmastermind.rostr.rostrUtilities.addCourseToDatastore(e,testCourse4 ));
	
	}

    @Test
    public void testInsert1() {
        doTest();
    }

    @Test
    public void testInsert2() {
        doTest();
    }
}