package com.dao.member;

import java.lang.reflect.Member;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.to.member.MemberTO;

public class MemberDAO {
	
	private DataSource dataSource;
		
		public MemberDAO() {
			
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
				this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" ); //항상 이부분 this로 들어가도록 주의
				
				System.out.println("db연결성공");
			} catch (NamingException e) {
				System.out.println( "[에러] " + e.getMessage() ); 
			}
		}
		
		 public Date stringToDate(MemberTO to)
		    {
		        String year = to.getBirthyy();
		        String month = to.getBirthmm();
		        String day = to.getBirthdd();
	        
		        Date birthday = Date.valueOf(year+"-"+month+"-"+day);
		        
		        return birthday;
		        
		    } 
		
		public MemberTO login( MemberTO to  ) { //로그인 함수
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "select password, type, nickname from member where id = ? " ;
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getId() );
				 rs = pstmt.executeQuery();
				 
				 if(rs.next()) { 
					 
					 to.setType( rs.getString(2) );
					 to.setNickname( rs.getString(3) );
					 
					 if(rs.getString(1).equals( to.getPassword() )) {
						 to.setFlag( 1 );
						 return to;  //로그인 성공
					 }
					 else {
						 to.setFlag( 0 );
						 return to; //비밀번호 불일치
					 }
				 }
				 to.setFlag( -1 );
				 return to;  //아이디가 없음
				 
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
			}
			return to; //오류
			 
		}
		
		
		public int join(MemberTO to){
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			int flag = 1;
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "insert into member values (0,?,?,?,?,?,0,?,?,?,?,?,?)";
				 stringToDate(to);
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getNickname());
				 pstmt.setString(2, to.getId());
				 pstmt.setString(3, to.getPassword());
				 pstmt.setString(4, to.getName());
				 pstmt.setDate(5, stringToDate(to));
				 pstmt.setString(6, to.getMail1()+"@"+to.getMail2());
				 pstmt.setString(7, to.getType());
				 pstmt.setString(8, to.getZipcode());
				 pstmt.setString(9, to.getAddress());
				 pstmt.setString(10, to.getFullAddress());
				 pstmt.setString(11, to.getReferAddress());
				 
				 if(pstmt.executeUpdate() == 1){
						flag = 0; //정상
					}
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
			}
			return flag;
			
		}
}
