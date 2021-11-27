<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
import ="task2.*"
isELIgnored="false"  %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인창</title>
  <style>
		h1 { text-align: center; }
	</style>
  <script type="text/javascript" >
	   function vaildData(){	
	      var login=document.login;
	      var account=login.account.value;
	      var pwd=login.pwd.value;
	      
	      if(account.length==0 ||account==""){
	    	  alert("계좌번호를 입력해 주십시오.");
	      }else if(pwd.length==0 ||pwd==""){
	    	  alert("비밀번호를 입력해 주십시오.");
	      }else{
	    	  login.method="post";
	    	  login.action="loginCheck.jsp";
	    	  login.submit();
		  }
	   }
	   
	</script>
</head>
<body>
	<h1>온라인 은행</h1>
   <form name = "login" action="loginCheck.jsp" method="post" encType="UTF-8" >
   <table  align="center" >
   <tr>
	   <td>계좌번호: <input type="text"  name = "account" /></td></tr>
	<tr><td>비밀번호: <input  type="password"   name="pwd" /></td></tr>
	<tr colspan=2>
		<td>
			<table >
			<tr>
				<td><input  type="button" value = "로그인 " onClick="vaildData()"' /></td>
	    		<td><input type="reset" value="다시입력"  /></td>
	    		<td><input type="button" value='회원가입' onClick='location.href="${pageContext.request.contextPath}/customerSignup.jsp"'/></td>
	   		</tr>
	   		</table>
	   </td>
	</tr>
	</table>
   </form> 
   
</body>
</html>
