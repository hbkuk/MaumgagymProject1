<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String userID = request.getParameter("userID");     
%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<title>Maumgagym</title>
	    <link href="./resources/asset/css/member_custom.css" rel="stylesheet"/>
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="./resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	</head>
	
	<body>

	<jsp:include page="./join_source/login_form.jsp"/>

    <script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
   	<!-- Bootstrap core JS-->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
	</body>
</html> 