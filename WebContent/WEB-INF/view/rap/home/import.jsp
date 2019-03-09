<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="<%=request.getContextPath() %>/view/rap/css/this.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script src="${pageContext.request.contextPath}/view/rap/js/this.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/view/rap/js/jquery.easing.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/view/rap/js/jquery.scrollpath.js" type="text/javascript"></script>

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
<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePicker.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePickerJavaAdaptor.js" type="text/javascript"></script>
<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/themes/base/jquery.ui.all.css"  rel="stylesheet" />
<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/themes/base/mp_base.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/external/jquery.bgiframe-2.1.2.js"></script>

<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/widget/select/jQuery.FillOptions.js"></script>
<script src="${pageContext.request.contextPath}/resource/widget/select/jQuery.CascadingSelect.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css"/>

<script  type="text/javascript">
//弹出确认提示框,需传入标题及内容
function mp_confirm_base(title,content){
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	$("#dialog-confirm").remove();
	$("body").append('<div id=dialog-confirm style=\"display:none;\" title=\"'+title+'\"><p><span class=\"ui-icon ui-icon-alert\" style=\"float:left; margin:0 7px 20px 0;\"></span>'+content+'</p></div>');  
       
}

//弹出提示框,需传入标题及内容
function mp_alter(title,content){
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	$("#dialog-message").remove();
	$("body").append('<div id="dialog-message" style="display:none" title="'+title+'"><p>'+content+'</p></div>');
	$( "#dialog-message" ).dialog({
		modal: true,
		buttons: {
			确定: function() {
				$(this).dialog( "close" );
			}
		}
	});
}
//弹出的层
function showdialogComponent(title,width,height,html){
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	 $("#dialogComponentMessage").remove();
	 $("body").append("<div id='dialogComponentMessage' style='display:none;text-align: center;'>"+html+"</div>");
	 $("#dialogComponentMessage").dialog({
			autoOpen : false,
			show : "blind",
			hide : "blind",
			modal : true,
			width : width,
			height : height,
			title : title
	});
	 $("#dialogComponentMessage" ).dialog( "open" );
}

//取消
function componentCancel(){
	$("#dialogComponentMessage").dialog('close');
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	$("#dialogComponentMessage").remove();
	
}

//弹出窗口页面,,需传入URL,名称,宽度,高度
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

//刷新方法
function refresh(iframeId){
	 document.getElementById(iframeId).contentWindow.location.reload(true);
}
</script>


	