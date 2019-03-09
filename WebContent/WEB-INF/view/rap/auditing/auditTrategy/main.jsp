<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>审核策略配置主页面</title>
<%@ include file="import.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
</head>
<body>
<div class="total">
<div class="head" align="center"><div style="padding-top: 10px;">审核策略配置<span style="float: right;text-align: center;font-size: 12px;margin-top:10px;margin-right:10px;font-family: fantasy;">欢迎您&nbsp;&nbsp;${memberName}</span></div></div>
<div style="width: 100%;height: 30px;margin-top: 15px;float: left;border-bottom: 1px solid gray;margin-left: 0px;"><span style="margin-left: 20px;font-weight: bold;font-size: 16px;">选项</span></div>
<div>
	<iframe id="rightFrame" name="rightFrame"
					src="<%=request.getContextPath() %>/view/rap/auditing/auditTrategy/AuditTrategyAction-list.action"
					width='100%' height='600' frameborder="0"></iframe>
</div>
</div>
</body>
</html>
