<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>마음가짐 지도 API 활용</title>
    
</head>
<body>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>


<script>


/* 전역 변수로 보내기 위한 변수 선언 */

	let myLatitude = 0;
	let mylongitude = 0;
	
	/* 현재 내위치에 대한 위도, 경도 확인 */
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	    	myLatitude = position.coords.latitude, // 위도
	        mylongitude = position.coords.longitude; // 경도
	            
	           // console.log( myLatitude );
	            //console.log( mylongitude );
	        
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 실행되는 코드를 작성합니다.
	    
			// console.log( '내 위치를 알 수 없어요.');
	}
	
	
	
	/* 카카오 주소 검색 REST API를 활용한 우편번호를 통해 위도 경도 확인 */
	
	$.ajax({
		
	    url:'https://dapi.kakao.com/v2/local/search/keyword.json?x=' + myLatitude + '&y=' + mylongitude + '&radius=2000&query=' + encodeURIComponent('헬스장'),
	    type:'GET',
	    headers: {'Authorization' : 'KakaoAK 57707c5358471602c86ac2dd1ec80f90'},
	    
		success:function(data){
			
			console.log(data);
			
			//console.log( data.documents[0].y );
			//console.log( data.documents[0].x );
				            
	            console.log( myLatitude );
	           console.log( mylongitude );
		
		},
		
			error : function(e){
			console.log(e);
		
			}
		
		});

</script>
</body>
</html>
