<%@page import="com.to.board.SearchDAO"%>
<%@page import="com.to.board.MemberShipTO"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="java.util.Map"%>
<%@page import="com.to.board.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int categorySeq = 0;
	
	String search = null;
	if( request.getParameter( "search" ) != null ) {
		search = (String)request.getParameter( "search" ); 
		//System.out.println( "검색어 : " + search );
	} 
	
	// facilityList.js에서 받아온 카테고리 번호가 null이 아니면
	if( request.getParameter( "category_seq" ) != null ) {
		categorySeq = Integer.parseInt( request.getParameter( "category_seq" ) );   // int형 변수 categorySeq에 대입
	}
	//System.out.println("category_seq : " + categorySeq);
	
 	SearchDAO dao = new SearchDAO();
	ArrayList searchLists = dao.searchresult();
	
	BoardTO bto = new BoardTO();
	MemberTO mto = new MemberTO();
	MemberShipTO msto = new MemberShipTO();
	
	StringBuilder sb = new StringBuilder();
	
	//System.out.println( (search == null  && categorySeq == 0) );
	
	for( int i=0; i<searchLists.size(); i++ ){
		Map<String, Object> map0 = (Map<String, Object>) searchLists.get(i);
		
		bto = (BoardTO) map0.get("bto"+(i+1));
		//System.out.println("title : " + bto.getTitle());
		
		mto = (MemberTO) map0.get("mto"+(i+1));
		//System.out.println("address : " + mto.getAddress());
		
		msto = (MemberShipTO) map0.get("msto"+(i+1));
		//System.out.println("price : " + msto.getMembership_price());
		
		String title = bto.getTitle();
		String address = mto.getAddress();
		int price =  msto.getMembership_price(); 
		String tag = bto.getTag();
		//System.out.println( "tag : " + tag );
		String category = bto.getCategory();
		//System.out.println( "category : " + category );
		
				
		//System.out.println( (search == null  && categorySeq == 0) );
		
		// 검색어 X 카테고리 X     ==>   전체 리스트 출력
		if( (search == null  && categorySeq == 0) ){
			//System.out.println( " 출력 " );
			
			sb.append("	<div class='col'>");
			sb.append("		<div class='card shadow-sm'>");
			sb.append("			<a href='#'>");
			sb.append("			<img src='https://s3.ap-northeast-2.amazonaws.com/stone-i-dagym-centers/images/gyms/16016b1fe47123af04/Small)Xpine.jpg'class='card-img-top' alt='...'></a>");
			sb.append("			<span class='label-top'>" + tag + "</span>");
			sb.append("			<div class='card-body'>");
			sb.append("				<div class='clearfix mb-3'>");
			sb.append("					<span class='float-start badge rounded-pill bg'>" + String.format("￦%,d", price) + "</span>" );
			sb.append("					<span class='float-end'>");
			sb.append("						<a href='#' class='small text-muted'>Reviews</a>");
			sb.append("					</span>");
			sb.append("				</div>");
			sb.append("				<h5 class='card-title'>" + title + "</h5>");
			sb.append("				<span>" + address + "</span>");
			sb.append("				<div class='text-center my-4'>");
			sb.append("					<a href='#' class='btn btn-warning'>회원권 예약</a>");
			sb.append("				</div>");
			sb.append("			</div>");
			sb.append("		</div>");
			sb.append("	</div>"); 
		
		// 검색어 X 카테고리 O	
		} else if( (search == null ) && (categorySeq != 0) ){
		//System.out.println("=========" );
			if(  categorySeq  == bto.getCategory_seq() ) {
			//System.out.println("======*************===" );
				sb.append("	<div class='col'>");
				sb.append("		<div class='card shadow-sm'>");
				sb.append("			<a href='#'>");
				sb.append("			<img src='https://s3.ap-northeast-2.amazonaws.com/stone-i-dagym-centers/images/gyms/16016b1fe47123af04/Small)Xpine.jpg'class='card-img-top' alt='...'></a>");
				sb.append("			<span class='label-top'>" + tag + "</span>");
				sb.append("			<div class='card-body'>");
				sb.append("				<div class='clearfix mb-3'>");
				sb.append("					<span class='float-start badge rounded-pill bg'>" + String.format("￦%,d", price) + "</span>" );
				sb.append("					<span class='float-end'>");
				sb.append("						<a href='#' class='small text-muted'>Reviews</a>");
				sb.append("					</span>");
				sb.append("				</div>");
				sb.append("				<h5 class='card-title'>" + title + "</h5>");
				sb.append("				<span>" + address + "</span>");
				sb.append("				<div class='text-center my-4'>");
				sb.append("					<a href='#' class='btn btn-warning'>회원권 예약</a>");
				sb.append("				</div>");
				sb.append("			</div>");
				sb.append("		</div>");
				sb.append("	</div>"); 
			}
		// 검색어 O / 카테고리 X	
		} else if( (search != null ) && (categorySeq == 0) ) {
			//System.out.println("=====검색어O====" );
			if( bto.getTitle().contains(search) || mto.getAddress().contains(search) ||bto.getCategory().contains(search)  ) {
			//System.out.println("=====검색어O********====" );
				sb.append("	<div class='col'>");
				sb.append("		<div class='card shadow-sm'>");
				sb.append("			<a href='#'>");
				sb.append("			<img src='https://s3.ap-northeast-2.amazonaws.com/stone-i-dagym-centers/images/gyms/16016b1fe47123af04/Small)Xpine.jpg'class='card-img-top' alt='...'></a>");
				sb.append("			<span class='label-top'>" + tag + "</span>");
				sb.append("			<div class='card-body'>");
				sb.append("				<div class='clearfix mb-3'>");
				sb.append("					<span class='float-start badge rounded-pill bg'>" + String.format("￦%,d", price) + "</span>" );
				sb.append("					<span class='float-end'>");
				sb.append("						<a href='#' class='small text-muted'>Reviews</a>");
				sb.append("					</span>");
				sb.append("				</div>");
				sb.append("				<h5 class='card-title'>" + title + "</h5>");
				sb.append("				<span>" + address + "</span>");
				sb.append("				<div class='text-center my-4'>");
				sb.append("					<a href='#' class='btn btn-warning'>회원권 예약</a>");
				sb.append("				</div>");
				sb.append("			</div>");
				sb.append("		</div>");
				sb.append("	</div>"); 
			}
	
		} 
	}
	
