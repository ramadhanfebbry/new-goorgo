// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require ckeditor/init
//= require_tree .
$(function(){

searchProduct = function (){
  var q = $("#search").val()

  if(q.length == 0){
  	alert('asdd')
    return false;
  }else{
  	alert('asdd2')
  	document.location = "/result?q="+q
  	return true;
  }
}

$("#search-product").submit(function(){
  searchProduct()
})

$(".icon-submit-search").click(function(){
  searchProduct();
})

$("#u1300").click(function(){document.location='/'})	
})
