package com.oil.serv.listener;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.oil.utd.util.DBMgr;
 
@WebListener
public class AppContextListener implements ServletContextListener {
 
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        //To handle app context
    	ServletContext ctx = servletContextEvent.getServletContext();
         
        //initialize DB Connection
        // with user name and password
        String dbURL = ctx.getInitParameter("dbURL");
        String user = ctx.getInitParameter("dbUser");
        String pwd = ctx.getInitParameter("dbPassword");
         
        try {
            DBMgr connectionManager = new DBMgr(dbURL, user, pwd);
            ctx.setAttribute("DBConnection", connectionManager.getConnection());
            System.out.println("Database connection initialized successfully.");
        } 
        catch (ClassNotFoundException e) {
            System.out.println("Error in app context");
        	e.printStackTrace();
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
         
       
       
    }
 
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        Connection con = (Connection) servletContextEvent.getServletContext().getAttribute("DBConnection");
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
     
}