package com.oil.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SettleTr
 */
@WebServlet("/settr")
public class SettleTr extends HttpServlet {
	private static final long serialVersionUID = 1L;
       int client_id;
       int set_one_settledflag;
       //ArrayList<Integer> tlist ;
      // String query = "SELECT date,t.id transaction_id,t.quantity,(CASE WHEN buy_sell like 'b%' THEN \"Bought\" ELSE \"Sold\" END) As Buy_Sell, t.cost_of_transaction,h.com_charge, (CASE WHEN comtype <> 0 THEN 'Cash' ELSE 'Oil' END) As Comission_Mode,\r\n(CASE \r\nWHEN h.settled_flag = 1 THEN 'Check view status'\r\nWHEN h.settled_flag = 0 THEN 'Applied'\r\nWHEN h.settled_flag = 2 THEN 'Accpeted'\r\nWHEN h.settled_flag = 3 THEN 'Rejected'\r\nEND\r\n)As Settlement FROM transaction t, client_trader_transaction_history h where t.id=h.transaction_id and client_id=? and h.settled_flag in (0,1)";
      String query = "update client_trader_transaction_history set settled_flag=1 where client_id=? and transaction_id=?";
   
    public SettleTr() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("request from prev page :"+ request.getParameter("param2").toString());
		String data = request.getParameter("param2").toString();
		//String data1 = request.getParameter("param2");
		
		String[] values = data.split("#");
		System.out.println("Client Id: ID "+ values[0]);
		System.out.println("Trans: ID "+ values[1]);
		String tl = values[1];
		
		int indexOfOpenBracket = tl.indexOf("[");
		int indexOfLastBracket = tl.lastIndexOf("]");
		 
		
		String listt = tl.substring(indexOfOpenBracket+1, indexOfLastBracket);
		String[] ltlistarray = listt.split(",");
		int[] i_tlist = new int[ltlistarray.length];
		
		for (int i=0; i < ltlistarray.length; i++) {
	        i_tlist[i] = Integer.parseInt(ltlistarray[i].trim());
	    }
		
		System.out.println("param2 : " + data.toString() + "ttt lll "+ listt);
		
		client_id = Integer.valueOf(values[0]);
		System.out.println("here cid :"+ client_id);
		//tlist = new ArrayList<Integer>(Arrays.asList(Integer.valueOf(values[1].split(","))));
				
		set_one_settledflag = Integer.valueOf(values[2]);
		
		Connection con = (Connection) getServletContext().getAttribute("DBConnection");
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			
			ps = con.prepareStatement(query);
			System.out.println("Hellowold");
			
			
			for (int i : i_tlist) {
				
				ps.setInt(1, client_id);
				ps.setInt(2, i);
				
				 
				if(!ps.execute()){
					
					System.out.println("success!!!!");
				}
				
			}
			/*Array arra = con.createArrayOf("INTEGER", ArrayUtils.toObject(i_tlist));
			
			System.out.println("Hellowol  2 ");
			ps.setInt(1, client_id);
			ps.setArray(2, arra );
			
			rs = ps.executeQuery();
			
			if(rs.next()){
			System.out.println(rs.getString(8));*/
			
			//Result result = ResultSupport.toResult(rs);
	       // request.setAttribute("result", result);
	       // RequestDispatcher rd = request.getRequestDispatcher("/st.jsp");
	        //RequestDispatcher rd = request.getRequestDispatcher("/st.jsp");
			PrintWriter out = response.getWriter();
			out.println("<font color=red>No user found with given email id, please register first.</font>");
			//rd.forward(request, response);*/
			//request.getRequestDispatcher("/st.jsp").forward(request, response);
			// }
			//}
		}
		catch (Exception e) {
			System.out.println("Errorrrr in Setteletr   "+e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
