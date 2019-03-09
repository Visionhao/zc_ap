<html>
<head></head>
	<frameset cols="173,*" scrolling="no" frameborder="1" border="3" >
		<frame name="leftTree"
			src="<%=request.getContextPath()%>/view/admin/privilege/role/Down1-treeView.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>" />
		<frame name="right" width='99%' height='450' />
	</frameset>
</html>