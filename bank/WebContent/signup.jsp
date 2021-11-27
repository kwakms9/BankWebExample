<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import=" java.util.*,task2.*"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 은행</title>
</head>
<body>
	<jsp:useBean id="customer" class="task2.CustomerBean" />
	<jsp:setProperty property="*" name="customer"/>
	<%
	   CustomerDAO customerDAO=new CustomerDAO();
	   customerDAO.addCustomer(customer);
	   CustomerBean lastC = customerDAO.lastCustomer();
	%>
	<h2 align="center">회원가입 완료!</h2>
	<h3 align="center">계좌번호는 <%=lastC.getAccount() %>입니다. <input type="button" value="로그인하러가기" onClick="location.href='login.jsp'"></h3>
	
</body>
</html>