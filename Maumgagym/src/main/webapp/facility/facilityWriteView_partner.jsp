<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String type = (String) session.getAttribute("type");
	
	//System.out.println( "세션으로 받아오는 타입 : " + type );
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="./resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	<link href="./resources/asset/css/facility_list.css" rel="stylesheet" />
    <!-- Bootstrap icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- script -->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
	<script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="./resources/asset/js/owl.carousel.min.js"></script>
    
    <!-- Summernote -->
	<script src="./facility/facility_source/summernote/summernote-lite.js"></script>
	<script src="./facility/facility_source/summernote/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="./facility/facility_source/summernote/summernote-lite.css">  
	
	<script type="text/javascript">
		// 썸머노트에서 이미지 업로드시 실행할 함수
		function sendFile( file, editor) {
			// 파일 전송을 위한 폼 생성
			data = new formData();
			data.append( "uploadFile", file);
			$.ajax({  // ajax를 통해 파일 업로드 처리
				data: data,
				type: "post",
				url: "./facility_imageUpload.jsp"
				success: function(data) {  
					$.(editor).summernote( 'editor.insertImage', data.url );
				}
			});
			
		}
	</script>
</head>
<body>
	
	<!-- header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="type" value="<%=type%>" />
	</jsp:include>
	<jsp:include page="../main/main_source/main_search.jsp" />
	
	<!-- 운동시설 글쓰기 -->
	<jsp:include page="./facility_source/facility_write.jsp" />
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
    
    <script>
	    $('#summernote').summernote({
	        height: 400,
	        lang: "ko-KR",
	        callbacks: {
	            onImageUpload : function(files, editor, welEditable){
					
	            	sendFile(files[0], this);
	                  // 파일 업로드(다중업로드를 위해 반복문 사용)
	                  /* for (var i = files.length - 1; i >= 0; i--) {
		                      uploadSummernoteImageFile(files[i], this);
	                  } */
	              }
	    	}
	    });
    
	    $( 'select[name=category]' ).change(function() {
		    console.log( $('#category option:selected').val());
		    console.log( $('#category option:selected').text());
		  $( '#c_seq').val($('#category option:selected').val());
		    
	    });

    </script>
    
</body>
</html>