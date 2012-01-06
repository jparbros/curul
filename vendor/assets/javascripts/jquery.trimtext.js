/* trim text v.1.0

Author: Gareth Slinn 2010.

Usage:
$(document).ready(function() {

  $('.data-txt').trimTxt();


});

Drop this in the body
<p data-len="13" class="data-txt before">This is a test. Add it will show how the result of the trim.</p>

*/

(function($){

 	$.fn.extend({ 
 		
 		trimTxt: function() {

    		return this.each(function() {
			
				var str_txt = $(this).val();
				var num_len = $(this).attr('data-len');
				var str_trim = (str_txt.substring(0,num_len));
				$(this).val(str_trim);
    		});
    	}
	});

	
})(jQuery);