<%@page import="com.to.pay.PayTO"%>
<%@page import="com.to.board.MemberShipTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
		
	request.setCharacterEncoding( "utf-8" );

	String merchantUid = request.getParameter( "merchant_uid" );
	String content = request.getParameter( "content" );
	String writerSeq = request.getParameter( "writer_seq" );
	String starScore = request.getParameter( "star_score" );
	String boardSeq	= request.getParameter( "board_seq" );
	
/* 	System.out.println( content );
	System.out.println( writerSeq );
	System.out.println( starScore );
	System.out.println( boardSeq ); */
	
	
 	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 비정상 입력
	// flag가 2 이면 서버 오류
	int flag = 2;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		String sql = "insert into review values ( 0, ?, now(), ?, ?, 1, ? ) ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, content );
		pstmt.setString(2, writerSeq );
		pstmt.setString(3, starScore );
		pstmt.setString(4, boardSeq );
		
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
			if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if( conn != null) try {conn.close();} catch(SQLException e) {}
			if( rs != null) try {rs.close();} catch(SQLException e) {}
		}
		
		JSONObject obj = new JSONObject();
	
	 	obj.put( "flag", flag);
	 	obj.put( "merchant_uid", merchantUid);
	 	
	 	out.println( obj ); 
	 	
%>