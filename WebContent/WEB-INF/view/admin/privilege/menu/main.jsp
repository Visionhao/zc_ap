<html>
<head></head>
	<frameset cols="173,*" scrolling="no" frameborder="1" border="3" >
		<frame name="leftTree"
			src="<%=request.getContextPath()%>/view/admin/privilege/menu/Do-treeView.action" />
		<frame name="right" width='99%' height='450' src="<%=request.getContextPath() %>/view/admin/privilege/menu/Do-addPage.action?parentId=0000" />
	</frameset>
</html>