<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.send.mail.MailSender"%>
<%@page import="com.dao.member.MemberDAO"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("utf-8");
	
	MemberTO to = new MemberTO();
	to.setEmail(request.getParameter("email")); 
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

	MemberDAO dao = new MemberDAO();
	String userId = dao.checkId(to);
	if( userId != null  ) {
		String toEmail = to.getEmail();
		String toName = "테스트";
		String subject = "테스트 제목";
		String content = "<html><head><meta charset='utf-8'><style type = 'text/css'>body {color : red;}</style></head><body style='color:blue'>내용 테스트</body></html>";
		
		MailSender mailSender = new MailSender();
		mailSender.sendManil(toEmail, toName, subject, content);
		
		System.out.println("메일이 전송되었습니다.");
		
		script.println("<script>");
		script.println("alert('id 확인이 완료되었습니다. 이메일을 확인 후 다시 로그인 해주세요.')");
		script.println("location.href='/Maumgagym/homePage.jsp'");
		script.println("</script>");
		
	} else {
		script.println("<script>");
		script.println("alert('관리자에게 문의하세요.')");
		script.println("</script>");
	}
	
%>

</body>
</html>
