<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@ include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>查看机构账户信息</title>
		<script type="text/javascript">
		function doClose(){
			return this.window.close();
		}
	 	$(function(){
			if(document.getElementById("contactPhone").innerHTML=='0'){
		 		document.getElementById("contactPhone").innerHTML='';
		 	}
		}); 
		</script>
    </head>
    <body>
    <form action="#" method="post">
     <input type="hidden" name="OrgAccount!orgAccountId" id="OrgAccount!orgAccountId"  value="<c:out value="${OrgAccount.orgAccountId }"></c:out>" />  
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看机构账户信息</th>
        		</tr>
        		<tr>
        			<td class="word">机构编号</td>
        			<td><c:out value="${OrgAccount.orgId }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">机构名称</td>
        			<td ><c:out value="${OrgAccount.orgChnName }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">机构账户名</td>
        			<td ><c:out value="${OrgAccount.user.accountCode}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">联系人</td>
        			<td ><c:out value="${OrgAccount.principal }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">联系电话</td>
        			<td id="contactPhone"><c:out value="${OrgAccount.contactPhone }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">电子邮箱</td>
        			<td ><c:out value="${OrgAccount.contactEmail }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">授权帐号数量</td>
        			<td ><c:out value="${OrgAccount.grantAccountNum }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">已用帐号数量</td>
        			<td >
        				<c:out value="${OrgAccount.useAccountNum }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">账户状态</td>
        			<td id="state"><c:out value="${OrgAccountState }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">开户日期</td>
        			<td >
        				<fmt:formatDate value="${OrgAccount.openAccountDate }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;
        			</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关闭" id="reset-btn" href="###" onclick="javascript:doClose()">关&nbsp;&nbsp;闭</a></div>
      </form>
    </body>
</html>

