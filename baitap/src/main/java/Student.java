import baitap.studentdetail;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Student
 */
public class Student extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Student() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out =res.getWriter();
        System.out.println("Got request");
        try{
        	Class.forName("org.postgresql.Driver");
        	Connection conn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/management","postgres","password");
            if(conn!=null){
                List<studentdetail> list =new ArrayList<studentdetail>();
                PreparedStatement stmt=conn.prepareStatement("SELECT * FROM student");
                ResultSet rs=stmt.executeQuery();
                while (rs.next()){
                    int id_temp=Integer.parseInt(rs.getString("id"));
                    String name_temp=rs.getString("name");
                    float grade_temp=rs.getFloat("grade");
                    if (rs.wasNull()) {
                    	grade_temp=-1;
                    }
                    String date_temp=rs.getString("birthday");
                    String address_temp=rs.getString("address");
                    String notes_temp=rs.getString("notes");
                    if (rs.wasNull()) {
                    	notes_temp="";
                    }
                    studentdetail newcourse = new studentdetail(id_temp,name_temp,grade_temp,date_temp,address_temp,notes_temp);
                    list.add(newcourse);
                }
                rs.close();
                stmt.close();
                conn.close();
                req.setAttribute("list", list);
            	req.getRequestDispatcher("student.jsp").forward(req,res);
            }
        }
        catch(Exception e)
           {
        	System.out.println("Error" + e);
            out.println("Error Trace in getConnection() : " + e);
           }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out =res.getWriter();
        try{
        	Class.forName("org.postgresql.Driver");
        	Connection conn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/management","postgres","password");
            if(conn!=null){
            	System.out.println(req.getParameter("mode"));
            	
            	if(req.getParameter("mode").equals("add")) {
            	studentdetail reqdata=new studentdetail(Integer.parseInt(req.getParameter("id")), req.getParameter("name"),
            			req.getParameter("birthday"), req.getParameter("address"),req.getParameter("notes"));
                PreparedStatement stmt=conn.prepareStatement("INSERT INTO student(id,name,birthday,address,notes)"
                		+ "VALUES (?,?,?::date,?,?)");
                stmt.setInt(1, reqdata.getId());
                stmt.setString(2, reqdata.getName());
                stmt.setString(3, reqdata.getBirthday());
                stmt.setString(4, reqdata.getAddress());
                stmt.setString(5, reqdata.getNotes());
                stmt.executeUpdate();
                
                stmt.close();
                conn.close();
            	}
            	
            	else if (req.getParameter("mode").equals("del")) {
            	PreparedStatement stmt=conn.prepareStatement("DELETE FROM student WHERE id=?");
            	stmt.setInt(1,Integer.parseInt(req.getParameter("id")));
            	stmt.executeUpdate();

            	stmt.close();
            	conn.close();
            	}
            	
            	else {
            		PreparedStatement stmt=conn.prepareStatement("UPDATE student SET id=?,name=?,"
            				+ "birthday=?::date,address=?,notes=? WHERE id=?");
            		studentdetail reqdata=new studentdetail(Integer.parseInt(req.getParameter("id")), req.getParameter("name"),
                			req.getParameter("birthday"), req.getParameter("address"),req.getParameter("notes"));
            		stmt.setInt(1, reqdata.getId());
                    stmt.setString(2, reqdata.getName());
                    stmt.setString(3, reqdata.getBirthday());
                    stmt.setString(4, reqdata.getAddress());
                    stmt.setString(5, reqdata.getNotes());
                    stmt.setInt(6, Integer.parseInt(req.getParameter("oldid")));
                    stmt.executeUpdate();
                    
                    stmt.close();
                    conn.close();
            	}
        	}
        }
        catch(Exception e)
           {
        	System.out.println("Error" + e);
            out.println("Error Trace in getConnection() : " + e);
           }
	}

}
