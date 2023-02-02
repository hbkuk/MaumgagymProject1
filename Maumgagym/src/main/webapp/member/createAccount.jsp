<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<title>Maumgagym</title>
	    <link href="./resources/asset/css/createAccount_custom.css" rel="stylesheet"/>
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	    
        <!-- jquery-->
        <script src="http://code.jquery.com/jquery-latest.js"></script> 
        <!-- 다음 우편번호찾기 API -->
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("sample6_extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("sample6_extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode;
		                document.getElementById("sample6_address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("sample6_detailAddress").focus();
		            }
		        }).open();
		    }
		</script>
		
		<script type="text/javascript">
		<!-- 
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
					
				<!-- 	var obj_length = document.getElementsByName("gender").length;
					var selectedGender = "";
		
					for (var i=0; i<obj_length; i++) {
					    if (document.getElementsByName("gender")[i].checked == true) {
					    	selectedGender = document.getElementsByName("gender")[i].value;
					    }
					}
		
					if( selectedGender == "") {
					    alert( "성별 항목 중 무조건 하나는 선택하셔야 합니다.");
					    return false;
					} -->
					<!-- 
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
			 -->
		    
		</script>
		</head>
		<body>
		<!--  <body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">  -->

		<jsp:include page="./createAccount_source/createAccount_form.jsp"/>
		
	    <script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
	   	<!-- Bootstrap core JS-->
	    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
	   
	   <!-- 비밀번호 일치 검사 -->
	    <script type="text/javascript">
		
	    $(document).ready(function(){
	   		 $("#check").click(function() {
				console.log('함수실행확인');
		      var p1 = document.getElementById('pw').value;
		      var p2 = document.getElementById('pw-confirm').value;
		      if( p1 == ''){
		    	  alert("입력된 비빌먼호가 없습니다.");
		      }else{
			      if( p1 != p2 ) {
			        alert("비밀번호가 일치 하지 않습니다");
			        return false;
			      } else{
			        alert("비밀번호가 일치합니다");
			        return true;
			      }
	   		 }
		      
		    });
	    });
	    
	    $(document).ready(function(){ 
	    	 $("#check").click(function() {
	    	
	    	 });
	    });
		</script>
	   
		</body>
</html> 