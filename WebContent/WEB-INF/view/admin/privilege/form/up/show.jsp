<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>查看表单信息</title>
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
        			<th colspan="2">查看表单信息</th>
        		</tr>
        		<tr>
        			<td class="word">表单编号</td>
        			<td ><c:out value="${Form.formId }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">表单名称</td>
        			<td ><c:out value="${Form.formName }"></c:out>&nbsp; </td>
        		</tr>
        		<tr>
        			<td class="word">功能名称</td>
        			<td ><c:out value="${FucResource.chnName}"></c:out>&nbsp; </td>
        		</tr>
        		<tr>
        			<td class="word">类名</td>
        			<td >
        				<c:out value="${Form.classname}"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">资源路径</td>
        			<td >
        				<c:out value="${Form.formUrl }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">描述</td>
        			<td ><c:out value="${Form.description }"></c:out>&nbsp;  </td>
        		</tr>
        		<tr>
        			<td class="word">帮助</td>
        			<td ><c:out value="${Form.help }"></c:out>&nbsp; </td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关  &nbsp;闭</a></div>
      </form>
    </body>
</html>