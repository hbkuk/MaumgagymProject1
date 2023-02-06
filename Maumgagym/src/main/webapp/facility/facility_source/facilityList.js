/**
 * 
 */
 
 $(document).ready(function() {

	$( "li" ).click(function() {
	
		//카테고리 클릭하면 해당 카테고리 번호(id) get
		let categorySeq = $(this).children("a").attr("id");
		
		//현재 url
		const urlStr = window.location.href;  // window.location.href : url 주소 설정
		const url =  new URL(urlStr);
		
		//파라미터 객체 생성  => 변경된 페이지 주소 반영
		const urlParams = url.searchParams;
		
		//객체 로그 확인
		console.log(urlParams) ;
		
		// dongAddr 파라미터 확인
		console.log( urlParams.has( "dongAddr") ); 
		
		//위치(dongAddr)X / 카테고리(category_seq) X   ==>   카테고리 번호 파라미터 추가
		if( !( urlParams.has( "dongAddr" ) ) && !( urlParams.has( "category_seq" ) ) ) {
			
			//파라미터 객체 생성
			const urlParams = url.searchParams;
			
			urlParams.append( "category_seq", categorySeq );
			location.href = url;
		
		// dongAddr X / category_seq O			  ==>		카테고리 번호 파라미터 변경
		} else if( !(urlParams.has( "dongAddr" )) && (urlParams.has( "category_seq" ) ) ) {
		
			//search 프로퍼티를 빈 문자열( '' )로 설정  
			url.search = '';
			
			//파라미터 객체 생성
			const urlParams = url.searchParams;
			
			urlParams.append( "category_seq", categorySeq );
			location.href = url;		
			
		// dongAddr O / category_seq X	  	  ==> 		  카테고리 번호 파라미터 추가
		} else if( urlParams.has( "dongAddr" ) && !( urlParams.has( "category_seq" ) ) ){ 
			
			//search 프로퍼티를 빈 문자열( '' )로 설정
			url.search = '';			
			
			const urlParams = url.searchParams;
			
			urlParams.delete( "dongAddr" );
			urlParams.set( "category_seq", categorySeq );
			
			location.href = urlStr + "&" + urlParams.toString(); 
		
		// dongAddr O / category_seq O	  	  ==> 		  카테고리 번호 파라미터 변경
		} else if( urlParams.has( "dongAddr" ) && ( urlParams.has( "category_seq" ) ) ) {
			
			
			const urlParams = url.searchParams;
			
			urlParams.delete( "category_seq" );
			urlParams.set( "category_seq", categorySeq );
			location.href = url;; 
		}
		
	});
});	