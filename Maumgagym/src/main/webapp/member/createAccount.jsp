<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<title>Maumgagym</title>
	    <link href="./resources/asset/css/createAccount_custom.css" rel="stylesheet"/>
        <!-- jquery-->
        <script src="http://code.jquery.com/jquery-latest.js"></script> 
		<script type="text/javascript">
		
			window.history.forward(); 
			function noBack(){ 
				 window.history.forward();
			}
		
			$( document ).ready(function() {
				
				$( '#joinBtn' ).on( 'click', function() {
					if ( $( "#nickName" ).val() == '' ) {
						alert( "닉네임을 입력하세요.");
						return false;
					}
					
					if ( $( "#id" ).val() == '' ) {
						alert( "아이디를 입력하세요.");
						return false;
					}
					
					if ( $( "#pw" ).val() == '' ) {
						alert( "비밀번호를 입력하세요.");
						return false;
					}
					
					if ( $( "#pw-confirm" ).val() == '' ) {
						alert( "비밀번호 재확인을 입력하세요.");
						return false;
					}
					
					if ( $( "#name" ).val() == '' ) {
						alert( "이름을 입력하세요.");
						return false;
					}
					
					if ( $( "#year" ).val() == '' ) {
						alert( "연도를 입력하세요.");
						return false;
					}
					
					if ( $( "#month" ).val() == '0' ) {
						alert( "월을 선택하세요.");
						return false;
					}
					
					if ( $( "#day" ).val() == '' ) {
						alert( "일을 선택하세요.");
						return false;
					}
					
					var obj_length = document.getElementsByName("gender").length;
					var selectedGender = "";
		
					for (var i=0; i<obj_length; i++) {
					    if (document.getElementsByName("gender")[i].checked == true) {
					    	selectedGender = document.getElementsByName("gender")[i].value;
					    }
					}
		
					if( selectedGender == "") {
					    alert( "성별 항목 중 무조건 하나는 선택하셔야 합니다.");
					    return false;
					}
					
					if ( $( "#email" ).val() == '' ) {
						alert( "이메일 입력 후 인증하셔야 합니다.");
						return false;
					}
					
					if ( nickNameFlag != 0 ) { 
						alert( "닉네임을 다시 한번 확인해주세요.");
						return false;
					}
					
					if ( pwFlag != 0 ) { 
						alert( "비밀번호를 다시 한번 확인해주세요.");
						return false;
					}
					
					if ( emailFlag != 0 ) { 
						alert( "이메일을 다시 한번 확인해주세요.");
						return false;
					}
					
					document.getElementById('sfrm').submit();
					
				});
			});
		</script>
		</head>
		<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">

		<jsp:include page="./createAccount_source/createAccount_form.jsp"/>
	
	    <script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
	   	<!-- Bootstrap core JS-->
	    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
	   
		</body>
</html> 