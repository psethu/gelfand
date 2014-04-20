// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// MENTION this: if user doesnt include the @ in the email, then a cool notification pops up
$(document).ready(function(){

 // for login dropdown in Navbar
  $('#login-trigger').click(function(){
	$('#login-content').slideToggle(function(){
    	$('#email').focus();
	}); 
    
    $(this).toggleClass('active');          
        
    if ($(this).hasClass('active')) 
    	$(this).find('span').html('&#x25B2;')
    else $(this).find('span').html('&#x25BC;')
    })

  // Changes cursor to pointer for:
  	// gelfand block in title of Nav bar
  $('.name').css( 'cursor', 'pointer' );

  $('.name').click(function() {
  		window.location = ('/');
  });
  
});

$(function(){ $(document).foundation(); });

