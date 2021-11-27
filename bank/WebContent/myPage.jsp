<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import=" java.util.*,task2.*, java.text.SimpleDateFormat"
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
	<title>온라인 은행: 내 정보</title>
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
			cb=(CustomerBean)session.getAttribute("cb");
			SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd");
			String date = "20"+format.format(cb.getJoinDate());
		%>
		
		<jsp:include page="title.jsp" flush="true">
			<jsp:param value="<%=cb.getName() %>" name="name"/>
			<jsp:param value="<%=cb.getAccount() %>" name="account"/>
		</jsp:include>
		
		<form action="process.jsp" method="post" name="edit">
		<table  align="center">
			<tr>
		        <td width="200"><p align="right">계좌번호:</td>
		        <td width="400"><%=cb.getAccount() %></td>
		    </tr>
		    <tr>
		        <td width="200"><p align="right">이름:</td>
		        <td width="400"><%=cb.getName() %></td>
		    </tr>
		    <tr>
		        <td width="200"><p align="right">계좌 비밀번호:</td>
		        <td><table>
		        	<tr><td><input type="password"  name="pwd"></td>
		        		<td><p><input type="button" value="수정" onClick="vaildData('process.jsp?mode=edit&kind=pwd&pwd=','pwd')"></td>
		        	</tr>
		        </table>
		        <p>
		        </td>
		    </tr>
		    <tr>
		        <td width="200"><p align="right">주소:</td>
		        <td><table>
		        	<tr><td><input type="text"  name="address" value="<%=cb.getAddress() %>"></td>
		        		<td><input type="button" value="수정" onClick="vaildData('process.jsp?mode=edit&kind=address&address=','address')"></td>
		        	</tr>
		        </table>
		        </td>
		    </tr>
		    <tr>
		        <td width="200"><p align="right">개설일:</td>
		        <td width="400"><%=date %></td>
		    </tr>
		    <tr>
		        <td width="200"><p>&nbsp;</p></td>
		        <td><table>
		        	<tr><td><input type="button" value="돌아가기" onClick="location.href='main.jsp'"></td>
		        		<td><input type="button" value="회원탈퇴" onClick="delCustomer('<%=cb.getAccount() %>')"></td>
		        	</tr>
		        </table>
		        </td>
		  <td>
		  </td>
		    </tr>
		</table>
		</form>
		
	</c:otherwise>
</c:choose>
<script type="text/javascript" >
	   function vaildData(url,para){	
	      var edit=document.edit;
	      
	      if(para=="pwd"){
	    	  var content=edit.pwd.value;
	      }else if(para=="address"){
	    	  var content=edit.address.value;
	      }
	      
	      if(content.length==0 ||content==""||content==" "){
	    	  alert("내역을 입력해 주십시오.");
	      }else{
	    	  edit.method="post";
	    	  edit.action=url+content;
	    	  edit.submit();
		  }
	   }
	   
	   function delCustomer(account){	
		   var confirmDel = confirm('정말 탈퇴하시겠습니까?');
		   if(confirmDel===true){
			   location.href="logoutORdel.jsp?del=del&account="+account;
		   }
	   }
	   
</script>

</body>
</html>
