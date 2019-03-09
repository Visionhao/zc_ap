//******************

$(function(){
//		   

  //**栏目tab标签**//		   
 //$(".tab2-nav li a:first").addClass("selected");
 $(".tab2-nav li a").click(function(){
  var index= $(".tab2-nav li a").index(this);
  $(this).addClass("selected").parent().siblings().children("a").removeClass("selected");
  $("#tab2-content .list").eq(index).fadeIn().siblings().hide();
 })
 
 
});

