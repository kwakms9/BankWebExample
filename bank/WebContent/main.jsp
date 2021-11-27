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
	<style>
		h1 { text-align: center; }
	</style>
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
		<jsp:useBean id="cb" class="task2.CustomerBean"/>
		<%
			List accountList;
			String name;
			String account;
			cb=(CustomerBean)session.getAttribute("cb");
			accountList = new C_accountDAO().listContents(cb.getAccount());
			account = cb.getAccount();
			name = cb.getName();
		%>
		
		<jsp:include page="title.jsp" flush="true">
			<jsp:param value="<%=name %>" name="name"/>
			<jsp:param value="<%=account %>" name="account"/>
		</jsp:include>
		
		<c:set var = "list" value="<%=accountList %>"/>
		<table  align="center" >
		   <tr align="center"  bgcolor="#99ccff">
		      <td width="20%"><b>입출금액</b></td>
		      <td width="20%"><b>내역</b></td>
		      <td width="20%" ><b>일시</b></td>
		      <td width="20%"><b>잔고</b></td>
			</tr>
			
			<c:set var="balance" value="${'0' }"/>
			<c:forEach var="cab" items="${list }">
				<tr align="center">
			      <td>${cab.deposit}</td>
			      <td><a href="editWindow.jsp?insertDay=${cab.insertDay}&breakdown=${cab.breakdown}" onclick="window.open(this.href, '_blank', 'width=400,height=300,toolbars=no,scrollbars=no'); return false;">${cab.breakdown}</a>
			      <td>${cab.insertDay}</td>
			      <td>${cab.balance}</td><c:set var = "balance" value="${cab.balance}"/>
		  		</tr>
			</c:forEach>
		</table>
		
			<c:set var="mode" value="${param.mode }"/>
			<c:choose>
				<c:when test="${mode=='add' }">
					<form name="addHistory" method="post" action="process.jsp" encType="UTF-8">
					<input type = "hidden" name = "mode" value = "add">
						<table  align="center" >
							<tr align="center" >
								<td bgcolor="#99ccff"><b>입출금액</b></td>
						      	<td><input type ="text" name = "deposit"></td>
						    </tr>
						    <tr align="center" >
								<td bgcolor="#99ccff"><b>내역</b></td>
						      	<td><input type ="text" name = "breakdown"></td>
						    </tr>
						    <tr>
						    	<td><input type="button" value="뒤로가기" onClick="location.href='main.jsp'" ></td>
						    	<td><input type="button" value="실행" onClick="vaildAddData(${balance})" ></td>
						    </tr>
						</table>
				</form>
				</c:when>
	
				<c:when test="${mode=='send' }">
					<form name="send" method="post" action="process.jsp" encType="UTF-8">
					<input type = "hidden" name = "mode" value = "send">
					<input type = "hidden" name = "s_name" value = "<%=cb.getName() %>">
					<input type = "hidden" name = "s_account" value = "<%=cb.getAccount() %>">
						<table  align="center" >
							<tr align="center" >
								<td bgcolor="#99ccff"><b>상대계좌번호</b></td>
						      	<td><input type ="text" name = "another"></td>
						    </tr>
						    <tr align="center" >
								<td bgcolor="#99ccff"><b>금액</b></td>
						      	<td><input type ="number" name = "deposit"></td>
						    </tr>
						    <tr>
						    	<td><input type="button" value="뒤로가기" onClick="location.href='main.jsp'" ></td>
						    	<td><input type="button" value="송금" onClick="vaildSendData(${balance})" ></td>
						    </tr>
						</table>
					</form>
				</c:when>
	
				<c:otherwise>
					<table align = "center">
						<tr align="center">
						<td><input type="button" onClick="location.href='main.jsp?mode=add'" value="입출금"/></td>
						<td><input type="button" onClick="location.href='main.jsp?mode=send'" value="송금"/></td>
						</tr>
					</table>
				</c:otherwise>
		</c:choose>
		
		</c:otherwise>
</c:choose>
<script type="text/javascript" >
	   function vaildAddData(balance){	
	      var addHistory=document.addHistory;
	      var deposit=addHistory.deposit.value;
	      var breakdown=addHistory.breakdown.value;
	
	      if(deposit.length==0 ||deposit==""){
	    	  alert("입출금액을 입력해 주십시오.");
	      }else if(breakdown.length==0 ||breakdown==""){
	    	  alert("내역을 입력해 주십시오.");
	      }else if(balance+deposit<0){
	    	  alert("잔액부족!");
	      }else{
	    	addHistory.method="post";
			addHistory.action="process.jsp";
			addHistory.submit();
		  }
	   }
	   
	   function vaildSendData(balance){	
		      var send=document.send;
		      var another=send.another.value;
		      var deposit=send.deposit.value;
		
		      if(another.length==0 ||another==""){
		    	  alert("받으실 분의 계좌번호를 입력해 주십시오.");
		      }else if(deposit.length==0 ||deposit==""){
		    	  alert("금액을 입력해 주십시오.");
		      }else if(deposit<1){
		    	  alert("보낼 금액이 없습니다.");
		      }else if(balance+deposit<0){
		    	  alert("잔액부족!");
		      }else{
		    	  send.method="post";
		    	  send.action="process.jsp";
		    	  send.submit();
			  }
		   }
	   
</script>
</body>
</html>