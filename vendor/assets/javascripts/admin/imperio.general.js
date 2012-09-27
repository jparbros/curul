$(document).ready(function(){
   
    $(window).resize(function(){
        if($(this).width() < 1024) {
            iconmenu();
            if($(window).width() < 570) {
                $('.table').each(function(){
                    if($(this).find('.table-wrapper').size() == 0) {
                        $(this).wrap('<div class="table-wrapper"></div>');        
                    }
                });                
            }
        } else {
            fullmenu();
        }
    });

    if($(window).width() < 1024) {
        iconmenu();
        if($(window).width() < 570) {
            $('.table').each(function(){
                if($(this).find('.table-wrapper').size() == 0) {
                    $(this).wrap('<div class="table-wrapper"></div>');        
                }
            });                
        }
    } else {
        fullmenu();
    }    
    
    // Sticky naviagiot
    $(window).scroll(function(){
        var el = $('.leftmenu > ul'); 
        if($(window).width() > 479) {
            if ($(this).scrollTop() > 80){
                el.css({'position':'fixed','top':'10px','width':'22.35%'});
            } else {
                el.css({'position': 'relative', 'top': '0','width':'auto'});
            }
        } else {
            if ($(this).scrollTop() > 130){
                el.css({'position':'fixed','top':'10px','width':'22.35%'});
            } else {
                el.css({'position': 'relative', 'top': '0','width':'auto'});
            }
        }
    });
   
    // Navigation submenus
    $('.leftmenu a').click(function(e){
        if($(this).siblings('ul').size() == 1){
            e.preventDefault();
            var submenu = $(this).siblings('ul');
            if($(this).hasClass('open')) {
                if($(this).parents('.leftmenu').hasClass('lefticon')) {
                    submenu.fadeOut();
                } else {
                    submenu.slideUp('fast');
                }
                $(this).removeClass('open');
            } else {
                if($(this).parents('.leftmenu').hasClass('lefticon')) {
                    submenu.fadeIn();
                } else {
                    submenu.slideDown('fast');
                }
                $(this).addClass('open');
            }
        }
    });
    
    // Bind the tooltips to menu
    $('.leftmenu').tooltip({
      selector: "a[rel=tooltip]",
      placement: 'right'
    });

    $('body').tooltip({
       selector: '.tooltip' 
    });
    $('.tooltip-left').tooltip({
       placement: 'left'
    });
    $('.tooltip-right').tooltip({
       placement: 'right'
    });
    $('.tooltip-top').tooltip({
       placement: 'top'
    });
    $('.tooltip-bottom').tooltip({
        placement: 'bottom'
    });
    
    //Prettyprint
    window.prettyPrint && prettyPrint()
    
    // Iphone style radio rand checkboxes
    $(".cb-enable").click(function(){
		var parent = $(this).parents('.switch');
		$('.cb-disable',parent).removeClass('selected');
		$(this).addClass('selected');
		$('.checkbox',parent).attr('checked', true);
	});
	$(".cb-disable").click(function(){
		var parent = $(this).parents('.switch');
		$('.cb-enable',parent).removeClass('selected');
		$(this).addClass('selected');
		$('.checkbox',parent).attr('checked', false);
	});
    
    var placeholder = $('#search input').attr('placeholder');
    $('#search input').focus(function(){
        if($(this).val() == placeholder) {
            $(this).val('');
        }
    }).blur(function(){
        if($(this).val() == '') {
            $(this).val(placeholder);
        }
    });
    
    // Functions...
    function iconmenu(){
        $('.leftmenu').removeClass('span3').addClass('lefticon').addClass('span1');
        $('.leftmenu > ul > li > a').each(function(){
            atitle = $(this).text();
            $(this).attr({'rel':'tooltip','title':atitle});
        });
        $('#content').removeClass('span9').addClass('span11');
    }
    
    function fullmenu(){
        $('.leftmenu').removeClass('span1').removeClass('lefticon').addClass('span3');
        $('.leftmenu > ul > li > a').each(function(){
            $(this).attr({'rel':'','title':''});
        });
        $('#content').removeClass('span11').addClass('span9'); 
    }
});