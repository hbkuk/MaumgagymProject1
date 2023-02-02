<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="model1.MemberDAO"%>
<%@page import="model1.MemberTO"%>
<%@page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = request.getParameter("id");
	String password = request.getParameter("password");
	
	MemberTO to = new MemberTO();
	to.setId(userid);
	to.setPassword(password);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String id = null;
	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	}
	if ( id != null ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
	}
	
	MemberDAO dao = new MemberDAO();
	int result = dao.login(to.getId(), to.getPassword());
	if(result == 1 ) {
		session.setAttribute("id", to.getId());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
	} 
	else if (result == 0 ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	} 
	else if (result == -1 ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
	} 
	else if (result == -2 ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('테이터베이스 오류 발생')");
		script.println("history.back()");
		script.println("</script>");
	}
%>

</body>
</html>