<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import=" java.util.*,task2.*"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  boolean existSession = false;
  request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>온라인 은행</title>
</head>
<body>
<%
	try{
		existSession = ((Boolean)(session.getAttribute("isLogon")));
	}catch(Exception e){
		existSession = false;
	}
%>
<c:set var="logged_in" value="<%=existSession %>"/>
<c:choose>
	<c:when test="${!logged_in}">
		<script>
			alert('로그인 되지않습니다.'); 
			location.href='login.jsp';
		</script>
	</c:when>
	
	<c:otherwise>
		
		<table  align="center" >
			<tr><td><h1>온라인 은행</h1></td></tr>
			<tr><td colspan=2><b align="right">${param.name }님의 계좌번호: ${param.account }</b></td></td>
			<td>
			<table  align="right" >
				<tr><td width="20%" > <input type="button" value="내 정보" onClick="location.href='myPage.jsp'"> </td>
					<td> <input type="button" value="로그아웃" onClick="location.href='logoutORdel.jsp'"> </td>
				</tr>
			</table>
			</td></tr>
		</table>
		
		
		
	</c:otherwise>
</c:choose>
</head>
<body>

</body>
</html>