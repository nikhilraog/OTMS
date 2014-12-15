package com.oil.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Accept_reject
 */
@WebServlet("/accept")
public class Accept_reject extends HttpServlet {
	private static final long serialVersionUID = 1L;
    int accept;
    int transaction_id;
    int client_id;
    Timestamp ts;
    
    double quantity;
    double commissioncharge;
    double transactioncost;
    String bought_sold;
    String commissionmode;
    String settled;
    double c_qty;
    double c_cash;
    
    String acc_query = "";
    String rej_query = "";
    String client_oil_cash = "select oilbalance, cashbalance from client where id = ? limit 1";
    String inventory_oil_cash = "select oilrepo, cashrepo from inventory limit 1";
    String update_client_query = "update client set oilbalance=?, cashbalance=? where id=?";
    
    public Accept_reject() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("request :"+ request.getParameter("param1").toString());
		String data = request.getParameter("param1").toString();
		String[] values = data.split("@");
		System.out.println("Client Id: ID "+ values[9]);
		
		String[] accs = values[0].split("-");
		accept = Integer.valueOf(accs[0]);
		ts = Timestamp.valueOf(values[1]);
		transaction_id = Integer.valueOf(values[2]);
		quantity = Double.valueOf(values[3]);
		bought_sold = values[4];
		transactioncost = Double.valueOf(values[5]);
		commissioncharge = Double.valueOf(values[6]);
		commissionmode = values[7];
		settled = values[8];
		client_id = Integer.valueOf(values[9]);
		double client_oilbal = 0;
		double client_cashbal =0;
		
		double inventory_cashbal;
		
		double inventory_oilbal;
		
		
		Connection con = (Connection) getServletContext().getAttribute("DBConnection");
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = con.prepareStatement(client_oil_cash);
			ps.setInt(1, client_id);
			rs = ps.executeQuery();
			if(rs!=null && rs.next()){
				client_oilbal = rs.getDouble(1);
				client_cashbal = rs.getDouble(2);
				
			}	
		   ps = con.prepareStatement(inventory_oil_cash);
		   rs = ps.executeQuery();
		   if(rs!=null && rs.next()){
			   inventory_cashbal = rs.getDouble(2);
			   inventory_oilbal = rs.getDouble(1);
			   
		      }
				
			
			
		} catch (SQLException e) {
			System.out.println("error: lookhere!!!");
			e.printStackTrace();
		}
		
		
		if(accept == 1){
			//accept
			System.out.println("Inside accept");
			if(bought_sold.equals("Bought")){
				//Buy
				if(commissionmode.equals("Cash")){
					c_qty = client_oilbal + quantity;
					c_cash = client_cashbal - (transactioncost+commissioncharge);
					
					
					try {
						ps = con.prepareStatement(update_client_query);
						ps.setDouble(1, c_qty);
						ps.setDouble(2, c_cash);
						ps.setInt(3, client_id);
						if(!ps.execute()){
							System.out.println("Updated successfully");
							
						}
						//accepted status//
						ps = con.prepareStatement("update client_trader_transaction_history set settled_flag = 2 where client_id=? and transaction_id =?");
						ps.setInt(1, client_id);
						ps.setInt(2, transaction_id);
						if(ps.execute()){
							System.out.println("Could not accpect-- some error check soon");
						}
						
						
					} catch (SQLException e) {
						System.out.println("Error here!!");
						e.printStackTrace();
					}
					
					System.out.println("New values that will be updated "+ c_qty+ " cash"+c_cash);
				}
				else{
					c_qty = client_oilbal + quantity - commissioncharge;
					c_cash = client_cashbal - transactioncost;
					

					try {
						ps = con.prepareStatement(update_client_query);
						ps.setDouble(1, c_qty);
						ps.setDouble(2, c_cash);
						ps.setInt(3, client_id);
						if(!ps.execute()){
							System.out.println("Updated successfully");
						}
						
						ps = con.prepareStatement("update client_trader_transaction_history set settled_flag = 2 where client_id=? and transaction_id");
						ps.setInt(1, client_id);
						ps.setInt(2, transaction_id);
						if(ps.execute()){
							System.out.println("Could not accpect-- some error check soon");
						}
						
					} catch (SQLException e) {
						System.out.println("Error here!!");
						e.printStackTrace();
					}
					
					System.out.println("Here is the new values that will be updated"+ c_qty+ "cash"+c_cash);
					
					
				}
				
			}
			else{
				//Sell
				if(commissionmode.equals("Cash")){
					c_qty = client_oilbal - quantity;
					c_cash = client_cashbal + (transactioncost - commissioncharge);
					

					try {
						ps = con.prepareStatement(update_client_query);
						ps.setDouble(1, c_qty);
						ps.setDouble(2, c_cash);
						ps.setInt(3, client_id);
						if(!ps.execute()){
							System.out.println("Updated successfully");
						}
						
						ps = con.prepareStatement("update client_trader_transaction_history set settled_flag = 2 where client_id=? and transaction_id=?");
						ps.setInt(1, client_id);
						ps.setInt(2, transaction_id);
						if(ps.execute()){
							System.out.println("Could not accpect-- some error check soon");
						}
						
					} catch (SQLException e) {
						System.out.println("Error here!!");
						e.printStackTrace();
					}
					
					System.out.println("In sell valu that be updated"+ c_qty+ "cash"+c_cash);
					
				}
				else{
					c_qty = client_oilbal + quantity  - commissioncharge;
					c_cash = client_cashbal + transactioncost;

					try {
						ps = con.prepareStatement(update_client_query);
						ps.setDouble(1, c_qty);
						ps.setDouble(2, c_cash);
						ps.setInt(3, client_id);
						if(!ps.execute()){
							System.out.println("Updated successfully");
							
						}
						ps = con.prepareStatement("update client_trader_transaction_history set settled_flag = 2 where client_id=? and transaction_id=?");
						ps.setInt(1, client_id);
						ps.setInt(2, transaction_id);
						if(ps.execute()){
							System.out.println("Could not accpect-- some error check soon");
						}
						
					} catch (SQLException e) {
						System.out.println("Error here!!");
						e.printStackTrace();
					}
					
					System.out.println("In sell to  be updated"+ c_qty+ "cash"+c_cash);
				}
				
			}
			
		}
		else{
			
			//reject
			
			try {
				ps = con.prepareStatement("update client_trader_transaction_history set settled_flag = 3 where client_id=? and transaction_id=?");
				ps.setInt(1, client_id);
				ps.setInt(2, transaction_id);
				if(ps.execute()){
					System.out.println("Could not accpect-- some error check soon");
				}
			} catch (SQLException e) {
				System.out.println("Inside reject exception");
				e.printStackTrace();
			}
			
			
		}
		
		
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
