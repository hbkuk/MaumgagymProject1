<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container-xl px-4 mt-4">
	<!-- Account page navigation-->
	<!-- 
    <nav class="nav nav-borders">
        <a class="nav-link active ms-0" href="#" target="__blank">내 정보</a>
        <a class="nav-link" href="#" target="__blank">내 회원권</a>
        <a class="nav-link" href="#" target="__blank">찜 목록</a>
    </nav>
     -->
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
				data-bs-target="#home-tab-pane" type="button" role="tab"
				aria-controls="home-tab-pane" aria-selected="true">내 정보</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
				data-bs-target="#profile-tab-pane" type="button" role="tab"
				aria-controls="profile-tab-pane" aria-selected="false">내
				회원권</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
				data-bs-target="#contact-tab-pane" type="button" role="tab"
				aria-controls="contact-tab-pane" aria-selected="false">찜 목록</button>
		</li>
	</ul>
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="home-tab-pane"
			role="tabpanel" aria-labelledby="home-tab" tabindex="0">

			<!-- 내 정보 -->
			<hr class="mt-0 mb-4">
			<div class="row" id="profile">
				<div class="col-xl-3">
					<!-- Profile picture card-->
					<div class="card mb-4 mb-xl-0">
						<div class="card-header fs-5 fw-bolder">프로필</div>
						<div class="card-body text-center">
							<!-- Profile picture icon-->
							<i class="bi bi-person-circle" style="font-size: 70px;"></i>
							<!-- Nickname and Email-->
							<div class="fs-4 fw-semibold text-muted mb-1">닉네임</div>
							<div class="fs-6 font-italic text-muted mb-3">abcd@abcmail.com</div>
						</div>
					</div>
				</div>
				<div class="col-xl-9">
					<!-- Account details card-->
					<div class="card mb-4">
						<div class="card-header fs-5 fw-bolder">정보 수정</div>
						<div class="card-body">
							<form>
								<!-- Form Group (nickname)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputUsername">닉네임</label> <input
										class="form-control" id="inputUsername" type="text"
										placeholder="Enter your username" value="nickname">
								</div>
								<!-- Form Row-->
								<div class="row gx-3">
									<!-- Form Group (name)-->
									<div class="mb-3">
										<label class="small mb-1" for="inputFirstName">이름</label> <input
											class="form-control" id="inputFirstName" type="text"
											placeholder="Enter your first name" value="name">
									</div>
								</div>

								<!-- Form Group (email address)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputEmailAddress">이메일</label> <input
										class="form-control" id="inputEmailAddress" type="email"
										placeholder="Enter your email address"
										value="name@example.com">
								</div>
								<!-- Form Row-->
								<div class="row gx-3 mb-3">
									<!-- Form Group (phone number)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputPhone">현재 비밀번호 </label> <input
											class="form-control" id="inputPhone" type="tel"
											placeholder="Enter your phone number" value="123456">
									</div>
									<!-- Form Group (birthday)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputBirthday">변경 비밀번호</label>
										<input class="form-control" id="inputBirthday" type="text"
											name="birthday" placeholder="Enter your birthday"
											value="123456">
									</div>
								</div>
								<!-- Save changes button-->
								<button class="btn btn-primary" type="button">Save
									changes</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="tab-pane fade" id="profile-tab-pane" role="tabpanel"
			aria-labelledby="profile-tab" tabindex="0">

			<!-- 내 회원권 -->
			<hr class="mt-0 mb-4">
			<div class="col-xl-12">
				<!-- 회원권 구매 내역-->
				<div class="card mb-4">
					<div class="card-header fs-5 fw-bolder">회원권 구매 내역</div>
					<div class="card-body">
						<div class="row g-0">
							<div class="col-md-4">
								<img
									src="https://s3.ap-northeast-2.amazonaws.com/stone-i-dagym-centers/images/gyms/16016b1fe47123af04/Big)Xpine.jpg"
									class="owl-carousel-image img-fluid" alt="">
							</div>
							<div class="col-md-8" style="padding-left: 50px">
								<h3 class="card-title fw-semibold">역삼 엑스파인 필라테스</h3>
								<br>
								<p class="card-text fs-5">6:1 필라테스 (주2회)</p>
								<p class="card-text fs-7">
									1개월 <span> (0월0일 ~ 0월0일)</span>
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- 결제 내역 -->
				<br/><br/>
				<h5>결제 내역</h5>
				<table class="table">
					<tbody>
						<tr>
							<th scope="row">결제일</th>
							<td>2023년1월26일</td>
							<th>결제금액</th>
							<td>200,000원</td>
						</tr>
						<tr>
							<th scope="row">결제수단</th>
							<td>신용카드</td>
							<th>결제상태</th>
							<td>결제완료</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel"
			aria-labelledby="contact-tab" tabindex="0">...</div>
	</div>
</div>
