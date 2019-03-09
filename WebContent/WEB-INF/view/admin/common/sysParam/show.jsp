<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>查看系统参数</title>
		<script type="text/javascript">
		function doClose(){
			return this.window.close();
		}
		$(function(){
		 	if(document.getElementById("paramType").innerHTML=='01'){
		 		document.getElementById("paramType").innerHTML='系统参数';
		 	}
		 	if(document.getElementById("paramType").innerHTML=='02'){
		 		document.getElementById("paramType").innerHTML='业务参数';
		 	}
		 	if(document.getElementById("paramType").innerHTML=='03'){
		 		document.getElementById("paramType").innerHTML='初始化参数';
		 	}
		});
		</script>
    </head>
    <body>
    <form action="#" method="post">
     <input type="hidden" name="CommonParam!paramId" id="CommonParam!paramId"  value="<c:out value="${CommonParam.paramId}"></c:out>" />  
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看系统参数</th>
        		</tr>
        		<tr>
        			<td class="word">参数编号</td>
        			<td ><c:out value="${CommonParam.paramId }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">参数名</td>
        			<td ><c:out value="${CommonParam.paramName }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">参数值</td>
        			<td ><c:out value="${CommonParam.paramValue}"></c:out>&nbsp;</td>
        		</tr>
        		 <tr>
        			<td class="word">类别</td>
        			<td id="paramType"><c:out value="${CommonParam.paramType}"></c:out></td>
        		</tr> 
        		<tr>
        			<td class="word">应用系统</td>
        			<td ><c:out value="${CommonParam.ofSys}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">应用模块</td>
        			<td >
        				<c:out value="${CommonParam.ofFuc }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">描述</td>
        			<td >
	        			<c:out value="${CommonParam.description }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">创建日期</td>
        			<td >
        				<fmt:formatDate value="${CommonParam.createDate }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;
        			</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关&nbsp;闭</a></div>
      </form>
    </body>
</html>

