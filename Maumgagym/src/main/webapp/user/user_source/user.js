
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