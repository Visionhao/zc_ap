/**
 * Company:     北京众成联信信息技术有限公司
 * js描述 :      数据门户静态页面js
 * @since:      2015-03-18
 * @author      侯烽泰
 * @serial:     2014-03-18 
 */

/**
 * 进行导航栏点击后改变背景的方法。
 * 
 **/
function setNavBg(){
	$('.nav ul li a').click(function(){
		var a = $('.nav ul li a');
		$("#first").removeClass("first").addClass("first_h");
		$("#report").removeClass("report_h").addClass("report");
		$("#port").removeClass("port_h").addClass("port");
		$("#content").removeClass("cont_h").addClass("cont");
		$("#complain").removeClass("complain_h").addClass("complain");
		$("#audit").removeClass("audit_h").addClass("audit");
		
		for(var i = 0;i < a.length ; i++){
			$($('.nav ul li a p')[i]).removeClass("link-top");
		}
		if(this.id=="first")    $(this).removeClass("first_h").addClass("first");
		if(this.id=="report")   $(this).removeClass("report").addClass("report_h");
		if(this.id=="port")     $(this).removeClass("port").addClass("port_h");
		if(this.id=="content")  $(this).removeClass("cont").addClass("cont_h");
		if(this.id=="complain") $(this).removeClass("complain").addClass("complain_h");
		if(this.id=="audit")    $(this).removeClass("audit").addClass("audit_h");
		
		$($(this).find("p")).addClass("link-top");
	});
};

/**
 * 进行首页内容列表特效动画设置的方法。
 * 
 **/
function setMouse(){
	$('.box').mouseover(function(){
		$($(this).find("p.mass")).show();
		$($(this).find("p.mass")).stop().animate({"bottom":"30px","height":"150px"}, 500); 
		
	});
	$('.box').mouseout(function(){
		$($(this).find("p.mass")).stop().animate({"bottom":"0px","height":"0px"}, 500); 
	});
};