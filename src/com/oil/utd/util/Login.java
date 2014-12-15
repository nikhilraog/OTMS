package com.oil.utd.util;


//@Entity
//@Table(name = "login")
public class Login {
	
  private String userid;
  private String password;
  private int roleid;
  
  
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int string) {
		this.roleid = string;
	}
	@Override
	public String toString() {
		return "Login [userid=" + userid + ", password=" + password
				+ ", roleid=" + roleid + "]";
	}
  
  
}