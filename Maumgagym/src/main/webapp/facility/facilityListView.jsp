<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userID = null;
	//String userID = request.getParameter("userID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="./resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	<link href="./resources/asset/css/facility_list.css" rel="stylesheet" />
    <!-- Bootstrap icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- Core theme CSS (includes Bootstrap)-->
      
</head>
<body>
	
	<!-- header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="userID" value="<%=userID%>" />
	</jsp:include>
	<jsp:include page="../main/main_source/main_search.jsp" />
	
	<!-- 운동시설 게시판 -->
	<jsp:include page="./facility_source/facility_list.jsp" />
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
	<!-- script -->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
	<script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="./resources/asset/js/owl.carousel.min.js"></script>
    <script src="./facility/facility_source/facilityList.js"></script>
</body>
</html>