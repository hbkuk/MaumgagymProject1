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
		
		sbPayMembership.append( "select p.pay_date AS '결제 날짜', p.type AS '결제 방식', IF( p.status = 1, '정상', '환불' ) AS '결제 상태'," );
		sbPayMembership.append( "	ms.name AS '회원권 이름', ms.price AS '회원권 가격', ms.period AS '회원권 기간',");
		sbPayMembership.append( "		b.title AS '게시글 타이틀',");
		sbPayMembership.append( "			i.name AS '대표 이미지'");
		sbPayMembership.append( "				from pay p LEFT OUTER JOIN member m");
		sbPayMembership.append( "					ON( p.member_seq = m.seq ) LEFT OUTER JOIN membership ms");
		sbPayMembership.append( "						ON( p.membership_seq = ms.seq ) LEFT OUTER JOIN board b");
		sbPayMembership.append( "							ON( ms.board_seq = b.seq ) LEFT OUTER JOIN image i");
		sbPayMembership.append( "								ON( b.seq = i.board_seq)");
		sbPayMembership.append( "									WHERE m.id = ?");
		sbPayMembership.append( "										LIMIT 0,1");
 				
		
		sql = sbPayMembership.toString();
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id );
		
		rs = pstmt.executeQuery();
		
		if( rs.next() ) {
			
			PayTO pto = new PayTO();
			pto.setPay_date( rs.getString("결제 날짜") );
			pto.setType( rs.getString("결제 방식") );
			pto.setPay_status( rs.getString("결제 상태") );
			
			MemberShipTO msto = new MemberShipTO();
			msto.setMembership_name( rs.getString("회원권 이름") );
			msto.setMembership_price( rs.getInt("회원권 가격") );
			msto.setMembership_period( rs.getInt("회원권 기간") );
			
			
			
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
				aria-controls="profile-tab-pane" aria-selected="false">내
				회원권</button>
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
			<hr class="mt-0 mb-4">
			<div class="col-xl-12">
				<!-- 회원권 구매 내역-->
				<div class="card mb-4">
					<div class="card-header fs-5 fw-bolder">회원권 구매 내역</div>
					<div class="card-body">
						<div class="row g-0">
							<div class="col-md-4">
								<img
									src="https://s3.ap-northeast-2.amazonaws.com/stone-i-dagym-centers/images/gyms/16016b1fe47123af04/Big)Xpine.jpg"
									class="owl-carousel-image img-fluid" alt="">
							</div>
							<div class="col-md-8" style="padding-left: 50px">
								<h3 class="card-title fw-semibold">역삼 엑스파인 필라테스</h3>
								<br>
								<p class="card-text fs-5">6:1 필라테스 (주2회)</p>
								<p class="card-text fs-7">
									1개월 <span> (0월0일 ~ 0월0일)</span>
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- 결제 내역 -->
				<br/><br/>
				<h5>결제 내역</h5>
				<table class="table">
					<tbody>
						<tr>
							<th scope="row">결제일</th>
							<td>2023년1월26일</td>
							<th>결제금액</th>
							<td>200,000원</td>
						</tr>
						<tr>
							<th scope="row">결제수단</th>
							<td>신용카드</td>
							<th>결제상태</th>
							<td>결제완료</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel"
			aria-labelledby="contact-tab" tabindex="0">...</div>
	</div>
</div>
