<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>회원 가입</title>
   <script type="text/javascript" >
	   function vaildData(){	
	      var signup=document.signup;
	      var name=signup.name.value;
	      var pwd=signup.pwd.value;
	      var address=signup.address.value;
	      
	      if(name.length==0 ||name==""){
	    	  alert("이름을 입력해 주십시오.");
	      }else if(pwd.length==0 ||pwd==""){
	    	  alert("비밀번호를 입력해 주십시오.");
	      }else if(address.length==0 ||address==""){
	    	  alert("주소를 입력해 주십시오.");
	      }else{
	    	  signup.method="post";
	    	  signup.action="signup.jsp";
	    	  signup.submit();
		  }
	   }
	   
	</script>
 </head>
<body>
<form name= "signup" method="post" action="signup.jsp" encType="UTF-8" >
<h1  style="text-align:center">회원 가입창</h1>
<table  align="center">
    <tr>
        <td width="200"><p align="right">이름</td>
        <td width="400"><input type="text"  name="name"></td>
    </tr>
    <tr>
        <td width="200"><p align="right">계좌비밀번호</td>
        <td width="400"><p><input type="password"  name="pwd"></td>
    </tr>
    <tr>
        <td width="200"><p align="right">주소</td>
        <td width="400"><p><input type="text"  name="address"></td>
    </tr>
    <tr>
        <td width="200"><p>&nbsp;</p></td>
        <td width="400">
	<input type="button" value="회원가입" onClick="vaildData()"'>
	<input type="button" value="취소" onClick="location.href='login.jsp'">
  </td>
    </tr>
</table>
</form>
</body>
</html>
