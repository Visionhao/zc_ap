<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="import.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/view/example/template/upDownList/tabSelect.js">
</script>
<script type="text/javascript">
function footShow(){
	parent.document.getElementById("upDownFrame").rows="6%,*";
}
function midShow(){
	parent.document.getElementById("upDownFrame").rows="50%,*";
}
function topShow(){
	parent.document.getElementById("upDownFrame").rows="*,7%";
}
</script>
</head>
<body>
	<div class="dx_center">
		<ul class="tab2-nav">
			<li><a href="#" class="selected">用户信息</a></li>
			<li><a href="#" class=""></a></li>
		</ul>
		<div style="float:right;"><a id="up"  href="javascript:footShow()" title="向上" class="one-iocn">&nbsp;</a>
			&nbsp;&nbsp;&nbsp;<a id="down"  href="javascript:midShow()" title="居中" class="three-iocn">&nbsp;</a>
			&nbsp;&nbsp;&nbsp;<a id="down"  href="javascript:topShow()" title="向下" class="two-iocn">&nbsp;</a></div>
	</div>
	<iframe id="upMainFrame" name="upMainFrame"
		src="<%=request.getContextPath()%>/view/admin/privilege/userFucLimit/Up-main.action" 
		width='99%' height='450' frameborder="0"></iframe>
</body>
</html>