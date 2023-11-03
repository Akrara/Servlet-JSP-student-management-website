import baitap.studentgrade;

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
 * Servlet implementation class grade
 */
public class grade extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public grade() {
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
            	int studentID=Integer.parseInt(req.getParameter("studentid"));
                List<studentgrade> list =new ArrayList<studentgrade>();
                PreparedStatement stmt=conn.prepareStatement("SELECT coursedetail.id AS id,course.name AS name,coursedetail.grade AS grade"
                		+ " FROM coursedetail JOIN course ON coursedetail.id=course.id WHERE coursedetail.studentid = ?");
                stmt.setInt(1, studentID);
                ResultSet rs=stmt.executeQuery();
                int studentid_temp=Integer.parseInt(req.getParameter("studentid"));
                while (rs.next()){
                	String id_temp=rs.getString("id");
                    String name_temp=rs.getString("name");
                    out.println("fine");
                    float grade_temp=rs.getFloat("grade");
                    if (rs.wasNull()) {
                    	grade_temp=-1;
                    }
                    out.println("fine");
                    studentgrade newgrade=new studentgrade(id_temp,name_temp,grade_temp);
                	list.add(newgrade);
                }
                rs.close();
                stmt.close();
                conn.close();
                req.setAttribute("list", list);
                req.setAttribute("studentid", studentid_temp);
            	req.getRequestDispatcher("grade.jsp").forward(req,res);
            }
        }
        catch(Exception e)
           {
        	System.out.println("Error " + e);
            out.println("Error Trace in getConnection() : " + e);
           }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
