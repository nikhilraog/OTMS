package com.oil.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.sql.Result;
import javax.servlet.jsp.jstl.sql.ResultSupport;

/**
 * Servlet implementation class ManagerServlet
 */
@WebServlet("/manager")
public class ManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String mgr_query = "SELECT * FROM client_trader_transaction_history WHERE (date >= ? AND date <= ?)";
	Timestamp fromdate;
	Timestamp todate;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("data got frm jsp manger: "+ request.getParameter("fromdate").toString() + "to date: "+request.getParameter("todate"));

		
		try {
			
			
			Connection con1 = (Connection) getServletContext().getAttribute("DBConnection");

			PreparedStatement ps = null;
			ResultSet rs = null;
			
			@SuppressWarnings("unused")
			HttpSession session = request.getSession();
			
			String frm = request.getParameter("fromdate").toString() + " 00:00:00";
			String to = request.getParameter("todate").toString()+" 00:00:00";
			
			fromdate = Timestamp.valueOf(frm);
			todate = Timestamp.valueOf(to);
			
			ps = con1.prepareStatement(mgr_query);
			ps.setTimestamp(1, fromdate);
			ps.setTimestamp(2, todate);
			rs = ps.executeQuery();
			System.out.println("Result"+ rs.toString());
			
			Result result = ResultSupport.toResult(rs);
	        request.setAttribute("result", result);
	        RequestDispatcher rd = request.getRequestDispatcher("/manager_main.jsp");
	        rd.forward(request, response);
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
