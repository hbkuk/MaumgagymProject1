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

	let myLatitude = 0;
	let mylongitude = 0;
	let roopNum = 0;
	
	function myPosition() {
		if (navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(function(position) {
		    	myLatitude = position.coords.latitude,
		    	mylongitude = position.coords.longitude;
		    	getFacilityList( myLatitude, mylongitude ); 
				
		      });
			};
		};
		
	function getFacilityList( myLatitude, mylongitude ) {
		$.ajax({
		    url:'https://dapi.kakao.com/v2/local/search/keyword.json?x=' + mylongitude + '&y=' + myLatitude + '&radius=1000&query=' + encodeURIComponent('필라테스'),
		    type:'GET',
		    headers: {'Authorization' : 'KakaoAK 57707c5358471602c86ac2dd1ec80f90'},
			success:function(data){
				console.log(data);
				
				// 결과는 https://developers.kakao.com/docs/latest/ko/local/dev-guide#search-by-keyword 을 통해 정의된 항목 
			},
			error : function(e){
				console.log(e);
			}
		});
	};
	
	myPosition();
	
</script>
</body>
</html>
