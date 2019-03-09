<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- common start -->
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<link href="<%=request.getContextPath() %>/view/rap/css/complaint/complaint.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/view/rap/js/Complaintsback/Complaintsback.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/view/rap/js/this.js" type="text/javascript"></script>

<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/themes/base/jquery.ui.all.css"  rel="stylesheet" />
<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/themes/base/mp_base.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/external/jquery.bgiframe-2.1.2.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.core.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.widget.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.mouse.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.button.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.draggable.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.position.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.resizable.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.dialog.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.effect.js"></script>
<script src="${pageContext.request.contextPath}/view/report/exFunction.js"></script> 


<script  type="text/javascript">
function mp_confirm_base(title,content){
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	$("#dialog-confirm").remove();
	$("body").append('<div id=dialog-confirm style=\"display:none;\" title=\"'+title+'\"><p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>'+content+'</p></div>');  
       
}
//弹出提示框,需传入标题及内容
function mp_alter(title,content){
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	$("#dialog-message").remove();
	$("body").append('<div id="dialog-message" style="display:none;text-align:center" title="'+title+'"><p>'+content+'</p></div>');
	$( "#dialog-message" ).dialog({
		modal: true,
		buttons: {
			确定: function() {
				$(this).dialog( "close" );
			}
		}
	});
	
}
//弹出提示框,需传入标题及内容
function mp_alter3(title,content,funname){
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	$("#dialog-message").remove();
	$("body").append('<div id="dialog-message" style="display:none;text-align:center" title="'+title+'"><p>'+content+'</p></div>');
	$( "#dialog-message" ).dialog({
		modal: true,
		buttons: {
			'确定': function() {
				$(this).dialog( "close" );
				funname();
			}
		}
	});
}
function condition_view(title,content){
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	$("#dialog-condition").remove();
	$("body").append('<div id=dialog-condition style=\"display:none;\" title=\"'+title+'\"><p>'+content+'</p></div>');  
     
}	


function openwindow(url,name,iWidth,iHeight)  
{  
    var url;                             //转向网页的地址;  
    var name;                            //网页名称，可为空;  
    var iWidth;                          //弹出窗口的宽度;  
    var iHeight;                         //弹出窗口的高度;  
    //获得窗口的垂直位置  
    var iTop = (window.screen.availHeight-30-iHeight)/2;         
    //获得窗口的水平位置  
    var iLeft = (window.screen.availWidth-10-iWidth)/2;            
    window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no');  
}  

function refresh(iframeId){
	 document.getElementById(iframeId).contentWindow.location.reload(true);
}

function getLocalDate(){
	var myDate = new Date();
	var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
	var month = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
	var date = myDate.getDate();        //获取当前日(1-31)
	
	return year+"-"+month+"-"+date
	
}
</script>
<!-- common end -->




	