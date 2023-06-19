"use strict";

$(document).ready(function(){
  $('.sign-up').on('click', function(){
    $('.modal').toggle();
    $('body').toggleClass('disable-scroll');
  });
  $('.cover').on('click', function(){
    $('.modal').toggle();
    $('body').toggleClass('disable-scroll');
  });
  $('.close').on('click', function(e){
    $('.modal').toggle();
    $('body').toggleClass('disable-scroll');
    e.stopPropagation();
  });
  $('.window').on('click', function(e){
    e.stopPropagation();
  });
});