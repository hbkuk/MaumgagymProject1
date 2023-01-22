<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
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
		    /* display: inline-block;
		    position: relative;
		    margin : 20px;
		  border: 1px solid #58595b; 
		    border-radius: 4px;
		    padding: 5px 20px;
		    width: 650px;
		    height: 60px;
		    cursor: text;*/
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
    
    <!--  header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="userID" value="<%= userID %>"/>
	</jsp:include>

	<!-- 공지/이벤트 게시판 템플릿 -->
	<jsp:include page="./community_source/community_board_container1.jsp"/>
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
</body>
</html>