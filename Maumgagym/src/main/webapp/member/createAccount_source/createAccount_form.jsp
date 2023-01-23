<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>나우 회원가입</title>
<link rel="icon" href="./css/images/favicon.png">
<link rel="stylesheet" href="./css/signUp.css">
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">

	window.history.forward(); 
	function noBack(){ 
		 window.history.forward();
	}

	$( document ).ready(function() {
		
		$( '#joinBtn' ).on( 'click', function() {
			if ( $( "#nick" ).val() == '' ) {
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
			
			if ( nickFlag != 0 ) { 
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
		
		// 입력값 검사 진행할 것.... 공백이 아니거나... 뭐 .. 그런거..?
		
        let timeout = null;
        
		// 1은 사용 안됨, 0은 가능.. json은 반대여서 .. 한번에 바꾸겠음.
		let nickFlag = 1;
		
		$("#nick").keydown(function(){
		nickFlag = 1;
		//console.log( nickFlag );
		
         clearTimeout(timeout);

	         timeout = setTimeout(function () {
	
	 			$.ajax({
					url: './signUp_Json/hasNick.jsp',
					type: 'get',
					data: {
						nick : $("#nick").val()
					},
					dataType: 'json',
					success: function( jsonData ) {
						if( jsonData.flag == 0 ) {
							
							nickFlag = 1;
							//console.log( nickFlag );
							$('.placehold-nick').removeClass('hasNick'); 
							$('.placehold-nick').removeClass('ableNick'); 
							$('.placehold-nick').addClass('notAbleNick');
							
						} else {
							
							nickFlag = 0;
							//console.log( nickFlag );
							$('.placehold-nick').removeClass('hasNick'); 
							$('.placehold-nick').removeClass('notAbleNick');
							$('.placehold-nick').addClass('ableNick');
							
						}
					},
					error: function(err) {
						alert( '[에러] ' + err.status);
					}
				});
	            
	         }, 500);
				
				  
			});
		let idFlag = 1; 
		$("#id").keydown(function(){
		idFlag = 1;
         clearTimeout(timeout);

	         timeout = setTimeout(function () {
	            
	 			$.ajax({
					url: './signUp_Json/hasId.jsp',
					type: 'get',
					data: {
						id : $("#id").val()
					},
					dataType: 'json',
					success: function( jsonData ) {
						if( jsonData.flag == 0 ) {
							//console.log( '사용불가' );
							idFlag = 1;
							$('.placehold-id').removeClass('hasId'); 
							$('.placehold-id').removeClass('ableId'); 
							$('.placehold-id').addClass('notAbleId');
							
						} else {
							idFlag = 0;
							//console.log( '사용가능' );
							
							$('.placehold-id').removeClass('hasId'); 
							$('.placehold-id').removeClass('notAbleId');
							$('.placehold-id').addClass('ableId');
						}
					},
					error: function(err) {
						alert( '[에러] ' + err.status);
					}
				});
	            
	         }, 500);
				
				  
			});
		
		// 비밀번호 눌렀을 때
		$("#pw").keydown(function(){
	         clearTimeout(timeout);

		         timeout = setTimeout(function () {
					
		        	 if( $( '#pw' ).val().length > 10 ) {
		        		 	//console.log( pwFlag );
							$('.placehold-pw').addClass('ablePw'); 
							$('.placehold-pw').removeClass('notAblePw');
							
							$('.placehold-pw-confirm').removeClass('hasPw');
		        		 
		        	 } else {
		        		 	//console.log( pwFlag );
							$('.placehold-pw').removeClass('ablePw'); 
							$('.placehold-pw').addClass('notAblePw');
							
							$('.placehold-pw-confirm').removeClass('hasPw');
		        		 
		        	 }
		            
		         }, 500);
					
					  
			});
		
		let pwFlag = 0;
		// 비밀번호 재확인 눌렀을 떄
		$("#pw-confirm").keydown(function(){
			pwFlag = 1;
			//console.log( pwFlag );
			
			if( pwFlag == 1) {
			
	         clearTimeout(timeout);

		         timeout = setTimeout(function () {
		        	 
		        	 //console.log( $( '#pw' ).val() );
        		 	 //console.log( $( '#pw-confirm'  ).val() );
					
		        	 if( $( '#pw' ).val() == $( '#pw-confirm' ).val() ) {
		        		pwFlag = 0;	 
		        		 	$('.placehold-pw-confirm').removeClass('hasPw');
		        		 
							$('.placehold-pw-confirm').addClass('ablePwConfirm'); 
							$('.placehold-pw-confirm').removeClass('notAblePwConfirm');
		        		 
		        	 } else {
		        		 pwFlag = 1; 
		        			 $('.placehold-pw-confirm').removeClass('hasPw');
		        		 
							$('.placehold-pw-confirm').removeClass('ablePwConfirm'); 
							$('.placehold-pw-confirm').addClass('notAblePwConfirm');
		        		 
		        	 }
		            
		         }, 500);
					
			} else {
				
				$('.placehold-pw-confirm').addClass('hasPw'); 
				
			}
			
		});
		
		$( '#email_submit').on( 'click', function() {
			if ( $( "#email" ).val() == '' ) {
				alert( "이메일 입력 후 인증하셔야 합니다.");
				return false;
				
			} else {
				
				// 우선 이미 등록된 이메일인지 확인
				$.ajax({
					url: './signUp_Json/hasEmail.jsp',
					type: 'get',
					data: {
						email : $('#email').val(),
					},
					dataType: 'json',
					success: function( jsonData ) {
						
						if( jsonData.flag == 0 ) {
							alert( '이미 등록된 이메일 입니다.' );
							return false;
							
						} else {
							
							if( timeoutHandle1 === undefined && timeoutHandle2 === undefined ) {
								$( 'span#timer' ).remove();
								$( '#b_email' ).append('<span id="timer"></span>');
								countdown(1, 00); 
								
							} else {
								
								//alert( '재 전송' );
								clearTimeout( timeoutHandle1 );
								clearTimeout( timeoutHandle2 );
								$( 'span#timer' ).remove();
								$( '#b_email' ).append('<span id="timer"></span>');
								countdown(1, 00); 
							}
							
							$.ajax({
								url: './signUp_Json/Mail_sender.jsp',
								type: 'get',
								data: {
									email : $('#email').val(),
									nick : $('#nick').val()
								},
								dataType: 'json',
								success: function( jsonData ) {
									
									if( jsonData.flag == 0 ) {
									} else {
										alert( '서버 에러' );
								}
									
								},
								error: function(err) {
									alert( '[에러] ' + err.status);
								}
							});
							
							
							$( '#email_confirm' ).remove();
							$( '#email_confirm_btn' ).remove();
							$( '.email_field').append( '<input id = "email_confirm" type="text" placeholder="인증번호를 입력하세요." maxlength="6" ><input id="email_confirm_btn" type="button" onclick="confirmBtn()" value="인증하기">' )
							
						}
						
					},
					error: function(err) {
						alert( '[에러] ' + err.status);
						return false;
					}
				});
			}
			
		});
		
	});
	
	//let cFlag = 0;
	let timeoutHandle1;
	let timeoutHandle2;
	
	function countdown(minutes, seconds) {
	        function tick() {
	            let counter = $( '#timer' ).text( minutes.toString() + ":" + (seconds < 10 ? "0" : "") + String(seconds) ); 
	            seconds--;
	            if (seconds >= 0) {
	                timeoutHandle1 = setTimeout(tick, 1000);
	                
	            } else {
	                if (minutes >= 1) {
	                timeoutHandle2 = setTimeout(function () {
	                        countdown(minutes - 1, 59);
	                    }, 1000);
	                }
	            }
	        }
	        tick();
	    }
	
	let emailFlag = 1;
	const confirmBtn = function() {
		
		if( $( '#timer').html() == '0:00' ) {
			emailFlag = 1;
			alert( '인증이 만료되었습니다. 다시 시도해주세요.');
		} else {
			$.ajax({
				url: './signUp_Json/Mail_Confirm.jsp',
				type: 'get',
				data: {
					
					mail : $('#email').val(),
					CetificationNumber : $('#email_confirm').val()
				},
				dataType: 'json',
				success: function( jsonData ) {
					
					if( jsonData.flag == 0 ) {
						alert( '[인증 완료] 가입을 완료해 주세요.' );
						emailFlag = 0;
						$("#email_submit").attr("disabled", "disabled");
						$("#email_submit").css('background', '#B2B2B2');
						
						$("#email_confirm_btn").attr("disabled", "disabled");
						$("#email_confirm_btn").css('background', '#B2B2B2');
					} else {
						emailFlag = 1;
						alert( '[인증 실패] 인증번호가 틀립니다. 다시 시도해 주세요.' );
						
						$("#email_confirm_btn").attr("disabled", "disabled");
						$("#email_confirm_btn").css('background', '#B2B2B2');
				}
					
				},
				error: function(err) {
					alert( '[에러] ' + err.status);
				}
			});
			
			
		}
	};

</script>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<form action="./signUp_Json/signUp_ok.jsp" id = "sfrm" method="post" name="sfrm" >
	<div class="member">
	    <!-- 1. 로고 -->
	    <img class="logo" src="./css/images/logo-now.png">
	
	    <!-- 2. 필드 -->
	    <div class="field">
	        <b>닉네임</b>
	        <span class="placehold-text placehold-nick hasNick"><input id = "nick" type="text" name="nick"></span>
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
	       ;     <label><input type="radio" name="gender" value="2">여자</label>
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
				<a href="./logIn.jsp">로그인</a>
				<a href="./forgetId.jsp">아이디 찾기</a>
				<a href="./forgetPw.jsp">비밀번호 찾기</a>
			</div>
		</div>

	    <!-- 7. 푸터 -->
	    <div class="member-footer">
	        <div>
	            <a href="#none">이용약관</a>
	            <a href="#none">개인정보처리방침</a>
	            <a href="#none">책임의 한계와 법적고지</a>
	            <a href="#none">회원정보 고객센터</a>
	        </div>
	        <span><a href="#none">NOW Corp.</a></span>
	    </div>
	</div>
</form>
</body>
</html>