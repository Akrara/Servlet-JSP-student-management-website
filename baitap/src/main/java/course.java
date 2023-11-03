import baitap.coursedetail;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class course
 */
public class course extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public course() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out =res.getWriter();
        try{
        	Class.forName("org.postgresql.Driver");
        	Connection conn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/management","postgres","password");
            if(conn!=null){
            	String courseId=req.getParameter("id");
                List<coursedetail> list =new ArrayList<coursedetail>();
                PreparedStatement stmt=conn.prepareStatement("SELECT * FROM coursedetail WHERE id = ?");
                stmt.setString(1, courseId);
                ResultSet rs=stmt.executeQuery();
                String id_temp="";
                while (rs.next()){
                    id_temp=rs.getString("id");
                    int student_id_temp=Integer.parseInt(rs.getString("studentid"));
                    int grade_temp=rs.getInt("grade");
                    if (rs.wasNull()) {
                    	grade_temp=-1;
                    }
                    coursedetail newcourse = new coursedetail(id_temp,student_id_temp,grade_temp);
                    list.add(newcourse);
                }
                if (id_temp=="") {
                	stmt=conn.prepareStatement("SELECT id from course WHERE id=?");
                	stmt.setString(1, courseId);
                	rs=stmt.executeQuery();
                	while (rs.next()) {
                		id_temp=rs.getString("id");
                	}
                }
                rs.close();
                stmt.close();
                conn.close();
                req.setAttribute("list", list);
                req.setAttribute("courseid", id_temp);
            	req.getRequestDispatcher("course.jsp").forward(req,res);
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
	            	coursedetail reqdata=new coursedetail(req.getParameter("id"), Integer.parseInt(req.getParameter("studentid")),Float.parseFloat(req.getParameter("grade")));
	                PreparedStatement stmt;
	            	if (reqdata.getGrade()<0) {
	                	stmt=conn.prepareStatement("INSERT INTO coursedetail(id,studentid)"
	                			+ "VALUES (?,?)");
	                	stmt.setString(1, reqdata.getCourse());
	                	stmt.setInt(2,reqdata.getStudent());
	                }
	            	else {
		            	stmt=conn.prepareStatement("INSERT INTO coursedetail(id,studentid,grade)"
		                		+ "VALUES (?,?,?)");
		                stmt.setString(1, reqdata.getCourse());
		                stmt.setInt(2, reqdata.getStudent());
		                stmt.setFloat(3, reqdata.getGrade());
	            	}
	                stmt.executeUpdate();
	               
	                stmt.close();
            	}
            	
            	else if (req.getParameter("mode").equals("del")) {
	            	PreparedStatement stmt=conn.prepareStatement("DELETE FROM coursedetail WHERE id=? AND studentid=?");
	            	stmt.setString(1,req.getParameter("id"));
	            	stmt.setInt(2, Integer.parseInt(req.getParameter("studentid")));
	            	stmt.executeUpdate();
	
	            	stmt.close();
            	}
            	
            	else {
            		coursedetail reqdata=new coursedetail(req.getParameter("id"), Integer.parseInt(req.getParameter("oldid")),Float.parseFloat(req.getParameter("grade")));
            		PreparedStatement stmt=conn.prepareStatement("UPDATE student SET id=? WHERE id=?");
            		stmt.setInt(1, Integer.parseInt(req.getParameter("studentid")));
            		stmt.setInt(2, reqdata.getStudent());
            		stmt.executeUpdate();
            		stmt.close();
            		if(reqdata.getGrade()<0) {

            		}
            		else {
            			stmt=conn.prepareStatement("UPDATE coursedetail SET "
            					+ "grade=? WHERE id=? AND studentid=?");
            			stmt.setFloat(1, reqdata.getGrade());
            			stmt.setString(2, reqdata.getCourse());
            			stmt.setInt(3, Integer.parseInt(req.getParameter("studentid")));
            			stmt.executeUpdate();
            			stmt.close();
            		}
            	}
            	System.out.println("OK");
            	
                PreparedStatement stmt=conn.prepareStatement("UPDATE student SET grade = (SELECT AVG(coursedetail.grade) FROM coursedetail WHERE coursedetail.studentid = ?) WHERE id = ?");
                stmt.setInt(1, Integer.parseInt(req.getParameter("studentid")));
                stmt.setInt(2, Integer.parseInt(req.getParameter("studentid")));
                stmt.executeUpdate();
                stmt.close();
                conn.close();
        	}
        }
        catch(Exception e)
           {
        	System.out.println("Error" + e);
            out.println("Error Trace in getConnection() : " + e);
           }
	}

}
