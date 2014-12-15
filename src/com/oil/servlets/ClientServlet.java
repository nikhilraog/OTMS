package com.oil.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Statement;


@WebServlet("/client")
public class ClientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	String q1 = "select id,name from trader";
	String q2 = "select * from  inventory";
	String q3 = "select oilbalance,cashbalance from client where id=(?)";
	String q4 = "select category from belongsto where clientid=(?)";
	String q5 = "update belongsto set category=\"gold\" where clientid=(?)";
	String q6 = "select id from trader";
	String q7 = "SELECT sum(t.quantity) as tqty FROM client_trader_transaction_history h, transaction t WHERE h.client_id=? and t.id = h.transaction_id and MONTH(date) = MONTH(NOW())";
	
	int tid;
	int comtype;
	int client_id,quantity;
	double client_cash_bal;
	double client_oil_bal;
	double ppb;
	String quan;
	double total_oil ;
	int[] randarray = new int[] {3,4,5,6,7,8,9};
	
   
    public ClientServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			HttpSession session = request.getSession();
			
			
			client_id = Integer.valueOf(session.getAttribute("Client_name").toString());
			client_cash_bal = Double.valueOf(session.getAttribute("cash_balance").toString());
			client_oil_bal = Double.valueOf(session.getAttribute("oil_balance").toString());
			ppb = Double.valueOf(session.getAttribute("ppb").toString());
		    quan = request.getParameter("quantity");
			
			//String req = request.toString();
			System.out.println("Oil quanti "+ quan);
			
			String buysell;
			if(request.getParameter("buysell").equals("Buy")){
				buysell = "b";
			}
			else{ buysell = "s";}
			
		    quantity=Integer.valueOf(request.getParameter("quantity"));
			int comtype;
			String c_type = request.getParameter("comissionstatus");
			if(c_type.equals("Cash")){
				comtype = 1;
			}
			else{
				comtype = 0;
			}
			//System.out.println(comtype);
			
			
			
			
			String transactiontype= request.getParameter("transactiontype");
			
			String tradername = request.getParameter("tradername");
			
			Transaction t = new Transaction();
			t.setBuy_sell(buysell);
			t.setQuantity(quantity);
			t.setComtype(comtype);
			double cost_of_trans = (quantity*ppb);
			t.setCost_transation(cost_of_trans);
			
			String ins_query = "INSERT INTO transaction (quantity, buy_sell, cost_of_transaction, comtype) VALUES (?,?,?,?)";
			String ins_hist = "INSERT INTO client_trader_transaction_history(client_id, trader_id, transaction_id, cost_of_transaction, com_charge) VALUES (?,?,?,?,?)";
			Connection con1 = (Connection) getServletContext().getAttribute("DBConnection");
			//System.out.println("am here!!");
			
		if(buysell.equals("b"))	{
			//check cash balance
			if(client_cash_bal >= cost_of_trans){			
			
				ps = con1.prepareStatement(q7);
				ps.setInt(1, client_id);
				rs = ps.executeQuery();
				if(rs != null && rs.next()){
					System.out.println("Total oil traded so far in a month: ");
					total_oil = rs.getDouble("tqty");
					System.out.println("Total oil traded : "+ total_oil);
										
				}
			
				
			ps = con1.prepareStatement(ins_query , Statement.RETURN_GENERATED_KEYS);
			ps.setDouble(1, quantity);
			ps.setString(2, buysell);
			ps.setDouble(3, cost_of_trans);
			ps.setInt(4, comtype);
			
			
				if(ps.execute()){}	
			      
				else{
				
					rs = ps.getGeneratedKeys();
					if(rs.next()){
					tid = rs.getInt(1);
					System.out.println("aEminem!"+ tid);
					session.setAttribute("transaction_id", tid);
					RequestDispatcher dispatcher = request.getRequestDispatcher("transaction.jsp");
					request.setAttribute("total", String.valueOf(cost_of_trans)+" $. (You will be credited with amount displayed if you have sold oil).**Condition apply: Additional commission charges as applicable");
					dispatcher.forward( request, response );
										
					}
			  	}
				
				
					ps = con1.prepareStatement(ins_hist);
					ps.setInt(1, client_id);//client id
					System.out.println("Client is id "+client_id);
					
					ps.setInt(3, tid);// trader id
					System.out.println("Transaction is id "+tid);
					
					if(request.getParameter("transactiontype").toString().equals("Self")){
					//ps.setInt(2, client_id);//transaction_id
					ps.setInt(2, randarray[new Random().nextInt(randarray.length)]);//transaction_id
					System.out.println("Self is id "+client_id);
					}
					
					else{
						ps.setInt(2, 5);//put trader id of the week
						System.out.println("temporary trader");
					}
					
					
					ps.setDouble(4, cost_of_trans);//cost_of transaction
					System.out.println("cost of trans is id "+cost_of_trans);
					if(c_type.equals("Cash")){
					ps.setDouble(5, cost_of_trans*.2);//com_charge
					System.out.println("comissin is id "+ cost_of_trans*.2);
					
					}
					else{
						ps.setDouble(5, quantity*.2);//com_charge
						System.out.println("comissin in liter"+ quantity*.2);
						
					}
					
					//insert into history
					if(ps.execute()){}
					else{
						System.out.println("Inserted into history");
					}
					
					if(quantity + total_oil>30){
						
						ps = con1.prepareStatement(q5);
						ps.setInt(1, client_id);
						if(!ps.execute()){
							System.out.println("Updated client category");
						}
						
					}
				
				
			}
			
			
			else{
				
				System.out.println("Not enough cash balance- contact helpdesk");
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/transaction.jsp");
				PrintWriter out = response.getWriter();
				out.println("<font size=\"6\" color=red>Not enough cash balance- contact helpdesk : 1(800)-(oil)-(tran)</font>");
				rd.include(request, response);
				
			}
			
		}
		else if(buysell.equals("s")){
			//check oil balance
			System.out.println("Woo Am selling oil!!");
			
			
			if(client_oil_bal >= quantity){
				
				ps = con1.prepareStatement(q7);
				ps.setInt(1, client_id);
				rs = ps.executeQuery();
				if(rs != null && rs.next()){
					System.out.println("Total oil traded so far in a month: ");
					total_oil = rs.getDouble("tqty");
					System.out.println("Total oil traded : "+ total_oil);
										
				}
				
				ps = con1.prepareStatement(ins_query , Statement.RETURN_GENERATED_KEYS);
				ps.setDouble(1, quantity);
				ps.setString(2, buysell);
				ps.setDouble(3, cost_of_trans);
				ps.setInt(4, comtype);
				
				
					if(ps.execute()){
						
						rs = ps.getGeneratedKeys();
						if(rs.next()){
							tid = rs.getInt(1);
							session.setAttribute("transaction_id", tid);
						}
				}else{
						
						rs = ps.getGeneratedKeys();
						if(rs.next()){
						tid = rs.getInt(1);
						session.setAttribute("transaction_id", tid);
						RequestDispatcher dispatcher = request.getRequestDispatcher("transaction.jsp");
						request.setAttribute("total", String.valueOf(cost_of_trans)+" $. (You will be credited with amount displayed if you have sold oil)."
								+ "\n"+"**Condition apply: Additional commission charges as applicable");
						dispatcher.forward( request, response );
						
						}
				  	}
					ps = con1.prepareStatement(ins_hist);
					ps.setInt(1, client_id);//cliendt id
					System.out.println("Client id is: "+client_id);
					
					ps.setInt(3, tid);// trader id
					System.out.println("Transaction id is "+tid);
					
					if(request.getParameter("transactiontype").toString().equals("Self")){
					//ps.setInt(2, client_id);//trader_id
					
					ps.setInt(2, randarray[new Random().nextInt(randarray.length)]);//transaction_id	
					System.out.println("Self id is "+client_id);
					}
					else{
						ps.setInt(2, 5);//put trader id of the week
						System.out.println("temporary trader");
					}
					//ps.setDate(4, x);//date
					
					ps.setDouble(4, cost_of_trans);//cost_of transaction
					System.out.println("cost of trans is id "+cost_of_trans);
					if(c_type.equals("Cash")){
					ps.setDouble(5, cost_of_trans*.2);//com_charge
					System.out.println("comissin is: "+ cost_of_trans*.2 +"$ or Barrels");
					
					}
					else{
						ps.setDouble(5, quantity*.2);//com_charge
						System.out.println("comissin in liter"+ quantity*.2);
						
					}
					
					
					
					//insert into history
					if(!ps.execute()){
					
						System.out.println("Inserted into history");
					}
					
					//Update client category
                    if(quantity + total_oil >30){
						
						ps = con1.prepareStatement(q5);
						ps.setInt(1, client_id);
						if(!ps.execute()){
							System.out.println("Updated client category");
						}
						
					}
					
					
			}
			
			
			
			else{
				//not enough oil to sell
				System.out.println("Not enough Oil Balance to sell- contact helpdesk");
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/transaction.jsp");
				PrintWriter out = response.getWriter();
				out.println("<font size=\"6\" color=red>Not enough Oil Balance in your account - contact helpdesk : 1(800)-(oil)-(tran)</font>");
				rd.include(request, response);
				
			    }
			
			
		 }
		
		
			
		}//end of try block
		
		
		catch (Exception e) {
			
			e.printStackTrace();
			
			System.out.println("Exception "+e);
		}
		
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
	}


}
