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
		<jsp:useBean id="cab" class="task2.C_accountBean"/>
		<jsp:setProperty property="*" name="cab"/>
		<%
			String mode = request.getParameter("mode");		
		%>
		<c:set var="mode" value="<%=mode %>"/>
		<c:choose>
			<c:when test="${mode == 'add' }">
			<%
				cab.setAccount(((CustomerBean)(session.getAttribute("cb"))).getAccount());
				//cab.setBalance("already");
				new C_accountDAO().addContent(cab);
			%>
			<c:redirect url="main.jsp"/>
			</c:when>
			<c:when test="${mode == 'send' }">
				<jsp:setProperty property="account" name="cab" param="another"/>
				<%--jsp:setProperty property="account" name="cab"/--%>
				<%
					//cab.setAccount(((CustomerBean)(session.getAttribute("cb"))).getAccount());
					String s_name = request.getParameter("s_name");                                  System.out.println(cab.getAccount());
					String s_account = request.getParameter("s_account");
					CustomerBean bean = new CustomerBean();
					CustomerDAO cdao = new CustomerDAO();
					bean.setAccount(cab.getAccount());
					bean.setName((cdao.getCustomerInfo(cab.getAccount()).getName()));
					
					boolean exist = cdao.checkCustomerID(bean);								System.out.println(exist);
					String breakdown = s_name+"("+bean.getAccount()+") 입금";
					cab.setBreakdown(breakdown);
					
					C_accountBean s_cb = new C_accountBean();
					s_cb.setAccount(((CustomerBean)(session.getAttribute("cb"))).getAccount());
					
					s_cb.setDeposit("-"+cab.getDeposit());
					s_cb.setBreakdown(bean.getName()+"("+s_account+") 송금");
					
				%>
				<c:choose>
					<c:when test="<%=exist %>">
					<%
						new C_accountDAO().addContent(cab);
						new C_accountDAO().addContent(s_cb);
					%>
					<c:redirect url="main.jsp"/>
					</c:when>
					<c:otherwise>
						<script>
							alert('존재하지 않는 계좌입니다.'); 
							location.href='main.jsp';
						</script>
					</c:otherwise>
				</c:choose>
				
				
			</c:when>
			<c:when test="${mode == 'edit' }">
				<c:choose>
					<c:when test="${param.kind=='breakdown' }">
						<%
						CustomerBean cb = (CustomerBean)session.getAttribute("cb");
						cab.setAccount(cb.getAccount());
						cab.setBreakdown(request.getParameter("breakdown"));
						cab.setInsertDay(request.getParameter("insertDay"));
						
						new C_accountDAO().updateBreakdown(cab);
						%>
						<script type="text/javascript">
							window.opener.location.reload();
							window.close();
						</script>
					</c:when>
					<c:when test="${param.kind=='pwd' }">
						<%
						CustomerBean cb = (CustomerBean)session.getAttribute("cb");
						cb.setPwd(request.getParameter("pwd"));
						boolean result = new CustomerDAO().updatePwd(cb);
						%>
						<c:if test="<%=result %>">
							<script type="text/javascript">
								alert('변경완료!');
								location.href='myPage.jsp';
							</script>
						</c:if>
						<c:if test="<%=!result %>">
							<script type="text/javascript">
								alert('변경실패!'); 
							</script>
						</c:if>
					</c:when>
					<c:when test="${param.kind=='address' }">
						<%
						CustomerBean cb = (CustomerBean)session.getAttribute("cb");
						cb.setAddress(request.getParameter("address"));
						boolean result = new CustomerDAO().updatePwd(cb);
						%>
						<c:if test="<%=result %>">
							<script type="text/javascript">
								alert('변경완료!');
								location.href='myPage.jsp';
							</script>
						</c:if>
						<c:if test="<%=!result %>">
							<script type="text/javascript">
								alert('변경실패!'); 
							</script>
						</c:if>
					</c:when>
					
				</c:choose>
				
			</c:when>
		</c:choose>
		<c:if test="">
			
		</c:if>
	</c:otherwise>
</c:choose>
</body>
</html>