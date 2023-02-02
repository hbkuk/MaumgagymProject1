<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
%>
<form action="./member/Action/joinAction1.jsp" id ="sfrm" method="post" name="sfrm" >
	<input type="hidden" name="type" value="C" />
	<div class="member">
	    <!-- 로고 -->
	   	<div id = "logoContainer">
			<a href="./homePage.jsp"><img id = "logo" src="./resources/asset/images/logo_1.jpg"/></a>
		</div>
	
	    <!-- 필드 -->
	    <div class="field">
	        <b>아이디</b>
	        <span class="placehold-text placehold-id hasId"><input id="id" type="text" name="id"></span>
	    </div>
	    
	    <div class="field">
	        <b>비밀번호</b>							
	        <span class="placehold-text placehold-pw">
	        <input id="pw" class="userpw" type="password" name ="password">
	        </span>
	        
	        <b>비밀번호 재확인</b>
	        <span class="placehold-text placehold-pw-confirm">
	        <input id="pw-confirm" class="userpw-confirm" type="password" name="password_confirm">
	        <input type="button" id="check" value="일치 확인">
	        </span> 
	    </div>
	
	
	    <!-- 이메일_전화번호 -->
	    <div class="field email_field">
	        <b id = "b_email">이메일</b>
		        <input type="text" id="mail1" name="mail1"> @ 
		        <select id="mail2" name="mail2">
					<option>naver.com</option>
					<option>daum.net</option>
					<option>nate.com</option>
					<option>gmail.com</option>
				</select>
	        <!--<input name="email" id ="email" type="email" placeholder="가입하기 버튼을 누르시면 이메일이 전송됩니다."><input type="button" id="email_submit" value="전송하기"> -->
	    </div>
	    
	     <!-- 회사명 입력 -->
	   	 <div class="field">
		        <b>회사/점포명</b>
		        <span class="placehold-tex"><input id="companyname" type="text" name="president"></span>
	     </div>
	         
		<!-- 대표 입력 -->
		<div class="field">
		      <b>대표명</b>
		      <span class="placehold-tex"><input id="president" type="text" name="president"></span>
	     </div>
	     
	    <!-- 회사 주소 입력 -->
        <div class="field address_field">
            <div class="userInput">
                <b>회사/점포 주소</b>
               	<input type="text" id="postcode" name="zipcode" placeholder="우편번호">
				<input type="button" id="search" onclick="execDaumPostcode()" value="우편번호 찾기">
				<input type="text" id="address" name="address" placeholder="주소"><br>
				<input type="hidden" id="detailAddress" name="fullAddress">
				<input type="text" id="extraAddress" name="referAddress" placeholder="참고항목">
        </div>
        
	
	    <!-- 가입하기 버튼 --> 
	  	<!-- <input type="hidden" id="action" value="insert_ok" />  -->
	    <br/>
	    <input id="joinBtn" type="submit" value="가입하기">
	    <br/>
	    
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