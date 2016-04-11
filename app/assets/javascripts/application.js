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
//= require jquery.soulmate
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .


var toggleDiv;
var showModal;
var attributes_for_modal;

toggleDiv = function (element_to_hide,element_to_show,clicked_elem){
    element_to_hide.setAttribute('style','display:none'); 
  element_to_show.setAttribute('style','display:block');
  clicked_elem.parent().siblings().find('a').removeClass('header-active');
  clicked_elem.addClass('header-active');
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

    if($("#GrabTXT").is(":visible") == true ){
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
     $('.boxgrid.slideright').hover(function(){
            $(".cover", this).stop().animate({left:'325px'},{queue:false,duration:300});
        }, function() {
            $(".cover", this).stop().animate({left:'0px'},{queue:false,duration:300});
        });
});

$(function() {
// Highlight the top nav as scrolling occurs
  $('body').scrollspy({
      target: '.navbar-fixed-top'
  })

  // Closes the Responsive Menu on Menu Item Click
  $('.navbar-collapse ul li a').click(function() {
      $('.navbar-toggle:visible').click();
  });

});

var ready = function(){
  var render, select;

  render = function(term, data, type) {
    return term;
  }

  select = function(term, data, type){
    // populate our search form with the autocomplete result
    $('#search').val(term);
   
    // hide our autocomplete results
    $('ul#soulmate').hide();

    // populate our search form with the autocomplete result
    $('#book_query').val(term);
   
    // hide our autocomplete results
    $('ul#book_query').hide();

    // then redirect to the result's link 
    // remember we have the link in the 'data' metadata
    return window.location.href = data.link
  }

  $('#search').soulmate({
    url: '/autocomplete/search',
    types: ['locations'],
    renderCallback : render,
    selectCallback : select,
    minQueryLength : 2,
    maxResults     : 5
  });


  $('#books_search').soulmate({
    url: '/autocomplete/search',
    types: ['books'],
    renderCallback : render,
    selectCallback : select,
    minQueryLength : 2,
    maxResults     : 5
  });


}
// when our document is ready, call our ready function
$(document).ready(ready);

// if using turbolinks, listen to the page:load event and fire our ready function
$(document).on('page:load', ready);
