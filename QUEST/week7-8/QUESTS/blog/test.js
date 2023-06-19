"use strict";

$(document).ready(function(){
  $('.open').on('click', function(){
    $('.modal').toggle();
  });
  $('.cover').on('click', function(){
    $('.modal').toggle();
  });
  $('.close').on('click', function(e){
    $('.modal').toggle();
    e.stopPropagation();
  });
  $('.window').on('click', function(e){
    e.stopPropagation();
  });
});