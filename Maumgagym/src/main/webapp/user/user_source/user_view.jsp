<%@page import="com.to.review.ReviewTO"%>
<%@page import="java.awt.font.ImageGraphicAttribute"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.to.board.BoardTO"%>
<%@page import="com.to.board.MemberShipTO"%>
<%@page import="org.apache.catalina.tribes.membership.Membership"%>
<%@page import="com.to.pay.PayTO"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding( "utf-8" );

	String id = null;
	String type = null;
	// get id	
	if( request.getParameter( "id" ) != null && !"null".equals( request.getParameter( "id" ) ) ) {
		id = request.getParameter( "id" );
	}
	
	if( request.getParameter( "type" ) != null && !"null".equals( request.getParameter( "type" ) ) ) {
		type = request.getParameter( "type" );
	} 
	
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	MemberTO mto = null;
	
	Map<String, Object> purchaseList = null;
	
	ArrayList< Map<String, Object> > purchaseArrayList = null; 
	
	// status 무관
	StringBuilder sbPurchaseList = null;
	// status 0 또는 1
	StringBuilder sbBeforeRegister = null;
	// status 2
	StringBuilder sbAfterRegister = null;
	// status 3
	StringBuilder sbPauseMembership = null;
	// status 4
	StringBuilder sbExpireMembership = null;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
 		String sql = "select m.seq, m.nickname, m.id, m.name, m.birthday, m.phone, m.email, m.zipcode, m.fulladdress from member m where id = ?";
 		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id );
		
		rs = pstmt.executeQuery();
		
		mto = new MemberTO();
		
		if( rs.next() ) {
			
			mto.setSeq( rs.getInt("m.seq"));
			mto.setNickname( rs.getString("m.nickname") );
			mto.setId( rs.getString("m.id") );
			mto.setName( rs.getString("m.name") );
			mto.setBirthday( rs.getString("m.birthday") );
			mto.setPhone( rs.getString("m.phone") );
			mto.setEmail( rs.getString("m.email") );
			mto.setZipcode( rs.getString("m.zipcode") );
			mto.setFullAddress( rs.getString("m.fulladdress") );
			
		}
		
		
		StringBuilder sbPayMembership = new StringBuilder();
		
		sbPayMembership.append( "select p.pay_date AS '결제 날짜', p.type AS '결제 방식', IF( p.status = 1, '정상', '환불' ) AS '결제 상태', p.merchant_uid AS '결제 번호'," );
		sbPayMembership.append( "	ms.name AS '회원권 이름', ms.price AS '회원권 가격', ms.period AS '회원권 기간',");
		sbPayMembership.append( "		b.seq AS '게시글 번호' , b.title AS '게시글 타이틀',");
		sbPayMembership.append( "			i.name AS '대표 이미지', ");
		sbPayMembership.append( "				wm.fulladdress AS '업체 주소',  wm.phone AS '업체 번호', ");
		sbPayMembership.append( "					IFNULL( msr.status, 0 ) AS '회원권 상태', ");
		sbPayMembership.append( "						IFNULL(rv.status, 0 ) AS '리뷰 상태' ");
		sbPayMembership.append( "							from pay p LEFT OUTER JOIN member m");
		sbPayMembership.append( "								ON( p.member_seq = m.seq ) LEFT OUTER JOIN membership ms");
		sbPayMembership.append( "									ON( p.membership_seq = ms.seq ) LEFT OUTER JOIN board b");
		sbPayMembership.append( "										ON( ms.board_seq = b.seq ) LEFT OUTER JOIN image i");
		sbPayMembership.append( "											ON( b.seq = i.board_seq) LEFT OUTER JOIN member wm");
		sbPayMembership.append( "												ON( b.write_seq = wm.seq ) LEFT OUTER JOIN membership_register msr ");
		sbPayMembership.append( "													ON ( p.merchant_uid = msr.merchant_uid )  LEFT OUTER JOIN review rv ");
		sbPayMembership.append( "														ON ( m.seq = rv.writer_seq ) ");
		sbPayMembership.append( "															WHERE m.id = ?");
		sbPayMembership.append( "																group BY p.merchant_uid");
		sbPayMembership.append( "																	ORDER BY p.pay_date desc");
 				
		
		sql = sbPayMembership.toString();
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id );
		
		rs = pstmt.executeQuery();
		
		purchaseArrayList = new ArrayList();
		
		while( rs.next() ) {
			
			purchaseList = new HashMap();
			
			PayTO pto = new PayTO();
			pto.setPay_date( rs.getString("결제 날짜") );
			pto.setType( rs.getString("결제 방식") );
			pto.setPay_status( rs.getString("결제 상태") );
			pto.setMerchant_uid( rs.getString("결제 번호") );
			pto.setMembership_register_status( rs.getString("회원권 상태") );
			purchaseList.put( "pto", pto );
			
			MemberShipTO msto = new MemberShipTO();
			msto.setMembership_name( rs.getString("회원권 이름") );
			msto.setMembership_price( rs.getInt("회원권 가격") );
			msto.setMembership_period( rs.getInt("회원권 기간") );
			purchaseList.put( "msto", msto );
			
			BoardTO bto = new BoardTO();
			bto.setSeq( rs.getInt("게시글 번호"));
			bto.setTitle( rs.getString("게시글 타이틀") );
			bto.setImage_name(  rs.getString("대표 이미지") );
			purchaseList.put( "bto", bto );
			
			MemberTO wmto = new MemberTO();
			wmto.setFullAddress( rs.getString("업체 주소") );
			wmto.setPhone( rs.getString("업체 번호") );
			purchaseList.put( "wmto", wmto );
			
			ReviewTO rvto = new ReviewTO();
			rvto.setStatus( rs.getString("리뷰 상태") );
			purchaseList.put( "rvto", rvto );
			
			purchaseArrayList.add( purchaseList );
			
		}
		
			// status 무관
			sbPurchaseList = new StringBuilder();
			// status 0 또는 1
			sbBeforeRegister = new StringBuilder();
			// status 2
			sbAfterRegister = new StringBuilder();
			// status 3
			sbPauseMembership = new StringBuilder();
			// status 4
			sbExpireMembership = new StringBuilder();
			
			for( int i = 0; i < purchaseArrayList.size(); i++ ) {
				
				purchaseList = purchaseArrayList.get( i );
				
				PayTO pto = (PayTO) purchaseList.get("pto");
				String payDate = pto.getPay_date();		//
				String payType = pto.getType();			//
				String payStatus = pto.getPay_status(); //
				String merchantUid = pto.getMerchant_uid();
				String membership_register_status = pto.getMembership_register_status();
				
				MemberShipTO msto = (MemberShipTO) purchaseList.get("msto");
				String membershipName = msto.getMembership_name();	//		
				int membershipPrice = msto.getMembership_price();
				int membershipPeriod = msto.getMembership_period();	//
				
				BoardTO bto = (BoardTO) purchaseList.get("bto");
				String title = bto.getTitle();			//
				String imageName = bto.getImage_name();	//
				
				MemberTO wmto = (MemberTO) purchaseList.get("wmto");
				String facilityFullAddress = wmto.getFullAddress();
				String phone = wmto.getPhone();
				
				ReviewTO rvto = (ReviewTO) purchaseList.get("rvto");
				String reviewStatus = rvto.getStatus();

				
				sbPurchaseList.append( "	<div class='mt-3 mb-4'>");
				sbPurchaseList.append( "		<div class='col-xl-12'>");
				sbPurchaseList.append( "			<div class='card mb-4'>");
				sbPurchaseList.append( "				<div class='card-header fs-5 fw-bolder'>" + String.format( "%s (%s)", title, phone ) +"</div>");
				sbPurchaseList.append( "				<div class='card-body'>");
				sbPurchaseList.append( "					<div class='row g-0'>");
				sbPurchaseList.append( "						<div class='col-md-4'>");
				sbPurchaseList.append( "							<img src='./upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
				sbPurchaseList.append( "						</div>");
				sbPurchaseList.append( "						<div class='col-md-8' style='padding-left: 50px'>");
				sbPurchaseList.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
				sbPurchaseList.append( "							<br>");
				sbPurchaseList.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
				sbPurchaseList.append( "							<p class='card-text fs-7'>");
				if( membership_register_status.equals( "0" )) {
				sbPurchaseList.append( "							아직 등록전입니다. <br>사용하시려면 아래 등록하기 버튼을 눌러주시거나 등록된 번호로 문의하세요.</br>");
				}
				sbPurchaseList.append( "							</p>");
				sbPurchaseList.append( "						</div>");
				sbPurchaseList.append( "					</div>");
				sbPurchaseList.append( "					<table class='table mt-3'>");
				sbPurchaseList.append( "						<tbody>");
				sbPurchaseList.append( "							<tr>");
				sbPurchaseList.append( "								<th scope='row'>결제일</th>");
				sbPurchaseList.append( "								<td>" + payDate + "</td>");
				sbPurchaseList.append( "								<th>결제금액</th>");
				sbPurchaseList.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
				sbPurchaseList.append( "							</tr>");
				sbPurchaseList.append( "							<tr>");
				sbPurchaseList.append( "								<th scope='row'>결제수단</th>");
				sbPurchaseList.append( "								<td>" + payType + "</td>");
				sbPurchaseList.append( "								<th>결제상태</th>");
				sbPurchaseList.append( "								<td>" + payStatus + "</td>");
				sbPurchaseList.append( "							</tr>");
				sbPurchaseList.append( "						</tbody>");
				sbPurchaseList.append( "					</table>");
				sbPurchaseList.append( "					<div class='d-grid gap-2'> ");
				if( membership_register_status.equals( "0" )) {
					sbPurchaseList.append( "						<button id='membershipRegister' class='btn btn-primary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "'> 등록하기 </button>");
				} else if (membership_register_status.equals( "1" ) ) {
					sbPurchaseList.append( "						<button id='membershipRegister' class='btn btn-secondary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "' disabled='disabled'> 승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요. </button>");		
				}
				sbPurchaseList.append( "					</div>");
				sbPurchaseList.append( "				</div>");
				sbPurchaseList.append( "			</div>");
				sbPurchaseList.append( "		</div>");
				sbPurchaseList.append( "	</div>");

		
		}
		
			for( int i = 0; i < purchaseArrayList.size(); i++ ) {
				
				purchaseList = purchaseArrayList.get( i );
				
				PayTO pto = (PayTO) purchaseList.get("pto");
				String payDate = pto.getPay_date();		//
				String payType = pto.getType();			//
				String payStatus = pto.getPay_status(); //
				String merchantUid = pto.getMerchant_uid();
				String membership_register_status = pto.getMembership_register_status();
				
				MemberShipTO msto = (MemberShipTO) purchaseList.get("msto");
				String membershipName = msto.getMembership_name();	//		
				int membershipPrice = msto.getMembership_price();
				int membershipPeriod = msto.getMembership_period();	//
				
				BoardTO bto = (BoardTO) purchaseList.get("bto");
				String title = bto.getTitle();			//
				String imageName = bto.getImage_name();	//
				
				MemberTO wmto = (MemberTO) purchaseList.get("wmto");
				String facilityFullAddress = wmto.getFullAddress();
				String phone = wmto.getPhone();
				
				ReviewTO rvto = (ReviewTO) purchaseList.get("rvto");
				String reviewStatus = rvto.getStatus();
				
				if( membership_register_status.equals( "0" ) || membership_register_status.equals( "1" ) ) {

				
				sbBeforeRegister.append( "	<div class='mt-3 mb-4'>");
				sbBeforeRegister.append( "		<div class='col-xl-12'>");
				sbBeforeRegister.append( "			<div class='card mb-4'>");
				sbBeforeRegister.append( "				<div class='card-header fs-5 fw-bolder'>" + String.format( "%s (%s)", title, phone ) +"</div>");
				sbBeforeRegister.append( "				<div class='card-body'>");
				sbBeforeRegister.append( "					<div class='row g-0'>");
				sbBeforeRegister.append( "						<div class='col-md-4'>");
				sbBeforeRegister.append( "							<img src='./upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
				sbBeforeRegister.append( "						</div>");
				sbBeforeRegister.append( "						<div class='col-md-8' style='padding-left: 50px'>");
				sbBeforeRegister.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
				sbBeforeRegister.append( "							<br>");
				sbBeforeRegister.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
				sbBeforeRegister.append( "						</div>");
				sbBeforeRegister.append( "					</div>");
				sbBeforeRegister.append( "					<table class='table mt-3'>");
				sbBeforeRegister.append( "						<tbody>");
				sbBeforeRegister.append( "							<tr>");
				sbBeforeRegister.append( "								<th scope='row'>결제일</th>");
				sbBeforeRegister.append( "								<td>" + payDate + "</td>");
				sbBeforeRegister.append( "								<th>결제금액</th>");
				sbBeforeRegister.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
				sbBeforeRegister.append( "							</tr>");
				sbBeforeRegister.append( "							<tr>");
				sbBeforeRegister.append( "								<th scope='row'>결제수단</th>");
				sbBeforeRegister.append( "								<td>" + payType + "</td>");
				sbBeforeRegister.append( "								<th>결제상태</th>");
				sbBeforeRegister.append( "								<td>" + payStatus + "</td>");
				sbBeforeRegister.append( "							</tr>");
				sbBeforeRegister.append( "						</tbody>");
				sbBeforeRegister.append( "					</table>");
				sbBeforeRegister.append( "					<div class='d-grid gap-2'> ");
				if( membership_register_status.equals( "0" )) {
					sbBeforeRegister.append( "						<button id='membershipRegister' class='btn btn-primary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "'> 등록하기 </button>");
				} else if (membership_register_status.equals( "1" ) ) {
					sbBeforeRegister.append( "						<button id='membershipRegister' class='btn btn-secondary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "' disabled='disabled'> 승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요. </button>");		
				}
				sbBeforeRegister.append( "					</div>");
				sbBeforeRegister.append( "				</div>");
				sbBeforeRegister.append( "			</div>");
				sbBeforeRegister.append( "		</div>");
				sbBeforeRegister.append( "	</div>");
				
				}
		
		}
			
		for( int i = 0; i < purchaseArrayList.size(); i++ ) {
				
				purchaseList = purchaseArrayList.get( i );
				
				PayTO pto = (PayTO) purchaseList.get("pto");
				String payDate = pto.getPay_date();		//
				String payType = pto.getType();			//
				String payStatus = pto.getPay_status(); //
				String merchantUid = pto.getMerchant_uid();
				String membership_register_status = pto.getMembership_register_status();
				
				MemberShipTO msto = (MemberShipTO) purchaseList.get("msto");
				String membershipName = msto.getMembership_name();	//		
				int membershipPrice = msto.getMembership_price();
				int membershipPeriod = msto.getMembership_period();	//
				
				BoardTO bto = (BoardTO) purchaseList.get("bto");
				String title = bto.getTitle();			//
				String imageName = bto.getImage_name();	//
				
				MemberTO wmto = (MemberTO) purchaseList.get("wmto");
				String facilityFullAddress = wmto.getFullAddress();
				String phone = wmto.getPhone();
				
				ReviewTO rvto = (ReviewTO) purchaseList.get("rvto");
				String reviewStatus = rvto.getStatus();

				if( membership_register_status.equals( "2" ) ) {
				
				sbAfterRegister.append( "	<div class='mt-3 mb-4'>");
				sbAfterRegister.append( "		<div class='col-xl-12'>");
				sbAfterRegister.append( "			<div class='card mb-4'>");
				sbAfterRegister.append( "				<div class='card-header fs-5 fw-bolder'>" + String.format( "%s (%s)", title, phone ) +"</div>");
				sbAfterRegister.append( "				<div class='card-body'>");
				sbAfterRegister.append( "					<div class='row g-0'>");
				sbAfterRegister.append( "						<div class='col-md-4'>");
				sbAfterRegister.append( "							<img src='./upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
				sbAfterRegister.append( "						</div>");
				sbAfterRegister.append( "						<div class='col-md-8' style='padding-left: 50px'>");
				sbAfterRegister.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
				sbAfterRegister.append( "							<br>");
				sbAfterRegister.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
				sbAfterRegister.append( "						</div>");
				sbAfterRegister.append( "					</div>");
				sbAfterRegister.append( "					<table class='table mt-3'>");
				sbAfterRegister.append( "						<tbody>");
				sbAfterRegister.append( "							<tr>");
				sbAfterRegister.append( "								<th scope='row'>결제일</th>");
				sbAfterRegister.append( "								<td>" + payDate + "</td>");
				sbAfterRegister.append( "								<th>결제금액</th>");
				sbAfterRegister.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
				sbAfterRegister.append( "							</tr>");
				sbAfterRegister.append( "							<tr>");
				sbAfterRegister.append( "								<th scope='row'>결제수단</th>");
				sbAfterRegister.append( "								<td>" + payType + "</td>");
				sbAfterRegister.append( "								<th>결제상태</th>");
				sbAfterRegister.append( "								<td>" + payStatus + "</td>");
				sbAfterRegister.append( "							</tr>");
				sbAfterRegister.append( "						</tbody>");
				sbAfterRegister.append( "					</table>");
				sbAfterRegister.append( "					<div class='d-grid gap-2'> ");
/* 				if( membership_register_status.equals( "0" )) {
					sbAfterRegister.append( "						<button id='membershipRegister' class='btn btn-primary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "'> 등록하기 </button>");
				} else {
					sbAfterRegister.append( "						<button id='membershipRegister' class='btn btn-secondary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "' disabled='disabled'> 승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요. </button>");		
				} */
				sbAfterRegister.append( "					</div>");
				sbAfterRegister.append( "				</div>");
				sbAfterRegister.append( "			</div>");
				sbAfterRegister.append( "		</div>");
				sbAfterRegister.append( "	</div>");
				
				}
		
		}
		
		for( int i = 0; i < purchaseArrayList.size(); i++ ) {
			
			purchaseList = purchaseArrayList.get( i );
			
			PayTO pto = (PayTO) purchaseList.get("pto");
			String payDate = pto.getPay_date();		//
			String payType = pto.getType();			//
			String payStatus = pto.getPay_status(); //
			String merchantUid = pto.getMerchant_uid();
			String membership_register_status = pto.getMembership_register_status();
			
			MemberShipTO msto = (MemberShipTO) purchaseList.get("msto");
			String membershipName = msto.getMembership_name();	//		
			int membershipPrice = msto.getMembership_price();
			int membershipPeriod = msto.getMembership_period();	//
			
			BoardTO bto = (BoardTO) purchaseList.get("bto");
			String title = bto.getTitle();			//
			String imageName = bto.getImage_name();	//
			
			MemberTO wmto = (MemberTO) purchaseList.get("wmto");
			String facilityFullAddress = wmto.getFullAddress();
			String phone = wmto.getPhone();
			
			ReviewTO rvto = (ReviewTO) purchaseList.get("rvto");
			String reviewStatus = rvto.getStatus();

			if( membership_register_status.equals( "3" ) ) {
			
			sbPauseMembership.append( "	<div class='mt-3 mb-4'>");
			sbPauseMembership.append( "		<div class='col-xl-12'>");
			sbPauseMembership.append( "			<div class='card mb-4'>");
			sbPauseMembership.append( "				<div class='card-header fs-5 fw-bolder'>" + String.format( "%s (%s)", title, phone ) +"</div>");
			sbPauseMembership.append( "				<div class='card-body'>");
			sbPauseMembership.append( "					<div class='row g-0'>");
			sbPauseMembership.append( "						<div class='col-md-4'>");
			sbPauseMembership.append( "							<img src='./upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
			sbPauseMembership.append( "						</div>");
			sbPauseMembership.append( "						<div class='col-md-8' style='padding-left: 50px'>");
			sbPauseMembership.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
			sbPauseMembership.append( "							<br>");
			sbPauseMembership.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
			sbPauseMembership.append( "						</div>");
			sbPauseMembership.append( "					</div>");
			sbPauseMembership.append( "					<table class='table mt-3'>");
			sbPauseMembership.append( "						<tbody>");
			sbPauseMembership.append( "							<tr>");
			sbPauseMembership.append( "								<th scope='row'>결제일</th>");
			sbPauseMembership.append( "								<td>" + payDate + "</td>");
			sbPauseMembership.append( "								<th>결제금액</th>");
			sbPauseMembership.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
			sbPauseMembership.append( "							</tr>");
			sbPauseMembership.append( "							<tr>");
			sbPauseMembership.append( "								<th scope='row'>결제수단</th>");
			sbPauseMembership.append( "								<td>" + payType + "</td>");
			sbPauseMembership.append( "								<th>결제상태</th>");
			sbPauseMembership.append( "								<td>" + payStatus + "</td>");
			sbPauseMembership.append( "							</tr>");
			sbPauseMembership.append( "						</tbody>");
			sbPauseMembership.append( "					</table>");
			sbPauseMembership.append( "					<div class='d-grid gap-2'> ");
/* 				if( membership_register_status.equals( "0" )) {
				sbPauseMembership.append( "						<button id='membershipRegister' class='btn btn-primary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "'> 등록하기 </button>");
			} else {
				sbPauseMembership.append( "						<button id='membershipRegister' class='btn btn-secondary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "' disabled='disabled'> 승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요. </button>");		
			} */
			sbPauseMembership.append( "					</div>");
			sbPauseMembership.append( "				</div>");
			sbPauseMembership.append( "			</div>");
			sbPauseMembership.append( "		</div>");
			sbPauseMembership.append( "	</div>");
			
			}
	
		}
		
		for( int i = 0; i < purchaseArrayList.size(); i++ ) {
			
			purchaseList = purchaseArrayList.get( i );
			
			PayTO pto = (PayTO) purchaseList.get("pto");
			String payDate = pto.getPay_date();		//
			String payType = pto.getType();			//
			String payStatus = pto.getPay_status(); //
			String merchantUid = pto.getMerchant_uid();
			String membership_register_status = pto.getMembership_register_status();
			
			//System.out.println( membership_register_status );
			
			//System.out.println(  membership_register_status.equals( "4" ) );
			
			MemberShipTO msto = (MemberShipTO) purchaseList.get("msto");
			String membershipName = msto.getMembership_name();	//		
			int membershipPrice = msto.getMembership_price();
			int membershipPeriod = msto.getMembership_period();	//
			
			BoardTO bto = (BoardTO) purchaseList.get("bto");
			int boardSeq = bto.getSeq();
			String title = bto.getTitle();			//
			String imageName = bto.getImage_name();	//
			
			MemberTO wmto = (MemberTO) purchaseList.get("wmto");
			String facilityFullAddress = wmto.getFullAddress();
			String phone = wmto.getPhone();
			
			ReviewTO rvto = (ReviewTO) purchaseList.get("rvto");
			String reviewStatus = rvto.getStatus();

			if( membership_register_status.equals( "4" ) ) {
			
			sbExpireMembership.append( "	<div class='mt-3 mb-4'>");
			sbExpireMembership.append( "		<div class='col-xl-12'>");
			sbExpireMembership.append( "			<div class='card mb-4'>");
			sbExpireMembership.append( "				<div class='card-header fs-5 fw-bolder'>" + String.format( "%s (%s)", title, phone ) +"</div>");
			sbExpireMembership.append( "				<div class='card-body'>");
			sbExpireMembership.append( "					<div class='row g-0'>");
			sbExpireMembership.append( "						<div class='col-md-4'>");
			sbExpireMembership.append( "							<img src='./upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
			sbExpireMembership.append( "						</div>");
			sbExpireMembership.append( "						<div class='col-md-8' style='padding-left: 50px'>");
			sbExpireMembership.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
			sbExpireMembership.append( "							<br>");
			sbExpireMembership.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
			sbExpireMembership.append( "						</div>");
			sbExpireMembership.append( "					</div>");
			sbExpireMembership.append( "					<table class='table mt-3'>");
			sbExpireMembership.append( "						<tbody>");
			sbExpireMembership.append( "							<tr>");
			sbExpireMembership.append( "								<th scope='row'>결제일</th>");
			sbExpireMembership.append( "								<td>" + payDate + "</td>");
			sbExpireMembership.append( "								<th>결제금액</th>");
			sbExpireMembership.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
			sbExpireMembership.append( "							</tr>");
			sbExpireMembership.append( "							<tr>");
			sbExpireMembership.append( "								<th scope='row'>결제수단</th>");
			sbExpireMembership.append( "								<td>" + payType + "</td>");
			sbExpireMembership.append( "								<th>결제상태</th>");
			sbExpireMembership.append( "								<td>" + payStatus + "</td>");
			sbExpireMembership.append( "							</tr>");
			sbExpireMembership.append( "						</tbody>");
			sbExpireMembership.append( "					</table>");
			sbExpireMembership.append( "					<div class='d-grid gap-2'> ");
 			if( reviewStatus.equals( "0" ) ) {
				sbExpireMembership.append( "						<button id='" + merchantUid + "' class='btn btn-primary mt-1' type='button' onclick='reviewRegister(this, " + boardSeq + ", " + mto.getSeq() + ", `" + bto.getTitle() + "`, `" + imageName + "`, `" + facilityFullAddress + "` )' value='" + merchantUid + "'> 리뷰쓰기 </button>");
			} else if ( reviewStatus.equals( "1" ) ) {
				sbExpireMembership.append( "						<button id='" + merchantUid + "' class='btn btn-secondary mt-1' type='button' onclick='reviewRegister(" + boardSeq + ", " + mto.getSeq() + ")' value='" + merchantUid + "' disabled='disabled'> 이미 리뷰를 등록했습니다. </button>");		
			} 
			sbExpireMembership.append( "					</div>");
			sbExpireMembership.append( "				</div>");
			sbExpireMembership.append( "			</div>");
			sbExpireMembership.append( "		</div>");
			sbExpireMembership.append( "	</div>");
			
			}
	
		}
			
			
		
		
		} catch( NamingException e) {
			System.out.println( e.getMessage());
		} catch( SQLException e) {
			System.out.println( e.getMessage());
		} finally {
			if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if( conn != null) try {conn.close();} catch(SQLException e) {}
			if( rs != null) try {rs.close();} catch(SQLException e) {}
		}
	
	

%>

<div class="container-xl px-4 mt-4">
	<ul class="nav nav-tabs" id="myTab" role="tablist">
	
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
				data-bs-target="#home-tab-pane" type="button" role="tab"
				aria-controls="home-tab-pane" aria-selected="true">내 정보</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="purchase-list-tab" data-bs-toggle="tab"
				data-bs-target="#purchase-list-tab-pane" type="button" role="tab"
				aria-controls="purchase-list-tab-pane" aria-selected="false">전체 결제 목록</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="before-register-tab" data-bs-toggle="tab"
				data-bs-target="#before-register-tab-pane" type="button" role="tab"
				aria-controls="before-register-tab-pane" aria-selected="false">등록 대기중인 회원권</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="after-register-tab" data-bs-toggle="tab"
				data-bs-target="#after-register-tab-pane" type="button" role="tab"
				aria-controls="after-register-tab-pane" aria-selected="false">등록한 회원권</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="pause-membership-tab" data-bs-toggle="tab"
				data-bs-target="#pause-membership-tab-pane" type="button" role="tab"
				aria-controls="pause-membership-tab-pane" aria-selected="false">사용 중지한 회원권</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="expire-membership-tab" data-bs-toggle="tab"
				data-bs-target="#expire-membership-tab-pane" type="button" role="tab"
				aria-controls="expire-membership-tab-pane" aria-selected="false">만료된 회원권</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="cart-membership-tab" data-bs-toggle="tab"
				data-bs-target="#cart-membership-tab-pane" type="button" role="tab"
				aria-controls="cart-membership-tab-pane" aria-selected="false">찜한 회원권</button>
		</li>
		
	</ul>
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="home-tab-pane"
			role="tabpanel" aria-labelledby="home-tab" tabindex="0">

			<!-- 내 정보 -->
			<hr class="mt-0 mb-4">
			<div class="row" id="profile">
				<div class="col-xl-3">
					<!-- Profile picture card-->
					<div class="card mb-4 mb-xl-0">
						<div class="card-header fs-5 fw-bolder">프로필</div>
						<div class="card-body text-center">
							<!-- Profile picture icon-->
							<i class="bi bi-person-circle" style="font-size: 70px;"></i>
							<!-- Nickname and Email-->
							<div class="fs-4 fw-semibold text-muted mb-1">사용자</div>
							<div class="fs-6 font-italic text-muted mb-3"><%= mto.getName() %></div>
						</div>
					</div>
				</div>
				<div class="col-xl-9">
					<!-- Account details card-->
					<div class="card mb-4">
						<div class="card-header fs-5 fw-bolder">정보 수정</div>
						<div class="card-body">
							<form>
							
								<div class="row gx-3">
								
								<div class="mb-3">
										<label class="small mb-1" for="inputName">이름</label> <input
											class="form-control" id="inputName" type="text" value="<%= mto.getName() %>" readonly>
									</div>
								</div>
							
								<div class="mb-3">
									<label class="small mb-1" for="inputID">아이디</label> <input
										class="form-control" id="inputID" type="text" value="<%= mto.getId() %>" readonly>
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputNickName">닉네임</label> <input
										class="form-control" id="inputNickName" type="text" value="<%= mto.getNickname() %>">
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputBirthday">생년월일</label> <input
										class="form-control" id="inputBirthday" type="text" value="<%= mto.getBirthday() %>">
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputPhone">휴대전화</label> <input
										class="form-control" id="inputPhone" type="text" value="<%= mto.getPhone() %>">
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputEmailAddress">이메일</label> <input
										class="form-control" id="inputEmailAddress" type="email" value="<%= mto.getEmail() %>">
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputAddress">주소</label> <input
										class="form-control" id="inputAddress" type="text" value="<%= "[" + mto.getZipcode() +"] " + mto.getFullAddress() %>">
								</div>
							
								<!-- Form Row-->
								<div class="row gx-3 mb-3">
									<!-- Form Group (phone number)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputPassword">비밀번호 </label> <input
											class="form-control" id="inputPassword" type="password"
											placeholder="현재 비밀번호를 입력하세요." value="">
									</div>
									<!-- Form Group (birthday)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputChangePassword">비밀번호 입력</label>
										<input class="form-control" id="inputChangePassword" type="password"
										placeholder="변경할 비밀번호를 입력하세요."
											value="">
									</div>
								</div>
								<!-- Save changes button-->
								<div class="d-grid gap-2">
									<button onclick='memberModify("<%=mto.getId() %>")' class="btn btn-primary mt-3" type="button"> 변경하기 </button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="tab-pane fade" id="purchase-list-tab-pane" role="tabpanel"
			aria-labelledby="purchase-list-tab-pane-tab" tabindex="1">

			<%= sbPurchaseList.toString() %>
			
		</div>
		
		
		<div class="tab-pane fade" id="before-register-tab-pane" role="tabpanel"
			aria-labelledby="before-register-tab-pane-tab" tabindex="2">

			<%= sbBeforeRegister.toString() %>
			
		</div>
		
		<div class="tab-pane fade" id="after-register-tab-pane" role="tabpanel"
			aria-labelledby="after-register-tab-pane-tab" tabindex="3">

			<%= sbAfterRegister.toString() %>
			
		</div>
		
		<div class="tab-pane fade" id="pause-membership-tab-pane" role="tabpanel"
			aria-labelledby="pause-membership-tab-pane-tab" tabindex="4">

			<%= sbPauseMembership.toString() %>
			
		</div>
		
		<div class="tab-pane fade" id="expire-membership-tab-pane" role="tabpanel"
			aria-labelledby="expire-membership-tab-pane-tab" tabindex="5">

			<%= sbExpireMembership.toString() %>
			
		</div>
		
		<div class="tab-pane fade" id="cart-membership-tab-pane" role="tabpanel"
			aria-labelledby="cart-membership-tab-pane" tabindex="6">
		</div>
		
	</div>
</div>
