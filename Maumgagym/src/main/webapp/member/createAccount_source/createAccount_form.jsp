<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="./signUp_Json/signUp_ok.jsp" id = "sfrm" method="post" name="sfrm" >
	<div class="member">
	    <!-- 1. 로고 -->
	   	<div id = "logoContainer">
			<a href="./homePage.jsp"><img id = "logo" src="./resources/asset/images/logo_1.jpg"/></a>
		</div>
	
	    <!-- 2. 필드 -->
	    <div class="field">
	        <b>닉네임</b>
	        <span class="placehold-text placehold-nickName hasnickName"><input id = "nickName" type="text" name="nickName"></span>
	    </div>
	    <div class="field">
	        <b>아이디</b>
	        <span class="placehold-text placehold-id hasId"><input id = "id" type="text" name = "id"></span>
	    </div>
	    <div class="field">
	        <b>비밀번호</b>
	        <span class="placehold-text placehold-pw"><input id="pw" class="userpw" type="password" name = "password"></span>
	    </div>
	    <div class="field">
	        <b>비밀번호 재확인</b>
	        <span class="placehold-text placehold-pw-confirm"><input id="pw-confirm" class="userpw-confirm" type="password" name = "password_confirm"></span>
	    </div>
	    <div class="field">
	        <b>이름</b>
	        <input id="name" type="text" name="name">
	    </div>
	
	    <!-- 3. 필드(생년월일) -->
	    <div class="field birth">
	        <b>생년월일</b>
	        <div>
	            <input id="year" type="number" name="year" placeholder="년(4자)">                
	            <select id = "month" name = "month">
	                <option value="00">월</option>
	                <option value="01">1월</option>
	                <option value="02">2월</option>
	                <option value="03">3월</option>
	                <option value="04">4월</option>
	                <option value="05">5월</option>
	                <option value="06">6월</option>
	                <option value="07">7월</option>
	                <option value="08">8월</option>
	                <option value="09">9월</option>
	                <option value="10">10월</option>
	                <option value="11">11월</option>
	                <option value="12">12월</option>
	            </select>
	            <input id="day" type="number" name="day" placeholder="일">
	        </div>
	    </div>
	
	    <!-- 4. 필드(성별) -->
	    <div class="field gender">
	        <b>성별</b>
	        <div>
	        	<label><input type="radio" name="gender" value="0">선택안함</label>
	            <label><input type="radio" name="gender" value="1">남자</label>
	            <label><input type="radio" name="gender" value="2">여자</label>
	        </div>
	    </div>
	
	    <!-- 5. 이메일_전화번호 -->
	    <div class="field email_field">
	        <b id = "b_email">본인 확인 이메일</b>
	        <input name="email" id = "email" type="email" placeholder="가입하기 버튼을 누르시면 이메일이 전송됩니다."><input type="button" id="email_submit" value="전송하기">
	    </div>
	   
	
	    <!-- 6. 가입하기 버튼 -->
	    <input id="joinBtn" type="submit" value="가입하기">
	    
	     <!-- 이동하기 링크 -->
   		<div class="caption">
   			<div>
				<a href="./loginPage.jsp">로그인</a>
				<a href="./forgetId.jsp">아이디 찾기</a>
				<a href="./forgetPw.jsp">비밀번호 찾기</a>
			</div>
		</div>

	</div>
</form>