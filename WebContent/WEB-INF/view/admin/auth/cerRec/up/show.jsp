<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>查看企业信息</title>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.dialog.js"></script>
		<link href="${pageContext.request.contextPath}/resource/widget/validator/validate.css" rel="stylesheet" type="text/css">
		<script >
			function doClose(){
				return this.window.close();
			}
		</script>
    </head>
    <body>
    <form action="#" method="post">
   		<input type="hidden" name="Certification!systemUserId" id="Certification!systemUserId "  value="<c:out value="${Certification.systemUserId}"></c:out>" />   
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看企业信息</th>
        		</tr>
        		<tr>
        			<td class="word">用户ID</td>
        			<td ><c:out value="${User.systemUserId }"></c:out>&nbsp;</td>
        		</tr>	
        		<tr>
        			<td class="word">主帐号</td>
        			<td ><c:out value="${User.accountCode }"></c:out>&nbsp;</td>
        		</tr>    		
        		<tr>
        			<td class="word">单位名称</td>
        			<td ><c:out value="${Individual.employer }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">状态</td>
        			<td ><c:out value="${User.state }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">类型</td>
        			<td ><c:out value="${User.type }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">认证次数</td>
        			<td >
        				<c:out value="${Certification.cerNum }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">通过次数</td>
        			<td >
	        			<c:out value="${Certification.cerPassNum }"></c:out>&nbsp;
        			</td>
        		</tr>       
        		<tr>
        			<td class="word">首次认证时间</td>
        			<td ><fmt:formatDate value="${Certification.firstCerTime }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;</td>
        		</tr>        		
        		<tr>
        			<td class="word">末次认证时间</td>
        			<td>
        				<fmt:formatDate value="${Certification.lastCerTime }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;
        			 </td>
        		</tr>	
        		<tr>
        			<td class="word">开户机构</td>
        			<td ><c:out value="${User.org_code }"></c:out>&nbsp;</td>
        		</tr>	
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关 闭</a></div>
      </form>
    </body>
</html>
