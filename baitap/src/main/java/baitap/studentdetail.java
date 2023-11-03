package baitap;
public class studentdetail {
	public int id;
	public String name;
	public float grade;
	public String birthday;
	public String address;
	public String notes;
	public studentdetail(int id,String name,
			float grade,String birthday,String address,String notes) {
		this.id=id;
		this.name=name;
		this.grade=grade;
		this.birthday=birthday;
		this.address=address;
		this.notes=notes;
	}
	public studentdetail(int id,String name, String birthday,String address, String notes) {
		this.id=id;
		this.name=name;
		this.grade=-1;
		this.birthday=birthday;
		this.address=address;
		this.notes=notes;
	}
    public int getId()
    {
    	return this.id;
    }
    public String getName() {
    	return this.name;
    }
    public float getGrade() {
    	return this.grade;
    }
    public String getAddress() {
    	return this.address;
    }
    public String getBirthday() {
    	return this.birthday;
    }
    public String getNotes() {
    	return this.notes;
    }
}
