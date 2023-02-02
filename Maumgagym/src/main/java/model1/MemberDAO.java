package model1;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

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
		
		public int login(String id, String password) { //로그인 함수
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "select password from member where id = ? " ;
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, id);
				 rs = pstmt.executeQuery();
				 
				 if(rs.next()) { 
					 if(rs.getString(1).equals(password)) {
						 return 1; //로그인 성공
					 }
					 else {
						 return 0; //비밀번호 불일치
					 }
				 }
				 return -1; //아이디가 없음
				 
				 
			} catch (SQLException e){
				System.out.println( "[에러] " +  e.getMessage());
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
				if(conn != null) try {conn.close();} catch(SQLException e) {}
			}
			return -2; //오류
			 
		}
		
		
		public int join(MemberTO to){
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			int flag = 1;
			
			try {
				 conn = this.dataSource.getConnection();
				 
				 String sql = "insert into member values (0,?,?,?,?,?,0,?,0,?,?,?)";
				 stringToDate(to);
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, to.getNickname());
				 pstmt.setString(2, to.getId());
				 pstmt.setString(3, to.getPassword());
				 pstmt.setString(4, to.getName());
				 pstmt.setDate(5, stringToDate(to));
				 pstmt.setString(6, to.getMail1()+"@"+to.getMail2());
				 pstmt.setString(7, to.getZipcode());
				 pstmt.setString(8, to.getAddress());
				 pstmt.setString(9, to.getReferAddress());
				 
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
