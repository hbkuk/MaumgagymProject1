<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="login_form">
	<div id = "logoContainer">
		<a href="./homePage.jsp"><img id = "logo" src="./resources/asset/images/logo_1.jpg"/></a>
	</div>
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
			<button id="loginBtn" class="custom-btn btn-12" type="button"><span>로그인!</span><span>로그인 하기</span></button>
		</div>
	</form>
	<div class="caption">
		<a href="./createAccountPage.jsp">아직 회원이 아니세요?</a>
	</div>
	<div class="caption">
		<a href="./searchIDPage.jsp">아이디가 기억나지 않으세요?</a> | <a href="./searchPasswordPage.jsp">비밀번호가 기억나지 않으세요?</a>
	</div>
</div>