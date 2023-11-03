package baitap;

public class studentgrade {
	public String id;
	public String name;
	public float grade;
	public studentgrade(String id, String name, float grade) {
		this.id=id;
		this.name=name;
		this.grade=grade;
	}
	public String getID() {
		return this.id;
	}
	public String getName() {
		return this.name;
	}
	public float getGrade() {
		return this.grade;
	}
}
