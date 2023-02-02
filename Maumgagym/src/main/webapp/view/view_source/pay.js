
    
    
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
	  let buyer_seq
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
				buyer_nickname : '닉네임2',
				membership_seq : $("#memberShip option:checked").val()
				
			},
			dataType: 'json',
			success: function( jsonData ) {
				
				if( jsonData.flag == 0 ) {
					
					merchant_uid = jsonData.merchant_uid;
					name = jsonData.name;
					amount = jsonData.amount;
					buyer_seq = jsonData.buyer_seq;
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
		    	  //console.log(rsp);
		        
		          // 성공 후 DB insert
		          
		          $.ajax({
		              url: "./pay/complate.jsp",
		              type: "post",
		              data: {
		            	  imp_uid: rsp.imp_uid,
		                  merchant_uid: rsp.merchant_uid,
		                  pay_method: "card",
		                  membership_seq : membership_seq,
		                  buyer_seq : buyer_seq
		                  },
			          	  dataType: 'json', //서버에서 보내줄 데이터 타입
			          	  success: function( result ){
				        			        	
				          if(result.flag == 0){
							 console.log("추가성공");
							 location.href = "./pay/paySuccess.jsp";
							 
				          }else{
				             console.log("Insert Fail!!!");
				             location.href = "./pay/payFail.jsp";
				             
				          }
				        },
				        error:function(){
				          console.log("Insert ajax 통신 실패!!!");
				        }
					}) //ajax
					
				} else{//결제 실패시
					var msg = '결제에 실패했습니다';
					msg += '에러 : ' + rsp.error_msg
				}
				console.log(msg);
			});
		};
		          