$(document).ready(function() {
	
	$("li").click(function() {
		
    	let categorySeq = $(this).children("a").attr("id");
    	//console.log( categorySeq );
    	
    	const url = window.location.href;
    	
    	const urlParams = new URLSearchParams();
    	//console.log( urlParams );
    	urlParams.set('category_seq', categorySeq );
    	
    	
    	// 현재 url 가져오기
    	//let url = $(location).attr('href');
    	//console.log( url );
    	
    	// 현재 url에 파라미터 붙이기
    	//url += "&category_seq=" + categorySeq
    	
    	// 파라미터 설정 후 이동시키기
    	 //location.href = url;
    	
    	if( urlParams.has( "dongAddr" ) ) {
    	
    		location.href = url + "&" + urlParams.toString();
    	
    	} else {
			urlParams.delete("category_seq")
			location.href = url + "?" + urlParams.toString();
			
		}
    	
    });
    
});