package baitap;

public class Coursecol{
    public String id;
    public String name;
    public String teacher;
    public int year;
    public String notes;
    public String getId()
    {
    	return this.id;
    }
    public String getName() {
    	return this.name;
    }
    public String getTeacher() {
    	return this.teacher;
    }
    public int getYear() {
    	return this.year;
    }
    public String getNotes() {
    	return this.notes;
    }
    public Coursecol() {
    	
    }
    public Coursecol(String id, String name, String lecturer, int year, String notes){
        this.id=id;
        this.name=name;
        this.teacher=lecturer;
        this.year=year;
        this.notes=notes;
    }
}
