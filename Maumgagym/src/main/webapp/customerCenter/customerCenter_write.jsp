  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//String userID = null;
	String userID = request.getParameter("userID");
%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<title>Maumgagym</title>
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
		<script type ="text/javascript">
		</script>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <!-- Core theme CSS (includes Bootstrap)-->
        
	    <link rel="stylesheet" href="./resources/asset/css/owl.carousel.min.css"/>
	
	    <link rel="stylesheet" href="./resources/asset/css/owl.theme.default.min.css"/>
	
	    <link href="./resources/asset/css/templatemo-pod-talk.css" rel="stylesheet"/>
	    
	    <!-- text편집기 -->

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
  <!-- 서머노트를 위해 추가해야할 부분 -->
  <script src="./customerCenter/resources/summernote-lite.js"></script>
  <script src="./customerCenter/resources/lang/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="./customerCenter/resources/summernote-lite.css">
  
	</head>
	
	<body>
	<jsp:include page="../include/header.jsp">
		<jsp:param name="userID" value="<%= userID %>"/>
	</jsp:include>	
	<jsp:include page="./customerCenter_source/main_search.jsp"/>
	
	
	<!-- main 컨텐츠 -->
	<jsp:include page="./customerCenter_source/customerCenter_write.jsp"/>
	<jsp:include page="./resources/script/customerCenter_write_jquery.jsp" />
	<jsp:include page="../include/footer.jsp" />
	

    
    <!-- JAVASCRIPT FILES -->
    <script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="./resources/asset/js/owl.carousel.min.js"></script>
    <script src="./resources/asset/js/custom.js"></script>
    
	</body>
</html>
