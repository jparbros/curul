$(document).ready(function(){
    
    // DataTable initialization
    $('#datatable').dataTable({
        "sPaginationType": "full_numbers"
    });    
   
   	//delete one row
	$('.table a.delete').click(function(){
		if(confirm('Delete row?')) $(this).parents('tr').fadeOut(function(){ 
            $(this).remove();
		});
		return false;
	});  
    
    // Check all checkboxes in table
    $('.table .check_all').click(function(){
        var pt  = $(this).parents('table');
        var ch  = pt.find('tbody input[type=checkbox]');
        var cha = pt.find('input.check_all');
        if($(this).is(':checked')){
            ch.each(function(){
                $(this).attr('checked',true);    
            });
            cha.each(function(){
                $(this).attr('checked',true);    
            });
        } else {
            ch.each(function(){
                $(this).attr('checked',false);    
            });
            cha.each(function(){
                $(this).attr('checked',false);    
            });
        }        
    });  
});