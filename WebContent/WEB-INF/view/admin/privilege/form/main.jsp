<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="import.jsp"%>
<title>表单管理</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<frameset id="upDownFrame" rows="*,7%"  scrolling="no" frameborder="1" border="3"  bordercolor = "#d9d9d9" >
	<frame name="top" src="${pageContext.request.contextPath}/view/admin/privilege/form/Main-upMain.action"  marginwidth="5" marginheight="5" /> 
	<frame id="mainDown" name="mainDown" SCROLLING="NO" SRC="${pageContext.request.contextPath}/view/admin/privilege/form/Main-downMain.action" >  
</frameset>  
<body>
</body>
</html>