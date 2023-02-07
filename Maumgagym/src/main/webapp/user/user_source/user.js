
function membershipRegister( data ){ 
	
	$.ajax({
	url: './user/user_source/membership_register_ok.jsp',
	type: 'post',
	data: {
		
		merchant_uid : data.value
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			
			$( data ).attr("disabled", true);			
			$( data ).removeClass( 'btn-primary' );
			$( data ).addClass( 'btn-secondary' );
			$( data ).text( '승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요.' );
			
		} else {
			
			alert( '서버 오류' );
			
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}

let merchant_uid;

// 등록 승인 관련
function registerConfirm( data  ){ 

	console.log( data.value );
	
	$('#registerConfirmMessage').text( data.id +" 님의 회원권을 정말로 승인 하시겠습니까?" );
	
	$('#registerModal').modal("show");
	
	merchant_uid = data.value;
}

$("#registerOk").on( 'click', function(){

	console.log( "registerOk" + merchant_uid );
	RegisterOk( merchant_uid );
	
  });


$("#registercancle").on( 'click', function(){

	alert("결제 취소를 눌렀습니다.");
  });


function RegisterOk( data ) { 
	
	$.ajax({
	url: './user/user_source/register_ok.jsp',
	type: 'post',
	data: {
		
		merchant_uid : data
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			
			console.log( '성공' );
			
			// 새로고침 
			location.reload();
			

			
		} else {
			
			alert( '실패' );
			
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}

// 등록 승인 관련

// 홀딩 관련

function pauseConfirm( data  ){ 

	//console.log( data.value );
	
	$('#pauseConfirmMessage').text( data.id +" 님의 회원권을 정말로 중지 하시겠습니까?" );
	
	$('#pauseModal').modal("show");
	
	merchant_uid = data.value;
}

$("#pauseOk").on( 'click', function(){

	console.log( "pauseOk" + merchant_uid );
	pauseOk( merchant_uid );
	
  });


$("#pausecancle").on( 'click', function(){

	alert("결제 취소를 눌렀습니다.");
  });


function pauseOk( data ) { 
	console.log( data );
	$.ajax({
	url: './user/user_source/pause_ok.jsp',
	type: 'post',
	data: {
		merchant_uid : data
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			
			console.log( '성공' );
			
			location.reload();
			
		} else if ( jsonData.flag == 1 ) {
			
			alert( '이전 회원권 중지 사용' );
			
		} else {
			alert( '서버 오류' );
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}

// 홀딩 관련
 
 
// 재개 관련 

function restartConfirm( data  ){ 

	$('#restartConfirmMessage').text( data.id +" 님의 회원권을 정말로 재개 하시겠습니까?" );
	
	$('#restartModal').modal("show");
	
	merchant_uid = data.value;
}

$("#restartOk").on( 'click', function(){

	console.log( "restartOk" + merchant_uid );
	restartOk( merchant_uid );
	
  });


$("#restartcancle").on( 'click', function(){

	alert("결제 취소를 눌렀습니다.");
  });


function restartOk( data ) { 
	console.log( data );
	$.ajax({
	url: './user/user_source/restart_ok.jsp',
	type: 'post',
	data: {
		merchant_uid : data
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			
			console.log( '성공' );
			
			location.reload();
			
		} else {
			alert( '서버 오류' );
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}
// 재개 관련

// 환불 관련

let cancel_request_amount;

function refundConfirm( data ) {
	
	$('#refundConfirmMessage').text( data.id +" 님의 회원권을 정말로 환불 하시겠습니까?" );
	
	$('#refundModal').modal("show");
	
	merchant_uid = data.value;
	 
}; // refundConfirm 클릭


$("#refundOk").on( 'click', function(){

	console.log( "refundOk" + merchant_uid );
	refundOk( merchant_uid );
	
 });

function refundOk( data ) { 
	console.log( data );
	$.ajax({
	url: './user/user_source/refund_ok.jsp',
	type: 'post',
	data: {
		merchant_uid : data
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			
			console.log( '성공' );
			
			location.reload();
			
		} else {
			alert( '오류' );
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}