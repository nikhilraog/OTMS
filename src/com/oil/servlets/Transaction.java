package com.oil.servlets;

public class Transaction {
    private int id;
    private double quantity;
    private String buy_sell;
    private int comtype;
    private double cost_transation;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	
	public String getBuy_sell() {
		return buy_sell;
	}
	public void setBuy_sell(String buy_sell) {
		this.buy_sell = buy_sell;
	}
	public double getCost_transation() {
		return cost_transation;
	}
	public void setCost_transation(double cost_transation) {
		this.cost_transation = cost_transation;
	}
	public int getComtype() {
		return comtype;
	}
	public void setComtype(int comtype) {
		this.comtype = comtype;
	}
}
