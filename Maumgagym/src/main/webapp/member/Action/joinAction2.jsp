<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="model1.MemberDAO"%>
<%@page import="model1.MemberTO"%>
<%@ page import = "java.io.PrintWriter" %>

<%
request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="member" class="model1.MemberTO" scope="page"/>

<jsp:setProperty name="member" property="nickname"/>
<jsp:setProperty name="member" property="id"/>
<jsp:setProperty name="member" property="password"/>
<jsp:setProperty name="member" property="name"/>
<jsp:setProperty name="member" property="email"/>
<jsp:setProperty name="member" property="birthday"/>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if(member.getNickname() == null || member.getId() == null || member.getPassword() == null ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}else {
		MemberDAO dao = new MemberDAO();
		int result = dao.join(member);
		
		if(result == -1 ) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 존재하는 아이디 입니다.')");
	script.println("history.back()");
	script.println("</script>");
		} //db에 정보가 저장된 후 바로 로그인페이지로 이동
		else{
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href='/Maumgagym/homePage.jsp'");
	script.println("</script>");
		} 
	}
%>

</body>
</html>