%>
<hr />

<!-- side navbar -->
<div class="container" style="padding-left: 60px">
	<div class="d-flex">
		<div class="d-flex flex-column flex-shrink-0 p-4">
			<span class="fs-3 pb-3 ">운동시설</span>
			<hr>
			<ul class="nav nav-pill flex-column mb-auto">
				<li class="nav-item ">
					<a id="1" class="nav-link active" aria-current="page">피트니스</a>
				</li>
				<li class="nav-item ">
					<a id="2" class="nav-link active" aria-current="page">요가</a>
				</li>
				<li class="nav-item">
					<a id="3" class="nav-link active " aria-current="page">수영</a>
				</li>
				<li class="nav-item">
					<a id="4" class="nav-link active " aria-current="page">테니스</a>
				</li>
				<li class="nav-item">
					<a id="5" class="nav-link active " aria-current="page">타바타</a>
				</li>
				<li class="nav-item">
					<a id="6" class="nav-link active " aria-current="page">필라테스</a>
				</li>
				<li class="nav-item">
					<a id="7" class="nav-link active " aria-current="page">골프</a>
				</li>
				<li class="nav-item">
					<a id="8" class="nav-link active " aria-current="page">복싱</a>
				</li>
				<li class="nav-item">
					<a id="9" class="nav-link active " aria-current="page">댄스</a>
				</li>
			</ul>
		</div>

		<div class="container">
			<div class="row row-cols-3">
				  <%=sb.toString() %> 
			</div>
		</div>
	</div>
</div>
