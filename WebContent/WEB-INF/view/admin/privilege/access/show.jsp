<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>查看操作键信息</title>
	<script >
		function doClose(){
			return this.window.close();
		}
	</script>
    </head>
    <body>
    <form action="#" method="post">
    <input type="hidden" name="Access!accessId" id="accessId"  value="<c:out value="${Access.accessId }"></c:out>" /> 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看操作键信息</th>
        		</tr>
        		<tr>
        			<td class="word">操作键编号</td>
        			<td >
        				<c:out value="${Access.accessId }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">中文名称</td>
        			<td >
        				<c:out value="${Access.accessChnName }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">英文名称</td>
        			<td >
	        			<c:out value="${Access.accessEngName}"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">动作路径</td>
        			<td >
        				<c:out value="${Access.actionUrl }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">类型</td>
        			<td id="type"><c:out value="${AccessType }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">序号</td>
        			<td ><c:out value="${Access.accessNo }"></c:out>&nbsp;</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关  &nbsp;闭</a></div>
      </form>
    </body> 
</html>
