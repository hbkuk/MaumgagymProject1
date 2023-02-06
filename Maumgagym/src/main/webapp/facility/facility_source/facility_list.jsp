<%@page import="com.to.board.FacilityDAO"%>
<%@page import="com.to.board.MemberShipTO"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="java.util.Map"%>
<%@page import="com.to.board.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//System.out.println( request.getParameter( "dongAddr" ) );

	// facility_map.jsp에서 동 주소 받아오기
	/*
	String data = request.getParameter( "dongAddr" );
	if( request.getParameter( "dongAddr" ) == null ){
		data = "";
	}
	*/
	String[] dongAddr = null;
	String fullDongAddr = null;
	int categorySeq = 0;
	
	// facility_map.jsp에서 받아온 동 주소가 null이 아니면 
	if( request.getParameter( "dongAddr" ) != null ) {	
		dongAddr = request.getParameter( "dongAddr" ).split( " " );  // 동 주소를 공백 기준으로 분리 
		fullDongAddr = String.format( "%s %s %s", dongAddr[0], dongAddr[1], dongAddr[2] );	// fullDongAddr에 포맷화하여 대입
		//System.out.println( dongAddr[0] );
		//System.out.println( dongAddr[1] );
		//System.out.println( dongAddr[2] );
	} else {	// facility_map.jsp에서 받아온 동 주소가 null이면
		fullDongAddr = "위치를 지정해 주세요.";		
	}
	
	
	// facilityList.js에서 받아온 카테고리 번호가 null이 아니면
	if( request.getParameter( "category_seq" ) != null ) {
		categorySeq = Integer.parseInt( request.getParameter( "category_seq" ) );   // int형 변수 categorySeq에 대입
	}
	//System.out.println( categorySeq);
	
 	FacilityDAO dao = new FacilityDAO();
	ArrayList facilityLists = dao.facility();
	
	BoardTO bto = new BoardTO();
	MemberTO mto = new MemberTO();
	MemberShipTO msto = new MemberShipTO();
	
	StringBuilder sb = new StringBuilder();
	
	for( int i=0; i<facilityLists.size(); i++ ){
		Map<String, Object> map0 = (Map<String, Object>) facilityLists.get(i);
		
		bto = (BoardTO) map0.get("bto"+(i+1));
		//System.out.println(bto.getTitle());
		
		mto = (MemberTO) map0.get("mto"+(i+1));
		//System.out.println(mto.getAddress());
		
		msto = (MemberShipTO) map0.get("msto"+(i+1));
		//System.out.println(msto.getMembership_price());
		
		String tag = bto.getTag();
		String title = bto.getTitle();
		String address = mto.getAddress();
		String[] facilityAddress = mto.getAddress().split( " " );
		int price =  msto.getMembership_price(); 
		//System.out.println( tag);
		
		
		// 위치 X, 카테고리 X     ==>   전체 리스트 출력
		if( ( dongAddr == null ) && ( categorySeq == 0 ) ){
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
			//System.out.println( sb.toString() );
			
		// 위치 X, 카테고리 O	
		} else if( (dongAddr == null ) && (categorySeq != 0 ) ){
				if( categorySeq == bto.getCategory_seq() ) {
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
				
			// 위치 O, 카테고리 X	
			} else if( (dongAddr != null ) && (categorySeq == 0 ) ){
				if( dongAddr[2].equals( facilityAddress[2] ) ) {
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
			
			// 위치 O, 카테고리 O
			} else if( (dongAddr != null ) && (categorySeq != 0 ) ){
				if( dongAddr[2].equals( facilityAddress[2] ) && categorySeq == bto.getCategory_seq() ) {
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
<!-- 내 주변 운동시설-->
<div class="container md-5" style="padding-left: 60px">
	<div class="current-menu container-xl">
		<a href="./homePage.jsp">홈</a> &gt; 내 주변 운동시설
	</div>
	<div class="current-location container-xl">
		<div class="desktop-location-view ng-star-inserted">
			<i class="bi bi-geo-alt" id="getAddr"><%=fullDongAddr %></i>
			<div class="btn-view float-end">
				<a href="./facilityMapPage.jsp" class="clickable"> 위치지정</a>
			</div>
		</div>
	</div>
</div>

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

		<!-- 업체 목록 -->
		<!--  <div class="d-flex flex-column flex-wrap my-4 p-4"
		style="position: relative; max-width: 1500px; margin:0 auto;">
		-->
		<div class="container">
			<div class="row row-cols-3">
				  <%=sb.toString() %> 
			</div>
		</div>
	</div>
</div>
