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
	// get id	
	if( request.getParameter( "id" ) != null && !"null".equals( request.getParameter( "id" ) ) ) {
		id = request.getParameter( "id" );
	} 
	
	//System.out.println( id );
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	MemberTO mto = null;
	
	Map<String, Object> purchaseList = null;
	
	ArrayList< Map<String, Object> > purchaseArrayList = null; 
	
	StringBuilder sbPurchaseList = null;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
 		String sql = "select m.nickname, m.id, m.name, m.birthday, m.phone, m.email, m.zipcode, m.fulladdress from member m where id = ?";
 		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id );
		
		rs = pstmt.executeQuery();
		
		mto = new MemberTO();
		
		if( rs.next() ) {
			
			mto.setNickname( rs.getString("m.nickname") );
			mto.setId( rs.getString("m.id") );
			mto.setName( rs.getString("m.name") );
			mto.setBirthday( rs.getString("m.birthday") );
			mto.setPhone( rs.getString("m.phone") );
			mto.setEmail( rs.getString("m.email") );
			mto.setZipcode( rs.getString("m.zipcode") );
			mto.setFullAddress( rs.getString("m.fulladdress") );
			
		}
		
 		sql = "select m.nickname, m.id, m.name, m.birthday, m.phone, m.email, m.zipcode, m.fulladdress from member m where id = ?";
 		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id );
		
		rs = pstmt.executeQuery();
		
		mto = new MemberTO();
		
		if( rs.next() ) {
			
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
		sbPayMembership.append( "		b.title AS '게시글 타이틀',");
		sbPayMembership.append( "			i.name AS '대표 이미지', ");
		sbPayMembership.append( "				wm.fulladdress AS '업체 주소',  wm.phone AS '업체 번호', ");
		sbPayMembership.append( "					IFNULL( msr.status, 0 ) AS '회원권 상태'");
		sbPayMembership.append( "						from pay p LEFT OUTER JOIN member m");
		sbPayMembership.append( "							ON( p.member_seq = m.seq ) LEFT OUTER JOIN membership ms");
		sbPayMembership.append( "								ON( p.membership_seq = ms.seq ) LEFT OUTER JOIN board b");
		sbPayMembership.append( "									ON( ms.board_seq = b.seq ) LEFT OUTER JOIN image i");
		sbPayMembership.append( "										ON( b.seq = i.board_seq) LEFT OUTER JOIN member wm");
		sbPayMembership.append( "											ON( b.write_seq = wm.seq ) LEFT OUTER JOIN membership_register msr ");
		sbPayMembership.append( "												ON ( p.merchant_uid = msr.merchant_uid )");
		sbPayMembership.append( "													WHERE m.id = ?");
		sbPayMembership.append( "														group BY p.merchant_uid");
 				
		
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
			bto.setTitle( rs.getString("게시글 타이틀") );
			bto.setImage_name(  rs.getString("대표 이미지") );
			purchaseList.put( "bto", bto );
			
			MemberTO wmto = new MemberTO();
			wmto.setFullAddress( rs.getString("업체 주소") );
			wmto.setPhone( rs.getString("업체 번호") );
			purchaseList.put( "wmto", wmto );
			
			purchaseArrayList.add( purchaseList );
			
		}
		
			// 전체 출력
			sbPurchaseList = new StringBuilder();
			
			// status 0 또는 1 => 등록 대기 전
			sbPurchaseList = new StringBuilder();
			// status 2번 => 현재 사용 중			
			sbPurchaseList = new StringBuilder();
			// status 3번 => 홀딩 
			sbPurchaseList = new StringBuilder();
			// status 4번 => 만료된 회원권
			sbPurchaseList = new StringBuilder();
		
			// 등록 대기 회원권
			for( int i = 0; i < purchaseArrayList.size(); i++ ) {
				
				purchaseList = purchaseArrayList.get( i );
				
				PayTO pto = (PayTO) purchaseList.get("pto");
				String payDate = pto.getPay_date();		//
				String type = pto.getType();			//
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
				
				// 0번이거나 1번이면 등록 대기전으로 분류하고,		==> status가 0 또는 1
						
				// 현재 홀딩 중인 사용중인 회원권으로 빠지고		==> status가 2번
				
				// 현재 홀딩 중인 정지한 회원권으로 빠지고		==> status가 3번
				
				// 만료된 회원권은 보고싶으면 만료된 회원권		==> status가 4번
				
				// 전체 목록은 전체목록						==> status가 모두 다 가능
				
				
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
				sbPurchaseList.append( "							아직 등록전입니다. <br>사용하시려면 아래 등록하기 버튼을 눌러주시거나 등록된 번호로 문의하세요.</br>");
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
				sbPurchaseList.append( "								<td>" + type + "</td>");
				sbPurchaseList.append( "								<th>결제상태</th>");
				sbPurchaseList.append( "								<td>" + payStatus + "</td>");
				sbPurchaseList.append( "							</tr>");
				sbPurchaseList.append( "						</tbody>");
				sbPurchaseList.append( "					</table>");
				sbPurchaseList.append( "					<div class='d-grid gap-2'> ");
				if( membership_register_status.equals( "0" )) {
					sbPurchaseList.append( "						<button id='membershipRegister' class='btn btn-primary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "'> 등록하기 </button>");
				} else {
					sbPurchaseList.append( "						<button id='membershipRegister' class='btn btn-secondary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "' disabled='disabled'> 승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요. </button>");		
				}
				sbPurchaseList.append( "					</div>");
				sbPurchaseList.append( "				</div>");
				sbPurchaseList.append( "			</div>");
				sbPurchaseList.append( "		</div>");
				sbPurchaseList.append( "	</div>");

		
		}
		
		
		} catch( NamingException e) {
			System.out.println( e.getMessage());
		} catch( SQLException e) {
			System.out.println( e.getMessage());
		} finally {
			if( conn != null );
			if( pstmt != null );
			if( rs != null );
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
			<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
				data-bs-target="#profile-tab-pane" type="button" role="tab"
				aria-controls="profile-tab-pane" aria-selected="false">등록 대기중인 회원권</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
				data-bs-target="#contact-tab-pane" type="button" role="tab"
				aria-controls="contact-tab-pane" aria-selected="false">찜 목록</button>
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
									<!-- Form Group (name)-->
									<div class="mb-3">
										<label class="small mb-1" for="inputFirstName">이름</label> <input
											class="form-control" id="inputFirstName" type="text"
											placeholder="Enter your first name" value="<%= mto.getName() %>" readonly>
									</div>
								</div>
							
								<!-- Form Group (id)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputUsername">아이디</label> <input
										class="form-control" id="inputUsername" type="text"
										placeholder="Enter your id" value="<%= mto.getId() %>" readonly>
								</div>
								
								<!-- Form Group (nickname)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputUsername">닉네임</label> <input
										class="form-control" id="inputUsername" type="text"
										placeholder="Enter your username" value="<%= mto.getNickname() %>">
								</div>
								
								<!-- Form Group (id)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputUsername">생년월일</label> <input
										class="form-control" id="inputUsername" type="text"
										placeholder="Enter your id" value="<%= mto.getBirthday() %>">
								</div>
								
								<!-- Form Group (id)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputUsername">휴대전화</label> <input
										class="form-control" id="inputUsername" type="text"
										placeholder="Enter your id" value="<%= mto.getPhone() %>">
								</div>
								
								<!-- Form Group (email address)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputEmailAddress">이메일</label> <input
										class="form-control" id="inputEmailAddress" type="email"
										placeholder="Enter your email address"
										value="<%= mto.getEmail() %>">
								</div>
								
								<!-- Form Group (id)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputUsername">주소</label> <input
										class="form-control" id="inputUsername" type="text"
										placeholder="Enter your id" value="<%= "[" + mto.getZipcode() +"] " + mto.getFullAddress() %>">
								</div>
							
								<!-- Form Row-->
								<div class="row gx-3 mb-3">
									<!-- Form Group (phone number)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputPhone">비밀번호 </label> <input
											class="form-control" id="inputPhone" type="tel"
											placeholder="현재 비밀번호를 입력하세요." value="">
									</div>
									<!-- Form Group (birthday)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputBirthday">비밀번호 입력</label>
										<input class="form-control" id="inputBirthday" type="text"
											name="birthday" placeholder="변경할 비밀번호를 입력하세요."
											value="">
									</div>
								</div>
								<!-- Save changes button-->
								<div class="d-grid gap-2">
									<button class="btn btn-primary mt-3" type="button"> 변경하기 </button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="tab-pane fade" id="profile-tab-pane" role="tabpanel"
			aria-labelledby="profile-tab" tabindex="0">

			<!-- 내 회원권 -->
			<%= sbPurchaseList.toString() %>
			
		</div>
		<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel"
			aria-labelledby="contact-tab" tabindex="0">...</div>
	</div>
</div>
