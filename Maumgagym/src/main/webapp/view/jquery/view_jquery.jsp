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
   			
    	  $('#selected_mb_seq').val( $(this).val() );
    	  console.log( $('#selected_mb_seq').val() );
    	  
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