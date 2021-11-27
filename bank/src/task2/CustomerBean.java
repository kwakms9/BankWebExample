package task2;

import java.sql.Date;

public class CustomerBean {
	private String account;
	private String pwd;
	private String name;
	private String address;
	private Date joinDate;
	
	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}

	public CustomerBean() {
		
	}


	public String getAccount() {
		return account;
	}


	public void setAccount(String accountNumber) {
		this.account = accountNumber;
	}


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public Date getJoinDate() {
		return joinDate;
	}


	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
}
