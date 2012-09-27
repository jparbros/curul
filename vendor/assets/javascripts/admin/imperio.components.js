$(document).ready(function(){
    
    $('.nav-tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    })
    
    $('body').tooltip({
        selector: 'a[rel=tooltip]'
    });
});