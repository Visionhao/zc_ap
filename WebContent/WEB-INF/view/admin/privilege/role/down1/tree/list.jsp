<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>信息列表</title>
        <%@ include file="import.jsp"%>
        <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
      <link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
      <link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
      <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
	<script type="text/javascript">
	function doEdit(){
		var ids="";
		var itemsObj = document.getElementsByName("items");
		for (var i = 0; i < itemsObj.length; i++) {
			if (itemsObj[i].checked == true) {
				ids += itemsObj[i].value + ",";
			}
		}
		ids = ids.substring(0, ids.length - 1);
	    document.getElementById("ids").value=ids;
		jQuery("#editForm").submit();
		
		window.parent.close();
		window.close();
		window.opener.location.reload();
	}
	</script>
    </head>
    <body>
	<form id="editForm" name="editForm" action="<%=request.getContextPath()%>/view/admin/privilege/role/Down1-editFormList.action">
	<input type="hidden" id="ids" name="ids" />
	<input type="hidden" id="ROLE_ID" name="ROLE_ID" value="<%= request.getAttribute("ROLE_ID") %>"/>
	<c:forEach items="${formList}" var="form" varStatus="vs">
		<tr>
			<td>
				<fieldset style="padding:10px;    margin:10px;    width:270px;    color:#333;     border:#06c dashed 1px;">
					<legend>${form.formName }</legend>
					<table name="table" >
						<tr>
							<td align="center"></td>
							
							<td align="center">功能名称</td>
						</tr>
						<c:forEach items="${form.formAccesses}" var="formAccesses">
							<tr>
							<% boolean flag = false; %>
								<c:forEach items="${formAccPriIds }" var="p">
								<c:if test="${formAccesses.formAccessId == p.formAccessId }">
									<td><input type="checkbox" name="items" value="${formAccesses.formAccessId}" checked /></td>
									<% flag = true; %>
								</c:if>
								</c:forEach>
								<% if(!flag){ %>
								<td><input type="checkbox" name="items" value="${formAccesses.formAccessId}" /></td>
								<% }  %>
							
								<td align="center">${formAccesses.access.accessChnName}</td>
							</tr>
						</c:forEach>
					</table>
				</fieldset>
			</td>
	</c:forEach>
	<div align="center"  class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a><a class="confirmBtn" title="保存"  id="save-btn" href="###" onclick="javascript:doEdit();">保 存</a></div>
	</form>
</body>
    
</html>
