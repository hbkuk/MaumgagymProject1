<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<script>
        var i = 0;
        $('i').on('click',function(){
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
	function change(style) {
	    
	   if( style == "selectBox01" )
		   {
	       view1.style.display = "inline"
		   view2.style.display = "none"
		   view3.style.display = "none"
		   view4.style.display = "none"
	
		   }
	   if( style == "selectBox02" )
	      {
	       view1.style.display = "none"
		   view2.style.display = "inline"
		   view3.style.display = "none"
		   view4.style.display = "none"
	
		   }
	   if( style == "selectBox03" )
	      {
	       view1.style.display = "none"
		   view2.style.display = "none"
		   view3.style.display = "inline"
		   view4.style.display = "none"
		   }
	   if( style == "selectBox04" )
	      {
	       view1.style.display = "none"
		   view2.style.display = "none"
		   view3.style.display = "none"
		   view4.style.display = "inline"
		   }
	   	}
	</script>