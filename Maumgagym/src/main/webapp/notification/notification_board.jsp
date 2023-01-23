<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String userID = null;
%>   
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0"/>
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<style type ="text/css">
	</style>
	<script type="text/javascript" src="./resources/asset/script/jquery-1.11.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script type ="text/javascript">
	</script>
</head>
<body>
    
    <!--  header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="userID" value="<%= userID %>"/>
	</jsp:include>
	
	<!-- 공지/이벤트 게시판 템플릿 -->
	<jsp:include page="./notification_source/notification_board_container1.jsp"/>

	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
</body>
</html>