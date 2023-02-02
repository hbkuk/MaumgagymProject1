<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding( "utf-8" );	

	// post로 온 요청을 받기
	String impUid = request.getParameter( "imp_uid" );
	String merchantUid = request.getParameter( "merchant_uid" );
	String membershipSeq = request.getParameter( "membership_seq" );
	String payMethod = request.getParameter( "pay_method" );
	
	System.out.println( impUid );
	System.out.println( merchantUid );
	System.out.println( membershipSeq );
	System.out.println( payMethod );
	
 	Connection conn = null;
	PreparedStatement pstmt = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 서버 오류
	int flag = 1;
	
 	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		String sql = "insert into pay values ( ?, ?, ?, ? )";
				
		pstmt = conn.prepareStatement(sql);
		
		
		pstmt.setString(1, merchantUid );
		pstmt.setString(2, membershipSeq );
		pstmt.setString(3, payMethod );
		pstmt.setString(4, impUid );
		
		if( pstmt.executeUpdate() == 1) {
			flag = 0;
		} else {
			flag = 1;
		}
		
	} catch( NamingException e) {
		System.out.println( e.getMessage());
	} catch( SQLException e) {
		System.out.println( e.getMessage());
	} finally {
		if( conn != null );
		if( pstmt != null );
	}
			
	
	
%>