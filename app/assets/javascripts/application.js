// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .


var toggleDiv;
var showModal;
var attributes_for_modal;

toggleDiv = function (options=[],element_to_show){
  $.each(options, function( index, value ) {
    value.setAttribute('style','display:none');
    });
	
	element_to_show.setAttribute('style','display:block');
  

}

showModal = function (type,isbn,path){
	
  switch(type) {
    case "share book":
        attributes_for_modal(type,isbn,path);
	     $('#add_location_modal').modal('show');
       break;
    case "grab":
        $('#grab_modal').modal('show');
        break;
	
}
}

attributes_for_modal = function(type,isbn,path){

	$('#add_location_modal').on('show.bs.modal', function (event) {
  //var button = $(event.relatedTarget) // Button that triggered the modal
  //var recipient = button.data('whatever') // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this)
  modal.find('.modal-title').text(type)
  modal.find('form').attr('action',path)
  modal.find('#isbn').val(isbn);
  
  // switch(type) {
  //   case "login":
  //       modal.find('.modal-body').html('<%= escape_javascript(render(:partial => "/users/sessions/form")) %>');
  //       break;
  //   case 'sign up':
  //       modal.find('.modal-body').html("<%= escape_javascript(render(:partial => '/users/registrations/form')) %>");
  //       break;
  //   case 'share book':
  //   	modal.find('.modal-body').html(recipient);
  //   break;
  // } 
  
})
} 


$.fn.stars = function() {
    return $(this).each(function() {
        var val = parseFloat($(this).html());
        var size = Math.max(0, (Math.min(5, val))) * 16;
        var $span = $('<span />').width(size);
        $(this).html($span);
    });
}


$(function() {
$('.mainlinks a').on('click',function(){
  //alert();
    $(this).addClass('active').siblings().removeClass('active');

    if($("#GrabTXT").is(":visible") ==true ){
   /// alert();
    $('#GrabTXT').hide();
    $('#GiveTXT').show();
  }
  else{

    $('#GiveTXT').hide();
    $('#GrabTXT').show();
  }

});

 $('.dropdown-toggle').on('click',function(){
      $('.dropdown-menu').slideToggle('400');
  });

$(window).scroll(function() {
if ($(this).scrollTop() > 1){  
    $('nav').addClass("navbar-shrink");
  }
  else{
    $('nav').removeClass("navbar-shrink");
  }
});

if (screen.width < 767) {
   $('.navbar-toggle').on('click',function(){
      $('.navbar-nav').slideToggle('400');
    });

}
$(window).resize(function() {
  $('.navbar-toggle').on('click',function(){
      $('.navbar-nav').slideToggle('400');
    });
});

});


$(document).ready(function () {
    $(".tile").height($("#tile1").width());
    $(".carousel").height($("#tile1").width());
    $(".item").height($("#tile1").width());

    $(window).resize(function () {
        if (this.resizeTO) clearTimeout(this.resizeTO);
        this.resizeTO = setTimeout(function () {
            $(this).trigger('resizeEnd');
        }, 10);
    });

    $(window).bind('resizeEnd', function () {
        $(".tile").height($("#tile1").width());
        $(".carousel").height($("#tile1").width());
        $(".item").height($("#tile1").width());
    });
});