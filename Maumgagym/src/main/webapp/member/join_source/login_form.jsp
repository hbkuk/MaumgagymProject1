<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="login_form">
	<h1><a href="./home.jsp"><img src="./resources/asset/images/logo_1.jpg"/></a></h1>
	<form action="./login_Json/login_ok.jsp" id="lfrm" method="post" name="lfrm">
		<div class="int-area">
			<input type="text" name="id" id="id" autocomplete="off" required>
			<label for="id">아이디</label>
		</div>
		<div class="int-area">
			<input type="password" name="pw" id="pw" autocomplete="off" required>
			<label for="pw">비밀번호</label>
		</div>
		<div class="btn-area">
			<button id="loginBtn" type="button" >마음가짐 로그인</button>
		</div>
	</form>
	<div class="caption">
		<a href="./signUp.jsp">아직 회원이 아니세요?</a>
	</div>
	<div class="caption">
		<a href="./forgetId.jsp">아이디가 기억나지 않으세요?</a> | <a href="./forgetPw.jsp">비밀번호가 기억나지 않으세요?</a>
	</div>
</div>