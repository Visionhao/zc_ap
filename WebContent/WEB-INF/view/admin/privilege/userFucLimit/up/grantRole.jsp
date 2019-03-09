<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>信息列表</title>
        <%@ include file="../import.jsp"%>
      <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript">
//注意设置颜色时16进制的颜色代码必需要小写
var colorOver		="#feffd5";//鼠标经过时的颜色
var colorClick	="#82befd";//鼠标单击时的颜色
var colorNone		="#ffffff";//默认的背景色
function clickSet(Obj){
		var tb=document.getElementById("table1");
		var chooseRowNo=999;
		for(var i=0;i<tb.rows.length;i++)
		{//设置所有行的背景色为默认背景色
			tb.rows[i].bgColor=colorNone;
			if(tb.rows[i]==Obj)
			{
				chooseRowNo=i;
				}
			}
		if(chooseRowNo!=999)
		{tb.rows[chooseRowNo].bgColor=colorClick;}
}
function mouseoverSet(Obj){
		var tb=document.getElementById("table1");
		var mouseoverRowNo=999;
		//清除所有的其他行的鼠标通过的颜色
		for(var i=0;i<tb.rows.length;i++)
		{
			if(tb.rows[i].bgColor==colorOver)
				tb.rows[i].bgColor=colorNone;
			if(tb.rows[i]==Obj)
			{
				mouseoverRowNo=i;
				}
			}
		if(mouseoverRowNo!=999&&tb.rows[mouseoverRowNo].bgColor!=colorClick)
		{tb.rows[mouseoverRowNo].bgColor=colorOver;}
	}
function clearColor(Obj){
	var tb=document.getElementById("table1");
	//清除所有的背景色为鼠标通过颜色的行
	for(var i=0;i<tb.rows.length;i++)
	{
		if(colorOver==tb.rows[i].bgColor)
		{
			tb.rows[i].bgColor=colorNone;
			}
		}
	}
function doEdit(){
	var ids="";
	var itemsObj = document.getElementsByName("items");
	for (var i = 0; i < itemsObj.length; i++) {
		if (itemsObj[i].checked == true) {
			ids += itemsObj[i].value + ",";
		}
	}
	ids = ids.substring(0, ids.length - 1);
	
	if(ids==""){
		alert("请授与相关角色");
		return ;
	}
    document.getElementById("roleIds").value=ids;
	jQuery("#editForm").submit();
	window.close();
	window.opener.location.reload();
}
</script>
    </head>
    <body>
	<form id="editForm" name="editForm" action="<%=request.getContextPath()%>/view/admin/privilege/userFucLimit/Up-grantRole.action">
	<input type="hidden" id="roleIds" name="roleIds" />
	<input type="hidden" id="USER_ID" name="USER_ID" value="<%=request.getAttribute("USER_ID") %>"/>
	<div style="height:400px;width:500px;overflow-x:scroll;overflow-y:scroll;word-break:break-all">
	<table class="add-info-table"  id="table1">
	<c:forEach items="${roleList}" var="role" varStatus="vs">
		<tr onclick="clickSet(this)" onmouseover="mouseoverSet(this)"
			onmouseout="clearColor(this)" >
			<% boolean flag = false; %>
								<c:forEach items="${userRoleList }" var="ur">
								<c:if test="${role.roleId == ur.roleId }">
									<td><input type="checkbox" name="items" value="${role.roleId}" checked /></td>
									<% flag = true; %>
								</c:if>
								</c:forEach>
								<% if(!flag){ %>
								<td><input type="checkbox" name="items" value="${role.roleId}" /></td>
								<% }  %>
			<td>
				${role.roleChnName }
			</td>
		</tr>
	</c:forEach>
	</table>
	</div>
	<div align="center"  class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a><a class="confirmBtn" title="保存"  id="save-btn" href="###" onclick="javascript:doEdit();">保 存</a></div>
	</form>
</body>
</html>
