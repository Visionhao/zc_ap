<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>投诉回溯主页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<%@ include file="../import.jsp"%>
<script type="text/javascript">
$(function(){
	$("#memus li").click(function(){
		$("#memus li").css({"border-bottom":"1px solid white","background-color":"white"});
		$("#memus li span").css({"color":"gray","font-weight":"bold"});
		$(this).css({"border-bottom":"1px solid white","background-color":"#f1f1f1"});
		$(this).children().css("color","#61B1FC");
	});
});

function auditMain(){
	var url = "${pageContext.request.contextPath}/view/rap/team/Complaintsback/ComplaintsBackAction-main.action";	
    location.href = url;	
}

function contentMain(){
	var url = "${pageContext.request.contextPath}/view/rap/team/Complaintsback/ComplaintsBackAction-contentMain.action";	
    location.href = url;	
}
</script>
</head>
<body>
<div class="total">
		<div class="head" align="center"><div style="padding-top: 10px;">投诉回溯<span style="float: right;text-align: center;font-size: 12px;margin-top:10px;margin-right:10px;font-family: fantasy;">欢迎您&nbsp;&nbsp;${memberName}</span></div></div>
		
		<div style="padding-left: 0px;margin-top: 0px;padding-top: 0px;margin-left: 0px;">
	        <ul id="memus">
		        <li style="border-bottom:1px solid white;background-color:white;cursor:pointer;"><span style="color:#61B1FC;font-weight:bold;" class="hidefocus"  hidefocus  onclick="javascript:auditMain()">审核人模式</span></li>
		        <li style="background-color:#f1f1f1;cursor:pointer;"><span style="color:#727272;font-weight:bold;" class="hidefocus"  hidefocus onclick="javascript:contentMain()">投诉内容模式</span></li>
	        </ul>
		</div>
		<br> 
		<div>
			<iframe id="rightFrame" name="rightFrame" scrolling="no"
					src="<%=request.getContextPath() %>/view/rap/team/Complaintsback/ComplaintsBackAction-auditList.action?QD_month=${QD_month}"
					width='100%' height='950px' frameborder="0"></iframe>
		</div>
		
	
</div>
</body>
</html>
