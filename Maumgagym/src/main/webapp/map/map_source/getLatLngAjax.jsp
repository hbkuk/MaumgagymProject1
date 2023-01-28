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

		$.ajax({
		    url:'https://dapi.kakao.com/v2/local/search/address.json?query='+encodeURIComponent('태장동'),
		    type:'GET',
		    headers: {'Authorization' : 'KakaoAK 57707c5358471602c86ac2dd1ec80f90'},
			    
			success:function(data){
				
			console.log(data);
			
			},
			error : function(e){
			console.log(e);
			}
			});

</script>
</body>
</html>