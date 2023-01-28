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

	let myLatitude;
	let mylongitude;
	
	function myPosition() {
		if (navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(function(position) {
		    	myLatitude = position.coords.latitude,
		    	mylongitude = position.coords.longitude;
		    	
				console.log( myLatitude );
				console.log( mylongitude );
		      });
		};
	};
	
	function getFacilityList() {
		$.ajax({
		    url:'https://dapi.kakao.com/v2/local/search/keyword.json?x=' + myLatitude + '&y=' + mylongitude + '&radius=2000&query=' + encodeURIComponent('헬스장'),
		    type:'GET',
		    headers: {'Authorization' : 'KakaoAK 57707c5358471602c86ac2dd1ec80f90'},
			success:function(data){
				//console.log(data);
		        //console.log( myLatitude );
		        //console.log( mylongitude );
			},
			error : function(e){
				console.log(e);
			}
	});
	};
	
	

	async function run() {
		
		console.log( '시작' );
		await myPosition();
		console.log( myLatitude );
		console.log( mylongitude );
		await getFacilityList();
		console.log( '끝' );
		
	}
	
	run();

</script>
</body>
</html>
