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

  $('#login-trigger').click(function(){
	$('#login-content').slideToggle(function(){
    	$('#username').focus();
	}); // slides up/down the login form
    
    $(this).toggleClass('active');          
    
    // If login-trigger has 'active' class, change the direction of the arrow
    	// &#x25B2 represents downward arrow, &#x25BC represents upward arrow
    if ($(this).hasClass('active')) 
    	$(this).find('span').html('&#x25B2;')
    else $(this).find('span').html('&#x25BC;')
    })

});

$(function(){ $(document).foundation(); });

