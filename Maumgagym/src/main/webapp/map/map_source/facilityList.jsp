<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>


<%

	request.setCharacterEncoding("utf-8");

	//ArrayList<> facilityListTest = (ArrayList) request.getAttribute("facilityListTest");
	
	JSONObject obj = new JSONObject();
	JSONArray ary = new JSONArray();
	
	obj.put( "title1", "테스트 1 / 휴메이크 휘트니스 강남점");
	obj.put( "latitude1", "37.492098" );
	obj.put( "longitude1", "127.0297971" );
	
	ary.add( obj );
	
	out.println( ary );
	
    
%> 
