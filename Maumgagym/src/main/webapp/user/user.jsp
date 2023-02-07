<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	String id = null;
	
	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	} else {
		id = null;
	}
	
	String type = null;
	
	if( session.getAttribute("type") != null ) {
		type = ( String ) session.getAttribute("type");
	} else {
		type = null;
	}
	
	String nickname = null;
	
	if( session.getAttribute("nickname") != null ) {
		nickname = ( String ) session.getAttribute("nickname");
	} else {
		nickname = null;
	}
	
	
	if( id == null || type == null ||  nickname == null ) {
		out.println( "<script type = 'text/javascript'>");
		out.println( "alert( '로그인을 하셔야 합니다.'); " );
		out.println( "location.href='./loginPage.jsp';" );
		out.println( "</script>" );
	}
	
	//System.out.println( id );

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마음가짐 일반회원 마이페이지</title>
	<link href="./resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	<link href="./resources/asset/css/user.css" rel="stylesheet" />
    <!-- Bootstrap icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	
	<!-- review css -->
	<link href="./user/user_source/review.css" rel="stylesheet" />
	
</head>
<body>
	
	<!-- header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="id" value="<%= id %>" />
	</jsp:include>
	
	<jsp:include page="../main/main_source/main_search.jsp" />
	
	<!-- 마이페이지 -->
	<jsp:include page="./user_source/user_view.jsp">
		<jsp:param name="id" value="<%= id %>" />
	</jsp:include>
	
	<!-- modal -->
	<jsp:include page="./user_source/memberModify_modal.jsp" />
	<jsp:include page="./user_source/review_modal.jsp" />
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
	<jsp:include page="./user_source/register_modal.jsp" />
	
	<!-- script -->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
	<script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="./resources/asset/js/owl.carousel.min.js"></script>
    <script src="./user/user_source/user.js"></script>
    
</body>
</html>