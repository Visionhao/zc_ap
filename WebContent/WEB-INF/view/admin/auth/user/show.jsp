<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>查看用户信息</title>
		<script type="text/javascript">
		function doClose(){
			return this.window.close();
		}
		$(function(){
			if(document.getElementById("phone").innerHTML=='0&nbsp;'){
		 		document.getElementById("phone").innerHTML='';
		 	}
		});
		</script>
    </head>
    <body>
    <form action="#" method="post">
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">查看用户信息</th>
        		</tr>
        		<tr>
        			<td class="word">主帐号</td>
        			<td ><c:out value="${User.accountCode }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">辅帐号1</td>
        			<td ><c:out value="${User.accountSubcode1}"></c:out>&nbsp;</td>
        		</tr>
        		 <tr>
        			<td class="word">辅帐号2</td>
        			<td ><c:out value="${User.accountSubcode2}"></c:out>&nbsp;</td>
        		</tr> 
        		<tr>
        			<td class="word">开户机构</td>
        			<td ><c:out value="${User.orgCode}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">手机号码</td>
        			<td id="phone"><c:out value="${User.phone }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">电子邮箱</td>
        			<td >
        				<c:out value="${User.email }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">昵称</td>
        			<td >
        				<c:out value="${User.nickname }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">姓名</td>
        			<td >
        				<c:out value="${User.chineseName }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">出生日期</td>
        			<td >
        				<fmt:formatDate value="${User.birthday }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">帐号类型</td>
        			<td id="type"><c:out value="${UserType }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">账号状态</td>
        			<td id="state"><c:out value="${UserState }"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">开通时间</td>
        			<td >
        				<fmt:formatDate value="${User.created }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;
        			</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="关 闭" id="reset-btn" href="###" onclick="javascript:doClose()">关&nbsp;闭</a></div>
      </form>
    </body>
</html>

