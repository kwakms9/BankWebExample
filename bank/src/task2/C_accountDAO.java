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




public class C_accountDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;

	public C_accountDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List listContents(String account) {
		List list = new ArrayList();
		try {
			con = dataFactory.getConnection();
			String query = "select * from c_account where account_number=? order by to_date(insert_day,'yyyy/mm/dd hh24:mi:ss')";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(account));
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String accountNumber = rs.getString("account_Number");
				String deposit = rs.getString("deposit_amount");
				String breakdown = rs.getString("breakdown");
				String insertDay = rs.getString("insert_day");
				String balance = rs.getString("balance");
				C_accountBean bean = new C_accountBean();
				bean.setAccount(accountNumber);
				bean.setDeposit(deposit);
				bean.setBreakdown(breakdown);
				bean.setInsertDay(insertDay);
				bean.setBalance(balance);
				list.add(bean);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public void addContent(C_accountBean c_accountBean) {
		try {
			Connection con = dataFactory.getConnection();
			String account = c_accountBean.getAccount();
			String deposit = c_accountBean.getDeposit();
			String breakdown = c_accountBean.getBreakdown();
			List arr = new C_accountDAO().listContents(account);
			
			String balance="0";
			
			if(c_accountBean.getBalance()==null){
				int lastIndex = arr.size()-1;
				balance = Integer.parseInt(deposit)+ Integer.parseInt((((C_accountBean)arr.get(lastIndex)).getBalance()))+"";
			}
			
			String query = "insert into c_account";
			query += " (account_number,deposit_amount,breakdown,insert_day,balance)";
			query += " values(?,?,?,to_char(sysdate,'yyyy/mm/dd hh24:mi:ss'),?)";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(account));
			pstmt.setString(2, deposit);
			pstmt.setString(3, breakdown);
			pstmt.setString(4, balance);
			
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean updateBreakdown(C_accountBean bean) {
		try {
			Connection con = dataFactory.getConnection();
			Statement stmt = con.createStatement();
			String query = "update C_ACCOUNT set BREAKDOWN =? where ACCOUNT_NUMBER=? and INSERT_DAY=?";
			System.out.println("prepareStatememt:" + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, bean.getBreakdown());
			pstmt.setInt(2, Integer.parseInt(bean.getAccount()));
			pstmt.setString(3, bean.getInsertDay());
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
