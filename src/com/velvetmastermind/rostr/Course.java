package com.velvetmastermind.rostr;

import java.util.ArrayList;

public class Course {
	private String className = "";
	private String instructor = "";
	private String hours = "";
	private String room = "";
	private String units = "";
	private String section = "";
	private String days = "";
	private ArrayList<String> teachingAssistants = new ArrayList<String>();
	
	public Course(String className, String instructor, String hours,
			String room, String units, String section, String days,
			ArrayList<String> teachingAssistants) {
		super();
		this.className = className;
		this.instructor = instructor;
		this.hours = hours;
		this.room = room;
		this.units = units;
		this.section = section;
		this.days = days;
		this.teachingAssistants = teachingAssistants;
	}
	

}
