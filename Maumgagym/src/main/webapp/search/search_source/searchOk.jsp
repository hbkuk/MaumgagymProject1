<%@page import="java.util.ArrayList"%>
<%@page import="com.to.board.SearchDAO"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="com.to.board.BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	String search = (String)request.getParameter( "search" );
	//System.out.println( "검색어 : " + search );
	
	out.println( "<script type='text/javascript'>" );
	if( search != null ) {
		out.println( "location.href='../../searchPage.jsp?search=" + search + "'" );
	}
	out.println( "</script>" );

%>    
