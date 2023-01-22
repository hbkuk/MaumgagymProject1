  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//String userID = null;
	String userID = request.getParameter("userID");
%>
 
<!DOCTYPE html>
<html>
   <head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0"/>
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<style type ="text/css">
	  #button-function {
		    margin-left: 325px;
		}
	  #title-function {
	  		margin-left: 10px;
	  }
	</style>
	<script type="text/javascript" src="./js/jquery-3.6.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script type ="text/javascript">
	</script>
</head>
	
	<body>
	<jsp:include page="../include/header.jsp">
		<jsp:param name="userID" value="<%= userID %>"/>
	</jsp:include>	
	
	
	<jsp:include page="../include/top.jsp" />
	
	<!-- main 컨텐츠 -->

	<jsp:include page="./cart_source/cart_view.jsp"/>
	<jsp:include page="../include/footer.jsp" />
	
   	<!-- Bootstrap core JS-->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
    
    <!-- JAVASCRIPT FILES -->
    <script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="./resources/asset/js/owl.carousel.min.js"></script>
    <script src="./resources/asset/js/custom.js"></script>
    
	</body>
</html>
