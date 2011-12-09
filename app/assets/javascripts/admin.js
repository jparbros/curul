// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-alert
//= require jquery.tokeninput
//= require_tree ./admin

$(document).ready(function(){
  $(".alert-message .close").click(function(){
    $(".alert-message").alert('close');
  });
  
  $("#initiative_topic_tokens").tokenInput("/admin/topics.json", {
      theme: "facebook",
      prePopulate: $("#initiative_topic_tokens").data("pre"),
      crossDomain: false
  });
  
  $("#initiative_presented_by_token").tokenInput("/admin/representatives.json", {
      theme: "facebook",
      prePopulate: $("#initiative_presented_by_token").data("pre"),
      crossDomain: false
  });
  
  $("#representative_commission_tokens").tokenInput("/admin/representatives.json", {
      theme: "facebook",
      prePopulate: $("#representative_commission_tokens").data("pre"),
      crossDomain: false
  });
});