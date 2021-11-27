package task2;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class CustomerDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;

	public CustomerDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public CustomerBean lastCustomer() {
		CustomerBean bean= new CustomerBean();
		try {
			con = dataFactory.getConnection();
			String query = "select * from customer order by ACCOUNT_NUMBER ";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String accountNumber = rs.getString("ACCOUNT_NUMBER");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				Date joinDate = rs.getDate("joinDate");
				bean.setAccount(accountNumber);
				bean.setPwd(pwd);
				bean.setName(name);
				bean.setJoinDate(joinDate);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	public CustomerBean getCustomerInfo(String account) {	//user정보 다보기용
		CustomerBean bean = new CustomerBean();
		try {
			con = dataFactory.getConnection();
			String query = "select * from customer where ACCOUNT_NUMBER=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(account));
			ResultSet rs = pstmt.executeQuery();
			rs.next(); 
			
			String c_account = rs.getString("ACCOUNT_NUMBER");
			String name = rs.getString("name");
			String pwd = rs.getString("pwd");
			String address = rs.getString("address");
			Date joinDate = rs.getDate("joinDate");
			
			bean.setAccount(c_account);
			bean.setName(name);
			bean.setPwd(pwd);
			bean.setAddress(address);
			bean.setJoinDate(joinDate);
			
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	public void setInitializeBeakdown() {
		try {
			CustomerBean cb =lastCustomer();
			
			C_accountBean bean = new C_accountBean();
			bean.setAccount(cb.getAccount());
			bean.setDeposit("0");
			bean.setBreakdown("신규계좌 개설");
			bean.setBalance("initialize");
			
			new C_accountDAO().addContent(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void addCustomer(CustomerBean customerBean) {
		try {
			Connection con = dataFactory.getConnection();
			String create_number = "create_number.nextval";
			String pwd = customerBean.getPwd();
			String name = customerBean.getName();
			
			
			String query = "insert into customer";
			query += " (ACCOUNT_NUMBER,name,pwd,address)";
			query += " values(create_number.nextval,?,?,?)";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, name);
			pstmt.setString(2, pwd);
			pstmt.setString(3, customerBean.getAddress());
			
			pstmt.executeUpdate();
			pstmt.close();
			
			setInitializeBeakdown();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public boolean updatePwd(CustomerBean bean) {
		try {
			Connection con = dataFactory.getConnection();
			Statement stmt = con.createStatement();
			String query = "update customer set pwd =? where ACCOUNT_NUMBER=?";
			System.out.println("prepareStatememt:" + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getAccount());
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {	
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public boolean updateAddress(CustomerBean bean) {
		try {
			Connection con = dataFactory.getConnection();
			Statement stmt = con.createStatement();
			String query = "update customer set address =? where ACCOUNT_NUMBER=?";
			System.out.println("prepareStatememt:" + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, bean.getAddress());
			pstmt.setString(2, bean.getAccount());
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {	
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public boolean checkCustomerID(CustomerBean bean) {	//정보 다보기용
		try {
			con = dataFactory.getConnection();
			String query = "select ACCOUNT_NUMBER from customer where ACCOUNT_NUMBER=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(bean.getAccount()));
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String account = ""+rs.getInt("ACCOUNT_NUMBER");
				if(account.equals(bean.getAccount())) {
					rs.close();
					pstmt.close();
					con.close();
					return true;
				}
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public void delCustomer(String account) {
		try {
			Connection con = dataFactory.getConnection();
			Statement stmt = con.createStatement();
			String query = "delete from customer" + " where ACCOUNT_NUMBER=?";
			System.out.println("prepareStatememt:" + query);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(account));
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean isExisted(CustomerBean customerBean) {
		boolean result = false;
		int account = Integer.parseInt(customerBean.getAccount());
		String pwd = customerBean.getPwd();
		try {
			con = dataFactory.getConnection();
			String query = "select decode(count(*),1,'true','false') as result from customer";
			query += " where ACCOUNT_NUMBER=? and pwd=?";
			System.out.println(query);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, account);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery();
			rs.next(); //커서를 첫번째 레코드로 위치시킵니다.
			result = Boolean.parseBoolean(rs.getString("result"));
			System.out.println("result=" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
}
