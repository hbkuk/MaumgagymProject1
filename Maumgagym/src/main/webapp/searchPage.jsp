<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userID = null;

%>        

<jsp:include page="./search/search.jsp">
	<jsp:param name="userID" value="<%= userID %>"/>
</jsp:include>
