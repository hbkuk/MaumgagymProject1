<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!--  STEP 1 -->
	<!-- jQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<!-- iamport.payment.js -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	
	<script type="text/javascript">
	
	<!--  STEP 2 -->
	
	 const IMP = window.IMP; // 생략 가능
	 IMP.init("imp48848665"); // 예: imp00000000a
	 let msg;
	 
	  function requestPay() {
		    IMP.request_pay({
		      pg: "kcp.T0000",
		      pay_method: "card",
		      
		      
		      merchant_uid: "ORD20180131-0000012",   // 주문번호
		      name: "노르웨이 회전 의자",
		      amount: 64900,                         // 숫자 타입
		      buyer_email: "gildong@gmail.com",
		      buyer_name: "홍길동",
		      buyer_tel: "010-4242-4242",
		      buyer_addr: "서울특별시 강남구 신사동",
		      buyer_postcode: "01181"
		    }, function (rsp) { // callback
		      if (rsp.success) {
		        // 결제 성공 시 로직
		    	  console.log(rsp);
		        
		          // jQuery로 HTTP 요청
		          jQuery.ajax({
		              //url: "{서버의 결제 정보를 받는 endpoint}", // 예: https://www.myservice.com/payments/complete
		              method: "POST",
		              headers: { "Content-Type": "application/json" },
		              data: {
		                  imp_uid: rsp.imp_uid,
		                  merchant_uid: rsp.merchant_uid
		              }
		          }).done(function (data) {
		            // 가맹점 서버 결제 API 성공시 로직
		            
                      msg = '결제가 완료되었습니다.';
                      msg += '\n고유ID : ' + rsp.imp_uid;
                      msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                      msg += '\결제 금액 : ' + rsp.paid_amount;
                      msg += '카드 승인번호 : ' + rsp.apply_num;
                      
                      alert(msg);
		          });
		          
                //성공시 이동할 페이지
                //location.href='<%=request.getContextPath()%>/order/paySuccess?msg='+msg;
		        location.href="./paySuccess.jsp";
		        
		      } else {
		        // 결제 실패 시 로직
		    	  console.log(rsp);
		    	  alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
		    	//실패시 이동할 페이지  
		    	//location.href="<%=request.getContextPath()%>/order/payFail";
		    	location.href="./payFail.jsp";
		      }
		    });
		  }
	
	</script>

</head>
<body>
	<button onclick="requestPay()">결제하기</button> <!-- 결제하기 버튼 생성 -->
</body>
</html>