<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.to.board.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.to.board.BoardDAO"%>    
<%
	
	BoardDAO dao = new BoardDAO();
	ArrayList<BoardTO> boardLists = dao.boardList();
	
	int totalRecord = boardLists.size(); //총데이터갯수
	
	StringBuilder sbHtml = new StringBuilder();
			 /*
			 					BoardTO to = new BoardTO();
					to.setSeq(rs.getInt("b.seq"));
					to.setCategory(rs.getString("c.category"));
					to.setTopic(rs.getString("c.topic"));
					to.setTitle(rs.getString("b.title"));
					to.setNickname(rs.getString("m.nickname"));
					to.setWrite_date(rs.getString("b.write_date"));
					boardLists.add(to);
			 */
			 for( BoardTO to : boardLists){
				int seq = to.getSeq();
				String category = to.getCategory();
				String topic = to.getTopic();
				String title = to.getTitle();
				String nickname = to.getNickname();
				String date = to.getWrite_date();
				 
				sbHtml.append("<tr>");
				sbHtml.append("<td scope='row'>" + seq + "</td>");
				sbHtml.append("<td class='text-muted'>" + category + "</td>");
				sbHtml.append("<td>" + topic + "</td>");
				sbHtml.append("<td class='text-start fw-bold'>");
				sbHtml.append("<a href='community_viewPage.jsp?seq=" + seq + "'>" + title + "</a>&nbsp;"); 
				sbHtml.append("</td>");
				sbHtml.append("<td>" + nickname + "</td>");
				sbHtml.append("<td>" + date + "</td>");
				sbHtml.append("<td><a onclick=\"deleteboard('"+seq+"');\"><span class=\"badge bg-danger\">삭제</span></a></td>");
				sbHtml.append("</tr>");
			 }
%>    
<hr/>
<script type="text/javascript">
function deleteboard(deleteSeq) {
	alert(deleteSeq);
}
</script>

		<div class="container mt-5">
			<div class="row">

            <div class="page-heading">
                <section class="section">
                    <div class="card">
                        <div class="card-header bg-white">
                          <h3>게시물관리</h3>
                          <p class="text-subtitle text-muted">공지/이벤트, 커뮤니티 게시글들을 통합하여 관리합니다.</p>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover" id="table1">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>카테고리</th>
                                        <th>토픽</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>기능</th>
                                    </tr>
                                </thead>
                                <%= sbHtml.toString() %>
                               <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                               <!--  <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>운동시설</td>
                                        <td>피트니스</td>
                                        <td>제목1</td>
                                        <td>회원1</td>
                                        <td>2022-05-21 16:59:19</td>
                                        <td>60</td>
                                        <td>
                                            <a href=""><span class="badge bg-success">수정</span></a>
                                            <a ><span class="badge bg-danger">삭제</span></a>
                                   </td>
                                    </tr>-->
                                </tbody>
                            </table>
                        </div>
                    </div>

                </section>
            </div>
         </div>
       </div>
