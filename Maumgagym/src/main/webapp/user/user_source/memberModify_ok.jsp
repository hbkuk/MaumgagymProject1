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

	String name = request.getParameter( "name" );
	String id = request.getParameter( "id" );
	String nickname = request.getParameter( "nickname" );
	String birthday = request.getParameter( "birthday" );
	String phone = request.getParameter( "phone" );
	String email = request.getParameter( "email" );
	String fullAddress = request.getParameter( "full_address" );
	String password = request.getParameter( "password" );
	String changePassword = request.getParameter( "change_password" );
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	// flag가 0 이면 정상
	// flag가 1 이면 비밀번호 오류
	// flag가 2 이면 서버 오류
	int flag = 2;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		String sql = "update member SET nickname = ?, birthday = ?, phone = ?, email = ?, fulladdress = ?, password = ? where id = ? and password = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nickname );
		pstmt.setString(2, birthday );
		pstmt.setString(3, phone );
		pstmt.setString(4, email );
		pstmt.setString(5, fullAddress );
		pstmt.setString(6, changePassword );
		pstmt.setString(7, id );
		pstmt.setString(8, password );
		
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
		}
	 	
	 	JSONObject obj = new JSONObject();
	 	
	 	obj.put( "flag", flag);
	 	
	 	out.println( obj );

%>