package baitap;

public class coursedetail {
	public String courseID;
	public int studentID;
	public float grade;
	public coursedetail(String ID, int ID2) {
		this.courseID=ID;
		this.studentID=ID2;
		this.grade=-1;
	}
	public coursedetail(String ID, int ID2, float grade) {
		this.courseID=ID;
		this.studentID=ID2;
		this.grade=grade;
	}
	public String getCourse() {
		return this.courseID;
	}
	public int getStudent() {
		return this.studentID;
	}
	public float getGrade() {
		return this.grade;
	}
}
