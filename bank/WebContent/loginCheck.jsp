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
	<title>login...</title>
</head>
<body>
<jsp:useBean id="cb" class="task2.CustomerBean" />
<jsp:setProperty property="*" name="cb"/>

<%
	boolean result = false;
	CustomerDAO dao = new CustomerDAO();
	result = dao.isExisted(cb);
%>
<c:choose>
	<c:when test="<%=result %>">
		<%
			cb=dao.getCustomerInfo(cb.getAccount());
			session.setAttribute("isLogon", true);
			session.setAttribute("cb", cb);
		%>
		<c:redirect url="main.jsp"/>
	</c:when>
	<c:otherwise>
		<script>
			alert('입력정보가 일치하지 않습니다.'); 
			location.href='login.jsp';
		</script>
	</c:otherwise>
</c:choose>

</body>
</html>