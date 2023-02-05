$(document).ready(function() {
	
	$("li").click(function() {
		
    	let categorySeq = $(this).children("a").attr("id");
    	//console.log( categorySeq );
    	
    	const url = window.location.href;
    	
    	const urlParams = new URLSearchParams();
    	//console.log( urlParams );
    	//urlParams.set('category_seq', categorySeq );
    	
    	
    	if( urlParams.has( "category_seq" ) ) {
    		
    		urlParams.delete('category_seq');
    		urlParams.append('category_seq', categorySeq );
    		
    		location.href = url + urlParams.toString();
    	
    	} else {
			urlParams.set('category_seq', categorySeq );
			location.href = url + "?" + urlParams.toString();
			
		}
    	
    });
    
});