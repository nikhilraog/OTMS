package com.oil.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oil.utd.util.Login;

/**
 * Servlet implementation class LoginServlet
 */

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	int client_id;
	int trader_id;
	String trader_name;
	private static final long serialVersionUID = 1L;
	Connection con = null;
    
	public LoginServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String userid = request.getParameter("user");
		String password = request.getParameter("pwd");
		int role;
		System.out.println(request.getParameter("user") + " "
				+ request.getParameter("pwd"));

		con = (Connection) getServletContext().getAttribute(
				"DBConnection");
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		ResultSet rs2 = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select USERID, PASSWORD, ROLEID from login where USERID=? and PASSWORD=MD5(?) limit 1");
			ps.setString(1, userid);
			ps.setString(2, password);
			rs = ps.executeQuery();

			if (rs != null && rs.next()) {
				Login l = new Login();
				l.setUserid(rs.getString(1));
				role = rs.getInt(3);
				l.setRoleid(rs.getInt(3));
				System.out.println("Logged User: " + l.toString()
						+ "Client id : ");
				HttpSession session = request.getSession(true);
				session.setAttribute("User", userid);
				if (role == 1) {
					System.out.println("here"+role);
					ps2 = con.prepareStatement("select id from client where userid=?");
					ps2.setString(1, userid);
					rs2 = ps2.executeQuery();
					if(rs2!=null && rs2.next()){
						client_id = Integer.parseInt(rs2.getString(1));
						session.setAttribute("Client_name", rs2.getString(1));
						System.out.println(rs2.getString(1));
					}
					
					//String q2 = "select priceperbarrel from inventory";
					//double ppb;
					ps = con.prepareStatement("select priceperbarrel from inventory limit 1");
					rs = ps.executeQuery();
					if(rs!=null && rs.next()){
						System.out.println("Price Ber Barrel"+rs.getDouble(1));
						session.setAttribute("ppb", rs.getDouble(1));
					}
					
					String q5 = "select comrate from clienttype c,belongsto b where b.clientid=(?) and c.category = b.category";
					ps = con.prepareStatement(q5);
					ps.setInt(1, client_id);
					rs = ps.executeQuery();
					if(rs!=null && rs.next()){
						session.setAttribute("com_rate", rs.getDouble(1));
					}
					
					
					String q6 = "select id,name from trader";
					ArrayList<String> traderList = new ArrayList<String>();
					ps = con.prepareStatement(q6);
					rs = ps.executeQuery();
					while(rs!=null && rs.next()){
					traderList.add(rs.getString(2));
					//String trader_name = rs.getString(2);
					//System.out.println("Trader neme: "+trader_name);
					}
					
					request.setAttribute("availabtraders", traderList);
					System.out.println("Trader names: "+traderList.toString());
					
					String q3 = "select oilbalance, cashbalance from client where id=(?) limit 1";
					ps = con.prepareStatement(q3);
					ps.setInt(1, client_id);
					rs = ps.executeQuery();
					if(rs!=null && rs.next()){
					 
					session.setAttribute("oil_balance", rs.getString(1));
					session.setAttribute("cash_balance", rs.getString(2));
					System.out.println("Oil bal "+rs.getString(1));
					//response.sendRedirect("home.jsp");
					response.sendRedirect("client_home.jsp");
					}
					
					
					
				} else if (role == 2) {
					
					
					ps2 = con.prepareStatement("select id from trader where userid=?");
					ps2.setString(1, userid);
					rs2 = ps2.executeQuery();
					if(rs2!=null && rs2.next()){
						trader_id = Integer.parseInt(rs2.getString(1));
						session.setAttribute("trader_id", rs2.getString(1));
						System.out.println(rs2.getString(1));
					}
					response.sendRedirect("trader.jsp");
					
				}
				
				else if (role == 3) {
					response.sendRedirect("manager_main.jsp");
				}
			} else {
				RequestDispatcher rd = getServletContext()
						.getRequestDispatcher("/index.jsp");
				PrintWriter out = response.getWriter();
				out.println("<font color=red>No user found with given email id, please register first.</font>");
				rd.include(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("DB Connection problem.");
		} finally {
			try {
				
				rs.close();
				ps.close();
				//con.close();
			} catch (SQLException e) {
				System.out.println("ERrror Here");
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// System.out.println(request.getParameter("user")+" "+request.getParameter("pwd"));
	}

}
