import baitap.Coursecol;

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

public class Getcourse extends HttpServlet {
	
	@Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException{
        res.setContentType("text/html");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out =res.getWriter();
        try{
        	Class.forName("org.postgresql.Driver");
        	Connection conn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/management","postgres","password");
            if(conn!=null){
                List<Coursecol> list =new ArrayList<Coursecol>();
                PreparedStatement stmt=conn.prepareStatement("SELECT * FROM course");
                ResultSet rs=stmt.executeQuery();
                while (rs.next()){
                    Coursecol newcourse=new Coursecol(rs.getString("id"), rs.getString("name"), rs.getString("teacher"), rs.getInt("year"), rs.getString("notes"));
                    if (rs.wasNull()){
                        newcourse.notes="";
                    }
                    list.add(newcourse);
                }
                rs.close();
                stmt.close();
                conn.close();
                req.setAttribute("list", list);
            	req.getRequestDispatcher("index.jsp").forward(req,res);
            }
        }
        catch(Exception e)
           {
        	System.out.println("Error" + e);
            out.println("Error Trace in getConnection() : " + e);
           }
    }
	
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
            	Coursecol reqdata=new Coursecol(req.getParameter("id"), req.getParameter("name"),
            			req.getParameter("teacher"), Integer.parseInt(req.getParameter("year")), req.getParameter("notes"));
                PreparedStatement stmt=conn.prepareStatement("INSERT INTO course(id,name,teacher,year,notes)"
                		+ "VALUES (?,?,?,?,?)");
                stmt.setString(1, reqdata.getId());
                stmt.setString(2, reqdata.getName());
                stmt.setString(3, reqdata.getTeacher());
                stmt.setInt(4, reqdata.getYear());
                stmt.setString(5, reqdata.getNotes());
                stmt.executeUpdate();
                
                stmt.close();
                conn.close();
            	}
            	else if (req.getParameter("mode").equals("del")) {
            	PreparedStatement stmt=conn.prepareStatement("DELETE FROM course WHERE id=?");
            	stmt.setString(1,req.getParameter("id"));
            	stmt.executeUpdate();

            	stmt.close();
            	conn.close();
            	}
            	else {
            		PreparedStatement stmt=conn.prepareStatement("UPDATE course SET id=?,name=?,"
            				+ "teacher=?,year=?,notes=? WHERE id=?");
            		Coursecol reqdata=new Coursecol(req.getParameter("id"), req.getParameter("name"),
                			req.getParameter("teacher"), Integer.parseInt(req.getParameter("year")), req.getParameter("notes"));
            		stmt.setString(1, reqdata.getId());
                    stmt.setString(2, reqdata.getName());
                    stmt.setString(3, reqdata.getTeacher());
                    stmt.setInt(4, reqdata.getYear());
                    stmt.setString(5, reqdata.getNotes());
                    stmt.setString(6, req.getParameter("oldid"));
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
