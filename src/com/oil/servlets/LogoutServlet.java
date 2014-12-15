package com.oil.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LogoutServlet() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html");
		 System.out.println("Logged out");
	        Cookie[] cookies = request.getCookies();
	        if(cookies != null){
	        for(Cookie cookie : cookies){
	            if(cookie.getName().equals("JSESSIONID")){
	               // logger.info("JSESSIONID="+cookie.getValue());
	                break;
	            }
	        }
	        }
	        //invalidate the session if exists
	        HttpSession session = request.getSession(false);
	        //logger.info("User="+session.getAttribute("User"));
	        if(session != null){
	            session.invalidate();
	        }
	        response.sendRedirect("index.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
