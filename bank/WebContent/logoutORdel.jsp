<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import=" java.util.*,task2.*"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
  session.setAttribute("isLogon", false);
  session.setAttribute("cb",null);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>온라인 은행</title>
	<c:if test="${param.del=='del' }">
		<%
			String account = request.getParameter("account");
			new CustomerDAO().delCustomer(account);
		%>
		<script>
	      alert("회원탈퇴 되었습니다.");
	      location.href="login.jsp"; 
		</script>
	</c:if>
	<script>
	      alert("로그아웃 되었습니다.");
	      location.href="login.jsp"; 
	</script>
</head>
<body>
	
</body>
</html>