<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="import.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/view/example/template/upDownList/tabSelect.js">
</script>
</head>
<body>
<div class="tab-wrap">
				<div class="dx_center">
					<ul class="tab2-nav">
						<li><a href="#" class="selected">操作信息</a></li>
					</ul>
				</div>
				<div id="tab2-content">
					
					<div id="downListDiv" class="list none" >
						<div class="code-wrap">
							<iframe id="mainFrame" name="mainFrame"
								src="<%=request.getContextPath()%>/view/admin/privilege/form/Down1-main.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>"
								width='100%' height='400' frameborder="0"></iframe>
						</div>
					</div>
					<div id="downListDiv2"  class="list none" style="display: none;">
						<div class="code-wrap"></div>
					</div>
				</div>
			</div>
</body>
</html>