<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="import.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/resource/template/upDownList/tabSelect.js">
</script>
</head>
<body>
<%
	//返回页面时,判断用户已经选择哪个标签
	String div = request.getParameter("divSelected");
	request.setAttribute("divSelected", div);
%>
<div class="tab-wrap">
				<div class="dx_center">
					<ul class="tab2-nav">
						<c:if test="${requestScope.divSelected == 'downEditDiv' || empty requestScope.divSelected }">
						<li><a href="###" class="selected">功能资源</a></li>
						<li><a href="###" class="">已授权用户</a></li>
						</c:if>
						<c:if test="${requestScope.divSelected == 'downListDiv' }">
						<li><a href="###" class="">功能资源</a></li>
						<li><a href="###" class="selected">已授权用户</a></li>
						</c:if>
					</ul>
				</div>
				<div id="tab2-content">
					<c:if test="${requestScope.divSelected == 'downEditDiv' || empty requestScope.divSelected }">
					<div id="downEditDiv" class="list" style="display: block;">
						<iframe id="downEditFrame" name="downEditFrame"
							src="<%=request.getContextPath()%>/view/admin/privilege/role/Down1-main.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>"
							width='100%' height='400' frameborder="0"></iframe>
					</div>
					<div id="downListDiv" class="list none" style="display: none;">
						<div class="code-wrap">
							<iframe id="mainFrame" name="mainFrame"
								src="<%=request.getContextPath()%>/view/admin/privilege/role/Down2-main.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>"
								width='100%' height='400' frameborder="0"></iframe>
						</div>
					</div>
					<div id="downListDiv2"  class="list none" style="display: none;">
						<div class="code-wrap"></div>
					</div>
					</c:if>
					<c:if test="${requestScope.divSelected == 'downListDiv' }">
					<div id="downEditDiv" class="list" style="display: none;">
						<iframe id="downEditFrame" name="downEditFrame"
							src="<%=request.getContextPath()%>/view/admin/privilege/role/Down1-main.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>"
							width='100%' height='400' frameborder="0"></iframe>
					</div>
					<div id="downListDiv" class="list none" style="display: block;">
						<div class="code-wrap">
							<iframe id="mainFrame" name="mainFrame"
								src="<%=request.getContextPath()%>/view/admin/privilege/role/Down2-main.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>"
								width='100%' height='400' frameborder="0"></iframe>
						</div>
					</div>
					<div id="downListDiv2" class="list none" style="display: none;">
						<div class="code-wrap"></div>
					</div>
					</c:if>
				</div>
			</div>
</body>
</html>