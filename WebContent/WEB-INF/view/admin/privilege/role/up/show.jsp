<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>查看角色信息</title>
	<script >
		function doClose(){
			return this.window.close();
		}
	</script>
    </head>
    <body>
    <form action="#" method="post">
    <input type="hidden" name="Role!roleId" id="Role!roleId"  value="<c:out value="${Role.roleId }"></c:out>" /> 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看角色信息</th>
        		</tr>
        		<tr>
        			<td class="word">角色名称</td>
        			<td id="roleChnName"><c:out value="${Role.roleChnName }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">角色类型</td>
        			<td id="roleType"><c:out value="${type }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">状态</td>
        			<td id="state"><c:out value="${state }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">说明</td>
        			<td id="roleRemark"><c:out value="${Role.roleRemark }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">创建时间</td>
        			<td ><fmt:formatDate value="${Role.createDate }" pattern="yyyy-MM-dd" type="date"></fmt:formatDate>&nbsp;</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关  &nbsp;闭</a></div>
      </form>
    </body>
</html>
