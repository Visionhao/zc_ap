<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<%@ include file="import.jsp"%>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>查看功能信息</title>
	<script >
		function doClose(){
			return this.window.close();
		}
	</script>
    </head>
    <body>
    <form action="#" method="post">
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看功能信息</th>
        		</tr>
        		<tr>
        			<td class="word">资源编号</td>
        			<td >
        				<c:out value="${FucResource.fusId}"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">中文名称</td>
        			<td ><c:out value="${FucResource.chnName}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">英文名称</td>
        			<td ><c:out value="${FucResource.engName}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">资源类型</td>
        			<td id="type">${type}&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">资源地址</td>
        			<td ><c:out value="${FucResource.url}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">状态</td>
        			<td id="isactive">${isactive}&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">跳转类型</td>
        			<td ><c:out value="${FucResource.jumpType}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">映射路径</td>
        			<td ><c:out value="${FucResource.mappingForward}"></c:out>&nbsp;</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关  &nbsp;闭</a></div>
      </form>
    </body>
</html>