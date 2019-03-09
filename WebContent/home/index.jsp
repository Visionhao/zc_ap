<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>甘肃人工审核系统1.0</title>
<script>
function getID()
{
	var parentId =  parent.topMenu.document.getElementById("top1Menu").value;
 	parent.leftFrame.document.location.href="${pageContext.request.contextPath}/view/admin/home/Do-left.action?parentCataId="+parentId;
}
</script>
</head>
<frameset  rows="105,*">
      <frame id="topMenu" name="topMenu" src="<%=request.getContextPath() %>/view/admin/home/Do-top.action" noresize="noresize" frameborder="0" onLoad="getID()"  scrolling="no">
      <frameset id="frame" cols="198,*"  scrolling="yes" />
           <frame  id="leftFrame" name="leftFrame"  marginwidth="0" marginheight="0" frameborder="0" scrolling="no" target="main"  >
           <frame src="<%=request.getContextPath() %>/view/admin/home/Do-right.action" name="main" width="580" heigth="600" marginwidth="0" marginheight="0" frameborder="0"  target="_self">
      </frameset>
      
</frameset>
</html>
