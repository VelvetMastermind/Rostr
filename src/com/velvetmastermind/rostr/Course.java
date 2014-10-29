package com.velvetmastermind.rostr;

import java.util.ArrayList;

public class Course {
	boolean isClass = false;
	private String className = "";
	private String instructor = "";
	private String hours = "";
	private String room = "";
	private String units = "";
	private String section = "";
	private String days = "";
	
	public Course(String className, String instructor, String hours,
			String room, String units, String section, String days) {
		super();
		this.className = className;
		this.instructor = instructor;
		this.hours = hours;
		this.room = room;
		this.units = units;
		this.section = section;
		this.days = days;
	}

    public String getClassName(){
        return this.className;
    }

    public String getInstructor(){
        return this.instructor;
    }

    public String getHours(){
        return this.hours;
    }

    public boolean isClass() {
        return isClass;
    }

    public String getRoom() {
        return room;
    }

    public String getUnits() {
        return units;
    }

    public String getSection() {
        return section;
    }

    public String getDays() {
        return days;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public void setHours(String hours) {
        this.hours = hours;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public void setUnits(String units) {
        this.units = units;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public void setDays(String days) {
        this.days = days;
    }
}
