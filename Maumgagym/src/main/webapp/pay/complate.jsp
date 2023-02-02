<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding( "utf-8" );	

	// post로 온 요청을 받기
	System.out.println( request.getParameter( "imp_uid" ) );
	System.out.println( request.getParameter( "merchant_uid" ));
	
	
	
%>