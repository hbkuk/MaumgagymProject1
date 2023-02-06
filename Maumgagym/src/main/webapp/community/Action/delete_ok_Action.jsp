<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
    
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="com.to.board.CommunityDAO"%>
<%@page import="com.to.board.BoardTO"%>
    
<%

	request.setCharacterEncoding("utf-8");
	
	MemberTO to1 = new MemberTO();
	BoardTO to = new BoardTO();
	
	to1.setPassword(request.getParameter("password")); // member
	to.setSeq(Integer.parseInt(request.getParameter("seq"))); //board
	
	CommunityDAO dao = new CommunityDAO();
	int flag = dao.boardDeleteOK(to1, to);
			
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	PrintWriter script = response.getWriter();

	if( flag == 0 ) {
		script.println("<script>");
		script.println("alert('삭제 되었습니다.')");
		script.println("location.href='/Maumgagym/communityPage.jsp'");
		script.println("</script>");
	}else {
		script.println("<script>");
		script.println("alert('서버 오류. 관리자에게 문의하세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>

</body>
</html>
