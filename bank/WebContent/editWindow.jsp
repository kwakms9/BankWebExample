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
	<title>내역 수정</title>
</head>
<body>
<c:set var="kind" value="${param.kind }"/>

<form action="process.jsp" method="post" name="edit">
<% 
	String url = "process.jsp?mode=edit&kind=breakdown&insertDay="+request.getParameter("insertDay")+"&breakdown=";
%>
<c:set var="url" value="<%=url %>"/>
	<table  align="center" >
		<tr align="center" >
			<td width="20%" ><b>내역</b></td>
	      	<td><input type ="text" name = "content" value="${param.breakdown }"></td>
	    </tr>
	
	    <tr>
	    	<td><input type="button" value="수정" onClick="vaildData('${url }')" >
	    </tr>
	</table>
</form>
<script type="text/javascript" >
	   function vaildData(url){	
	      var edit=document.edit;
	      var content=edit.content.value;
	
	      if(content.length==0 ||content==""||content==" "){
	    	  alert("내역을 입력해 주십시오.");
	      }else{
	    	  edit.method="post";
	    	  edit.action=url+content;
	    	  edit.submit();
		  }
	   }
	   
</script>
</body>
</html>