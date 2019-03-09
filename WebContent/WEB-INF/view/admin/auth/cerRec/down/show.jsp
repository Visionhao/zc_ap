<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <%@include file="../import.jsp" %>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>查看认证日志信息</title>
    <link href="${pageContext.request.contextPath}/view/example/template/queryList/this.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
	function doClose(){
		return this.window.close();
	}
	</script>	
    </head>
    <body>
    <form id="editForm" name="editForm"  action="#" method="post" > 
    <input type="hidden" name="CertificationRec!cerRecId" id="CertificationRec!cerRecId"  value="<c:out value="${CertificationRec.cerRecId }"></c:out>" />
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看认证日志信息</th>
        		</tr>
        		<tr>        			 
        			<td class="word">认证日期</td>
        			<td ><fmt:formatDate value="${CertificationRec.cerTime }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;</td>
        		</tr>     		
        		<tr>
        			<td class="word">认证方式</td>
        			<td ><c:out value="${CertificationRec.cerType }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">认证结果</td>
        			<td ><c:out value="${CertificationRec.cerResult }"></c:out>&nbsp;</td>
        		</tr>      		
        		<tr>
        			<td class="word">创建日期</td>
        			<td ><fmt:formatDate value="${CertificationRec.consuming }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">客户端IP</td>
        			<td ><c:out value="${CertificationRec.clientIp }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">服务端IP</td>
        			<td ><c:out value="${CertificationRec.serverIp }"></c:out>&nbsp;</td>
        		</tr>
        	</tbody>
        </table>
          <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关 闭</a></div>  
      </form>
    </body>
</html>
