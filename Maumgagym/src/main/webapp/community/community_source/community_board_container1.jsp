
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<hr/><br/><br/>

<main>
  <div class="container py-4">
	<h1>커뮤니티 샘플</h1> <br/>
    <div class="row align-items-md-stretch">
      <div class="col-md-6">
        <div class="h-100 p-5 text-bg-primary rounded-3">
          <h1>[건강] HOT 여기주목!</h1>
          <p class="h3">2023년 계묘년 뜨는 food! 입맛과 건강을 동시에 챙기고싶으신 부운~</p>
          <button class="btn btn-outline-light" type="button">보러가기</button>
        </div>
      </div>
      <div class="col-md-6">
        <div class="h-100 p-5 bg-info border rounded-3">
          <h1>[운동] HOT 여기주목!</h1>
          <p class="h3">2023년, 가장 주목받고 있는 운동은?!</p><br/>
          <button class="btn btn-outline-secondary" type="button">보러가기</button>
        </div>
      </div>
    </div>
  </div>
</main>

<div class="container">
		<br/>
		<form class="row domain-search bg-pblue">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <p class="h3">실시간 전체글 <span class="count">5</span>개</p>
                </div>
                <div class="col-md-9">
                    <div class="input-group">
                        <input type="search" placeholder="키워드를 입력해보세요" class="form-control mr">
                        <span class="input-group-addon"><input type="submit" value="검색" class="btn btn-primary"></span>
                    </div>
                </div>
            </div>
        </div>
    </form>
		
    
	    <br/><br/>			
		<table class="table table-striped table-hover text-center">
		<tr>
			<th scope="col">&nbsp;</th>
			<th scope="col">번호</th>
			<th scope="col">공지사항/이벤트</th>
			<th scope="col">제목</th>
			<th scope="col">글쓴이</th>
			<th scope="col">등록일</th>
			<th scope="col">조회</th>
			<th scope="col">&nbsp;</th>
		</tr>		
		<tr>
			<td>&nbsp;</td>
			<td scope="row">1</td>
			<td class="text-muted">공지사항</td>
			<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>공지사항 입니다.1</td>
			<td>하태현</td>
			<td>2017-01-31</td>
			<td>0</td>	
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td scope="row">2</td>
			<td class="text-muted">공지사항</td>
			<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>공지사항 입니다.2</td>
			<td>이현주</td>
			<td>2017-01-31</td>
			<td>0</td>
			<td>&nbsp;</td>
			</tr>
			
		<tr>
			<td>&nbsp;</td>
			<td scope="row">3</td>
			<td class="text-muted">공지사항</td>
			<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>공지사항 입니다.3</td>
			<td>테스트</td>
			<td>2017-01-31</td>
			<td>0</td>
			<td>&nbsp;</td>
		</tr>			
		<tr>
			<td>&nbsp;</td>
			<td scope="row">4</td>
			<td class="text-muted">이벤트</td>
		<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>이벤트 입니다.1</td>
			<td>김종희</td>
			<td>2017-01-31</td>
			<td>0</td>
			<td>&nbsp;</td>
		</tr>		
		<tr>
			<td>&nbsp;</td>
			<td scope="row">5</td>
			<td class="text-muted">이벤트</td>
			<!--<td class="left"><a href="board_view1.jsp">adfas</a>&nbsp;<img src="./images/icon_new.gif" alt="NEW"></td> -->
			<td>이벤트 입니다.2</td>
			<td>황병국</td>
			<td>2017-01-31</td>
			<td>0</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<br/><br/><br/>
		<ul class="pagination justify-content-center">
		  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
		  <li class="page-item active"><a class="page-link" href="#">1</a></li>
		  <li class="page-item"><a class="page-link" href="#">2</a></li>
		  <li class="page-item"><a class="page-link" href="#">3</a></li>
		  <li class="page-item"><a class="page-link" href="#">Next</a></li>
		</ul>
	</div>	
</div>
