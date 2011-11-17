# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('ul.tabs li').click ->
    $('ul.tabs li').removeClass('active')
    $(this).addClass('active')
    $('article div').hide()
    $('.'+$(this).find('a').data('div')).show()