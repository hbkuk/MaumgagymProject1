<%@page import="com.to.member.MemberTO"%>
<%@page import="com.to.board.FacilityDAO"%>
<%@page import="com.to.board.BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	BoardTO bto = new BoardTO();
	bto.setTitle( request.getParameter( "subject" ));
	bto.setContent( request.getParameter( "content" ));
	bto.setCategory_seq(Integer.parseInt(request.getParameter( "c_seq" )) );
	MemberTO mto = new MemberTO();
	mto.setNickname( request.getParameter( "nickname" ));
	
	System.out.println( "title : " + request.getParameter( "subject" ));
	System.out.println( "content : " + request.getParameter( "content" ));
	//System.out.println( "nickname : " + request.getParameter( "nickname" ));
	
	FacilityDAO dao = new FacilityDAO();
	int flag = dao.writeOk(bto, mto);
		
		out.println( "<script type='text/javascript'>" );
		if( flag == 0 ) {
			out.println( "alert('글쓰기에 성공했습니다.');");
			out.println( "location.href='../../facilityPage_partner.jsp'" );
		} else {
			out.println( "alert('글쓰기에 실패했습니다.');" );
			out.println( "history.back();" );
		}
		out.println( "</script>" );

%>
