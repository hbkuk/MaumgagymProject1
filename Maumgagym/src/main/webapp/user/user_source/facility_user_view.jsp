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
		
		
		StringBuilder sbSelectSql = new StringBuilder();
		
		sbSelectSql.append( "SELECT CONCAT( c.topic ) '카테고리' ," );
		sbSelectSql.append( "	CONCAT ( '[', ms.seq, '] ', ms.name ) '회원권 정보',");
		sbSelectSql.append( "		m.name '회원 이름', m.phone '회원 연락처',");
		sbSelectSql.append( "			IFNULL ( DATE_FORMAT( msr.register_date, '%Y-%m-%d'), '-' ) '회원권 등록일', IFNULL( DATE_FORMAT( msr.expiry_date ,'%Y-%m-%d'), '-' ) '회원권 만료일', ");
		sbSelectSql.append( "				case ");
		sbSelectSql.append( "					when msr.status IS NULL then '결제 완료' ");
		sbSelectSql.append( "					when msr.status = 1 then '승인 대기' ");
		sbSelectSql.append( "					when msr.status = 2 then '승인 완료' ");
		sbSelectSql.append( "					when msr.status = 3 then '사용 중지' ");
		sbSelectSql.append( "					when msr.status = 4 then '기간 만료' ");
		sbSelectSql.append( "					when msr.status = 5 then '환불' ");
		sbSelectSql.append( "				END AS '회원권  상태', ");
		sbSelectSql.append( "					msr.merchant_uid AS '주문 번호', ");
		sbSelectSql.append( "						IF( p.status = 1, '정상', '환불' ) AS '결제 상태', DATE_FORMAT(p.pay_date, '%Y-%m-%d') '결제일' ");
		sbSelectSql.append( "							FROM member LEFT OUTER JOIN board b ");
		sbSelectSql.append( "								ON (member.seq = b.write_seq ) ");
		sbSelectSql.append( "									LEFT OUTER JOIN category c ");
		sbSelectSql.append( "										ON ( b.category_seq = c.seq ) ");
		sbSelectSql.append( "											LEFT OUTER JOIN membership ms ");
		sbSelectSql.append( "												ON ( b.seq = ms.board_seq ) ");
		sbSelectSql.append( "													INNER JOIN pay p ");
		sbSelectSql.append( "														ON ( ms.seq = p.membership_seq ) ");
		sbSelectSql.append( "															LEFT OUTER JOIN member m ");
		sbSelectSql.append( "																ON ( p.membership_seq = m.seq ) ");
		sbSelectSql.append( "																	LEFT OUTER JOIN membership_register msr ");
		sbSelectSql.append( "																		ON( p.merchant_uid = msr.merchant_uid ) ");
		sbSelectSql.append( "																			WHERE member.id = ? AND  c.seq < 9 ");
		
 				
		
		sql = sbSelectSql.toString();
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id );
		
		rs = pstmt.executeQuery();
		
		purchaseArrayList = new ArrayList();
		
		while( rs.next() ) {
			
			purchaseList = new HashMap();
			
			BoardTO bto = new BoardTO();
			bto.setFullCategoryString( rs.getString("카테고리") );
			purchaseList.put( "bto", bto );
			
			MemberShipTO msto = new MemberShipTO();
			msto.setFull_membership_name( rs.getString("회원권 정보") );
			purchaseList.put( "msto", msto );
			
			MemberTO pmto = new MemberTO();
			pmto.setName( rs.getString("회원 이름") );
			pmto.setPhone( rs.getString("회원 연락처") );
			purchaseList.put( "pmto", pmto );
			
			PayTO pto = new PayTO();
			pto.setMembership_register_date( rs.getString("회원권 등록일") );
			pto.setMembership_expiry_date( (  rs.getString("회원권 만료일") )  );
			pto.setMembership_register_status( ( rs.getString("회원권  상태") ) );
			pto.setPay_status( ( rs.getString("결제 상태") ) );
			pto.setPay_date( ( rs.getString("결제일") ) );
			pto.setMerchant_uid( ( rs.getString("주문 번호") ) );
			purchaseList.put( "pto", pto );
			
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
				
				BoardTO bto = (BoardTO) purchaseList.get("bto");
				String fullCategoryString = bto.getFullCategoryString();
				
				MemberShipTO msto = (MemberShipTO) purchaseList.get("msto");
				String fullMembershipName = msto.getFull_membership_name();
				
				MemberTO pmto = (MemberTO) purchaseList.get("pmto");
				String name = pmto.getName();
				String phone = pmto.getPhone();
				String email = pmto.getEmail();
				
				PayTO pto = (PayTO) purchaseList.get("pto");
				String membershipRegisterDate = pto.getMembership_register_date();
				String membershipExpiryDate = pto.getMembership_expiry_date();
				String membershipRegisterStatus = pto.getMembership_register_status();
				String pdayStatus = pto.getPay_status();
				String payDate = pto.getPay_date();
				String merchantUid = pto.getMerchant_uid();
				
				
				sbPurchaseList.append( "	<tr class='h-100'> ");
				sbPurchaseList.append( "		<td>" + (1 + i) +"</td> ");
				sbPurchaseList.append( "		<td>" + fullCategoryString + "</td> ");
				sbPurchaseList.append( "		<td>" + fullMembershipName + "</td> ");
				sbPurchaseList.append( "		<td>" + name + "</td> ");
				sbPurchaseList.append( "		<td>" + phone + "</td> ");
				sbPurchaseList.append( "		<td>" + membershipRegisterDate + "</td> ");
				sbPurchaseList.append( "		<td>" + membershipExpiryDate + "</td> ");
				if( membershipRegisterStatus.equals( "승인 대기")) {
				sbPurchaseList.append( "	    	<td><span class='badge bg-secondary'>" + membershipRegisterStatus + "</span></td>");
				} else if ( membershipRegisterStatus.equals( "승인 완료")) {
				sbPurchaseList.append( "	    	<td><span class='badge bg-success'>" + membershipRegisterStatus + "</span></td>");
				} else if ( membershipRegisterStatus.equals( "사용 중지")) {
				sbPurchaseList.append( "	    	<td><span class='badge bg-warning '>" + membershipRegisterStatus + "</span></td>");
				} else if ( membershipRegisterStatus.equals( "기간 만료")) {
				sbPurchaseList.append( "	    	<td><span class='badge bg-danger '>" + membershipRegisterStatus + "</span></td>");
				} else if ( membershipRegisterStatus.equals( "환불")) {
				sbPurchaseList.append( "	    	<td><span class='badge bg-danger '>" + membershipRegisterStatus + "</span></td>");
				}
				sbPurchaseList.append( "		<td>" + pdayStatus + "</td> ");
				sbPurchaseList.append( "		<td>" + payDate + "</td> ");
				sbPurchaseList.append( "		<td> ");
				
				if( membershipRegisterStatus.equals( "승인 대기")) {
				sbPurchaseList.append( "	    	<button id='" + name + "' onclick='registerConfirm(this);' value='" + merchantUid +"' class='border-0 badge bg-success'>승인</button> ");
				}
				if( membershipRegisterStatus.equals( "승인 대기")) {
				sbPurchaseList.append( "	    	<a ><span class='badge bg-warning text-dark'>반려</span></a> ");
				}
				if( membershipRegisterStatus.equals( "승인 대기") || membershipRegisterStatus.equals( "승인 완료") ) {
				sbPurchaseList.append( "	    	<button id='" + name + "' onclick='refundConfirm(this);' value='" + merchantUid +"' class='border-0 badge bg-danger'>환불</button> ");
				}
				if( membershipRegisterStatus.equals( "승인 완료") ) {
				sbPurchaseList.append( "	    	<button id='" + name + "' onclick='pauseConfirm(this);' value='" + merchantUid +"' class='border-0 badge bg-warning text-dark'>중지</button> ");
				}
				if( membershipRegisterStatus.equals( "사용 중지") ) {
				sbPurchaseList.append( "	    	<button id='" + name + "' onclick='restartConfirm(this);' value='" + merchantUid +"' class='border-0 badge bg-secondary text-white'>재개</button> ");
				}
				sbPurchaseList.append( "		</td> ");
				sbPurchaseList.append( "	</tr> ");
				
				
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
			<button class="nav-link" id="home-tab" data-bs-toggle="tab"
				data-bs-target="#home-tab-pane" type="button" role="tab"
				aria-controls="home-tab-pane" aria-selected="true">내 정보</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="purchase-list-tab" data-bs-toggle="tab"
				data-bs-target="#purchase-list-tab-pane" type="button" role="tab"
				aria-controls="purchase-list-tab-pane" aria-selected="false">전체 결제 회원권</button>
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
		<div class="tab-pane fade show" id="home-tab-pane"
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
		
		<div class="tab-pane fade show active" id="purchase-list-tab-pane" role="tabpanel"
			aria-labelledby="purchase-list-tab-pane-tab" tabindex="1">

			<!--  %= sbPurchaseList.toString() %> -->
			
			<div class="container mt-5">
				<div class="row">
	            <div class="page-heading">
	                <section class="section">
	                    <div class="card">
	                        <div class="card-header bg-white">
	                          <h3>전체 결제 회원권</h3>
	                          <p class="text-subtitle text-muted">결제한 회원을 조회합니다.</p>
	                        </div>
	                        <div class="card-body">
	                            <table class="table table-hover text-left" id="table1">
	                                <thead>
	                                    <tr>
	                                    	<th>번호</th>
	                                        <th>카테고리</th>
	                                        <th>회원권 정보</th>
	                                        <th>이름</th>
	                                        <th>연락처</th>
	                                        <th>등록일</th>
	                                        <th>만료일</th>
	                                        <th>상태</th>
	                                        <th>결제 상태</th>
	                                        <th>결제일</th>
	                                        <th>기능</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <%= sbPurchaseList.toString() %>
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>
	                </section>
	            </div>
	         </div>
	       </div>
			
			
		</div>
		
		
		<div class="tab-pane fade" id="before-register-tab-pane" role="tabpanel"
			aria-labelledby="before-register-tab-pane-tab" tabindex="2">

			<!--  <%= sbBeforeRegister.toString() %> -->
			
		</div>
		
		<div class="tab-pane fade" id="after-register-tab-pane" role="tabpanel"
			aria-labelledby="after-register-tab-pane-tab" tabindex="3">

			<!--<%= sbAfterRegister.toString() %>  -->
			
		</div>
		
		<div class="tab-pane fade" id="pause-membership-tab-pane" role="tabpanel"
			aria-labelledby="pause-membership-tab-pane-tab" tabindex="4">

			<!--<%= sbPauseMembership.toString() %>  -->
			
		</div>
		
		<div class="tab-pane fade" id="expire-membership-tab-pane" role="tabpanel"
			aria-labelledby="expire-membership-tab-pane-tab" tabindex="5">

			<!-- <%= sbExpireMembership.toString() %>  -->
			
		</div>
		
		<div class="tab-pane fade" id="cart-membership-tab-pane" role="tabpanel"
			aria-labelledby="cart-membership-tab-pane" tabindex="6">
		</div>
		
	</div>
</div>
