package com.to.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.to.member.MemberTO;



public class FacilityDAO {
	private DataSource dataSource;
	
	public FacilityDAO() {
		// TODO Auto-generated constructor stub
		try {
			Context init = new InitialContext();
			Context env = (Context)init.lookup( "java:comp/env" );
			
			this.dataSource = (DataSource)env.lookup( "jdbc/mariadb1" );
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println( "[에러] : " + e.getMessage() );
		}
	}
	
	public ArrayList facility() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Map<String, Object> map = new HashMap<>();

		ArrayList datas = new ArrayList<>();
		
		try {
			conn = this.dataSource.getConnection();
			
			// 글 게시판의 title을 통한 업체 정보, 멤버 게시판의 address을 통한 주소 정보, 멤버쉽 게시판의 price를 통한 가격 정보, 이미지 게시판의 name을 통한 이미지 파일을 가져옴
			// 카테고리 게시판의 seq는 1번(운동시설)으로 가져옴
			StringBuilder sbDatas = new StringBuilder();   			   
			sbDatas.append( " select b.title, m.address, ms.price, i.name " );
			sbDatas.append( "    from board b left outer join member m" );
			sbDatas.append( "          on( b.write_seq = m.seq ) left outer join membership ms" );
			sbDatas.append( "             on( b.seq = ms.board_seq ) left outer join image i" );
			sbDatas.append( "                on( b.seq = i.board_seq ) left outer join category c" );
			sbDatas.append( "                   on( b.category_seq = c.seq)" );
			sbDatas.append( "                      where c.seq = 1" );
			sbDatas.append( "							group by b.seq; " );
			//sbDatas.append( "select t.tag from tag t left outer join board b on( t.board_seq = b.seq );" );
			   
			   
			// 변수에 대입
			String sql = sbDatas.toString(); 
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int i = 0;
			while( rs.next() ) {
				 i++;
				
				BoardTO bto = new BoardTO();
				bto.setTitle(rs.getString( "b.title" ));
				//bto.setTag(rs.getString( "b.tag" ));
			
				MemberTO mto = new MemberTO();
				mto.setAddress(rs.getString("m.address"));
				
				MemberShipTO msto = new MemberShipTO();
				msto.setMembership_price( rs.getInt( "ms.price" ) );
				
//				  System.out.println( bto.getTitle()); 
//				  System.out.println ( mto.getSido());
//				  System.out.println( mto.getGugun()); 
//				  System.out.println( msto.getMembership_price());
				
				map.put("bto" + i, bto);
				map.put("mto" + i, mto);
				map.put("msto" + i, msto);
				datas.add(map);
				}
			
				//System.out.println( datas.size() );
			
//				  Map<String, Object> map1 = (Map<String, Object>) datas.get(0);
//				  
//				  BoardTO to = (BoardTO) map1.get("bto1"); 
//				  System.out.println( to.getTitle() );
//				  
//				  MemberTO mto = (MemberTO) map1.get("mto1"); 
//				  System.out.println( mto.getSido() ); 
//				  System.out.println( mto.getGugun() );
//				  
//				  MemberShipTO msto = (MemberShipTO) map1.get( "msto1" ); 
//				  System.out.println( msto.getMembership_price() );
//				  
//				  
//				  Map<String, Object> map2 = (Map<String, Object>) datas.get(1);
//				  
//				  BoardTO to2 = (BoardTO) map2.get("bto2"); System.out.println( to2.getTitle()
//				  );
//				  
//				  MemberTO mto2 = (MemberTO) map2.get("mto2"); System.out.println(
//				  mto2.getSido() ); System.out.println( mto2.getGugun() );
//				  
//				  MemberShipTO msto2 = (MemberShipTO) map2.get( "msto2" ); System.out.println(
//				  msto2.getMembership_price() );
//				 
				
//		      
//			
//			//글 태그 가져오기
//			StringBuilder sbTag = new StringBuilder();   			   
//			sbTag.append( " select t.tag" );
//			sbTag.append( "		from tag t left outer join board b" );
//			sbTag.append( "			on( t.board_seq = b.seq );" );
//			
//			
//			// 변수에 대입
//			sql = sbTag.toString(); 
//			pstmt = conn.prepareStatement(sql);
//			
//			rs = pstmt.executeQuery();
//			
//			while( rs.next() ) {
//				BoardTO bto = new BoardTO();
//				bto.setTag(rs.getString( "t.tag" ));
//				
//			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println( "[에러] " + e.getMessage() );
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		    
		return datas;
	}
	
	public BoardTO tag() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = this.dataSource.getConnection();
			
			//글 태그 가져오기
			String sql = "select t.tag from tag t left outer join board b on( t.board_seq = b.seq );";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				BoardTO bto = new BoardTO();
				bto.setTag(rs.getString( "t.tag" ));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println( "[에러] " + e.getMessage() );
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		
		
		return tag();
	}

}
