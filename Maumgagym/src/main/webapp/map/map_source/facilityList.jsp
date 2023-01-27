<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>


<%

	request.setCharacterEncoding("utf-8");

	//ArrayList<> facilityListTest = (ArrayList) request.getAttribute("facilityListTest");
	
	JSONArray ary = new JSONArray();
	
	JSONObject obj = new JSONObject();
	// DB에서 위도 경도 받아오기. DB에 위도 경도를 따로 넣어야하나 ?
	obj.put( "title", "운동시설 1");
	obj.put( "latlng", "new kakao.maps.LatLng( 37.492098, 127.0297971 )" );
	
	JSONObject obj1 = new JSONObject();
	obj1.put( "title", "운동시설 2");
	obj1.put( "latlng", "new kakao.maps.LatLng( 37.4900845, 127.0305764 )" );
	
	ary.add( obj );
	ary.add( obj1 );
	
	out.println( ary );
%> 
