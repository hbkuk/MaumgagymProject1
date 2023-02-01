<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<script>
        var i = 0;
        $('.bi-heart').on('click',function(){
            if(i==0){
                $(this).attr('class','bi-heart-fill');
                i++;
            }else if(i==1){
                $(this).attr('class','bi-heart');
                i--;
            }

        });
    </script>
    
    <script>
    
   		$("select[name=memberShip]").change(function(){
   			
    	 console.log( $("#memberShip option:checked").text() );
    	  
    	  $('#confirmMebership').text( "선택하신 회원권은 " + $("#memberShip option:checked").text() +" 입니다. 정말로 결제하시겠습니까?" );
    	  
    	});
   		
    </script>
    
    <script>
    
    
    $('#payBtn').click(function(){
    	
    	if( document.getElementById("memberShip").selectedIndex == 0 ) {
    	    alert("회원권을 선택해주세요.");
    	    return false;
    		}
    	
    	$('#myModal').modal("show");
    });
    
    
   		
    </script>

  
  	<script>
	function change(index) {
		
	   if( index == "1개월권" )
		   {
	       view1.style.display = "inline"
		   view2.style.display = "none"
		   view3.style.display = "none"
		   view4.style.display = "none"
	
		   }
	   if( index == "3개월권" )
	      {
	       view1.style.display = "none"
		   view2.style.display = "inline"
		   view3.style.display = "none"
		   view4.style.display = "none"
	
		   }
	   if( index == "6개월권" )
	      {
	       view1.style.display = "none"
		   view2.style.display = "none"
		   view3.style.display = "inline"
		   view4.style.display = "none"
		   }
	   if( index == "12개월권" )
	      {
	       view1.style.display = "none"
		   view2.style.display = "none"
		   view3.style.display = "none"
		   view4.style.display = "inline"
		   }
	   	}
	</script>
	