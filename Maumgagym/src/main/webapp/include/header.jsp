<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String userID = null;

	if( request.getParameter( "userID" ) != null && !"null".equals( request.getParameter( "userID" ) ) ) {
		userID = request.getParameter( "userID" );
	} 
	
%>       
    <!-- header navbar -->

	<nav class="navbar navbar-expand-lg navbar-light bg-white text-black">
	    <div class="container px-3 px-lg-5">
	        <a class="navbar-brand" href="#!"><img src="./resources/asset/images/logo_1.jpg" height="36"></a>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
	                <li class="nav-item px-4 "><a class="nav-link" href="#!">홈</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="./notificationPage.jsp">공지 / 이벤트</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="./communityPage.jsp">커뮤니티</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="#!">회원권 만들기</a></li>
	                <li class="nav-item px-4 navbar_992_show"><a class="nav-link" href="#!">고객센터</a></li>
	            </ul>
	            <%
	            	if( userID == null ) {
	            %>
	            <a class="navbar-brand ps-3 navbar_992_none" href="#">
	              <button type="button" class="btn btn-primary rounded-pill"><span style="font-size:smaller;">로그인</span></button>
	            </a>
	            <a class="navbar-brand ps-3 navbar_992_none" href="#">
	              <button type="button" class="btn btn-light rounded-pill"><span style="font-size:smaller;">회원가입</span></button>
	            </a>
       	        <%
	            	} else { 
	            %>
	            <a class="navbar-brand ps-3 navbar_992_none" href="#">
	              <i class="bi bi-chat-left-dots"></i>
	            </a>
	            <a class="navbar-brand ps-3 navbar_992_none" href="#">
	              <i class="bi bi-person"></i>
	            </a>
       	        <%
	            	}
	            %>
	        </div>
	    </div>
	</nav>

	<!-- /header navbar -->