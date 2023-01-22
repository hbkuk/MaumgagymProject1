<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String userID = request.getParameter("userID");
%>

<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>search</title>
		<link href="../resources/asset/css/bootstrap.min.css" rel="stylesheet" />
		<link href="../resources/asset/css/search_list.css" rel="stylesheet" />
		<!-- Font Awesome 5 CSS -->
		<link rel='stylesheet'
			href='https://use.fontawesome.com/releases/v5.7.2/css/all.css'>
		<!-- Products List CSS -->
		<link rel="stylesheet" href="css/style.css">
	</head>

	<body>
		<!-- header -->
		<jsp:include page="../include/header.jsp">
			<jsp:param name="userID" value="<%=userID%>" />
		</jsp:include>
	
		<!-- 검색 결과 게시판 -->
		<jsp:include page="./search_source/search_list.jsp" />
	
		<!-- footer -->
		<jsp:include page="../include/footer.jsp" />
	</body>
</html>