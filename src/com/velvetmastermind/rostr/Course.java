package com.velvetmastermind.rostr;

public class Course {
	boolean isClass = false;
	private String className = "";
	private String instructor = "";
	private String hours = "";
	private String room = "";
	private String units = "";
	private String section = "";
	private String days = "";
	private String classNumber = "";
	
	public Course(String className, String instructor, String hours,
			String room, String units, String section, String days, String classNumber) {
		super();
		this.className = className;
		this.instructor = instructor;
		this.hours = hours;
		this.room = room;
		if(units.contains("&nbsp;"))
			units = "";
		this.units = units;
		this.section = section;
		this.days = days;
		this.classNumber = classNumber;
	}
	
	public String getClassNumber(){
		return this.classNumber;
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
    
    public void setClassNumber(String classNumber) {
        this.className = classNumber;
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
