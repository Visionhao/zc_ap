<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>查看参数代码</title>
	<script type="text/javascript">
		function doClose(){
			return this.window.close();
		}
		$(function(){
		 	if(document.getElementById("status").innerHTML=='01'){
		 		document.getElementById("status").innerHTML='启用';
		 	}
		 	if(document.getElementById("status").innerHTML=='02'){
		 		document.getElementById("status").innerHTML='停用';
		 	}
		});
	</script>
    </head>
    <body>
    <form action="#" method="post">
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看参代码数</th>
        		</tr>
        		<tr>
        			<td class="word">代码标识</td>
        			<td ><c:out value="${CommonCode.rowId }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">编号</td>
        			<td ><c:out value="${CommonCode.codeNum}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">类别编号</td>
        			<td ><c:out value="${CommonCode.commonType.typeCode }"></c:out>&nbsp;</td>
        		</tr> 
        		<tr>
        			<td class="word">名称</td>
        			<td ><c:out value="${CommonCode.userShowName}"></c:out>&nbsp;</td>
        		</tr>
        		 <tr>
        			<td class="word">简称</td>
        			<td ><c:out value="${CommonCode.shortName}"></c:out>&nbsp;</td>
        		</tr> 
        		<tr>
        			<td class="word">助记码</td>
        			<td ><c:out value="${CommonCode.mnemonicCode}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">状态</td>
        			<td id="status"><c:out value="${CommonCode.status }"></c:out></td>
        		</tr>
        		<tr>
        			<td class="word">上级代码编号</td>
        			<td >
	        			<c:out value="${CommonCode.parentCodeNum }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">创建日期</td>
        			<td >
        				<fmt:formatDate value="${CommonCode.createDate }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;
        			</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关&nbsp;闭</a></div>
      </form>
    </body>
</html>

