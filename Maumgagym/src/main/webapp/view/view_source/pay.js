
    
    
    $('#payBtn').on( 'click', function(){
    	
    	if( document.getElementById("memberShip").selectedIndex == 0 ) {
    	    alert("회원권을 선택해주세요.");
    	    return false;
    		}
    	
    	$('#myModal').modal("show");
    });
    
    
    $("#paymentOk").on( 'click', function(){

    	requestPayInfo();

      });
    
    
    $("#paymentcancle").on( 'click', function(){

    	alert("결제 취소를 눌렀습니다.");
      });
    
	 const IMP = window.IMP; // 생략 가능
	 IMP.init("imp48848665"); // 예: imp00000000a
	 let msg;
	  let merchant_uid
	  let name
	  let amount
	  let buyer_email
	  let buyer_name
	  let buyer_tel
	  let buyer_addr
	  let buyer_postcode
	  let membership_seq
	  
	  function requestPayInfo() {
	  
		$.ajax({
			url: './pay/membership.jsp',
			type: 'get',
			data: {
				
				//buyer_nickname : '<%=(String)session.getAttribute("buyer_nickname")%>';
				buyer_nickname : '테스트2',
				membership_seq : $("#memberShip option:checked").val()
				
			},
			dataType: 'json',
			success: function( jsonData ) {
				
				if( jsonData.flag == 0 ) {
					
					merchant_uid = jsonData.merchant_uid;
					name = jsonData.name;
					amount = jsonData.amount;
					buyer_email = jsonData.buyer_email;
					buyer_name = jsonData.buyer_name;
					buyer_tel = jsonData.buyer_tel;
					buyer_addr = jsonData.buyer_addr;
					buyer_postcode = jsonData.buyer_postcode;
					
					requestPay();
					membership_seq = $("#memberShip option:checked").val();
					
				} else {
					alert( '서버 에러' );
			}
				
			},
			error: function(err) {
				alert( '[에러] ' + err.status);
			}
		});

	  }
	 
	  function requestPay() {
		  	
			console.log( merchant_uid );
 		    IMP.request_pay({
	
		      pg: "kcp.T0000",
		      pay_method: "card",
		      merchant_uid: merchant_uid,
		      name: name,
		      amount: amount, 
		      buyer_email: buyer_email,
		      buyer_name: buyer_name,
		      buyer_tel: buyer_tel,
		      buyer_addr: buyer_addr,
		      buyer_postcode: buyer_postcode
		      
		      
		    }, function (rsp) { // callback
		      if (rsp.success) {
		        // 결제 성공 시 로직
		    	  console.log(rsp);
		        
		        
		          // jQuery로 HTTP 요청
		          jQuery.ajax({
		              url: "./pay/complate.jsp", // 예: https://www.myservice.com/payments/complete
		              method: "POST",
		              headers: { "Content-Type": "application/json" },
		              //headers: { "Content-Type": "application/text" },
		              data: {
		            	  imp_uid: rsp.imp_uid,
		                  merchant_uid: rsp.merchant_uid,
		                  pay_method: "card",
		                  membership_seq : membership_seq
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
		        //location.href="./pay/complate.jsp";
		        
		      } else {
		        // 결제 실패 시 로직
		    	  console.log(rsp);
		    	  alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
		    	//실패시 이동할 페이지  
		    	//location.href="<%=request.getContextPath()%>/order/payFail";
		    	//location.href="./pay/payFail.jsp";
		      }
		    });
		  }
