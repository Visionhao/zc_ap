<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="import.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/widget/select/jQuery.FillOptions.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.core.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.widget.js"></script>
<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePicker.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePickerJavaAdaptor.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/tools/jquery/validator/formcheck.css" />
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery.formValidator.initConfig({
			formid : "editForm",
			submitonce : true,
			onerror : showCustomErrors,
			onsuccess : function() {
				validate = true;
				var options = {
					success : function(obj){
	 			    	 if(obj=="yes"){
	 			    		 alert("修改成功");
	 			    		 closeWin();
	 			    	 }else{
	 			    		 alert("修改失败");
	 			    		 reset();
	 			    	 }
	 			     },
					type : "post",
					resetForm : true
				};
				jQuery("#editForm").ajaxSubmit(options);
				return false;
			}
		});
		//主帐号
		jQuery("#accountCode").formValidator().inputValidator({
			min : 1,
			max : 20,
			type : "size",
			onerror : "不能为空或长度不对,长度为1~20个字符"
		});
		//姓名
		jQuery("#chineseName").formValidator().inputValidator({
			min : 1,
			max : 15,
			type : "size",
			onerror : "不能为空或长度不对,长度为1~15个字符"
		});
		//帐号状态
	     jQuery("#state").formValidator().inputValidator({
			   min:1,
	           onerror:"请选择帐号状态"
		});
		//帐号类型
	     jQuery("#type").formValidator().inputValidator({
			   min:1,
	           onerror:"请选择帐号类型"
		});
	});
	function doEdit() {
		jQuery("#editForm").submit();
	}
	function reset() {
		jQuery("#editForm")[0].reset();
	}
	function closeWin() {
		window.close();
		window.opener.location.reload();
	}
	$(function(){
		if(document.getElementById("phone").value=='0'){
	 		document.getElementById("phone").value='';
	 	}
	});
</script>
</head>
<body>
	<form id="editForm" name="editForm" action="${pageContext.request.contextPath}/view/admin/auth/user/Do-edit.action" method="post">
		<input type="hidden" name="User!systemUserId" id="User!systemUserId"  value="<c:out value="${User.systemUserId }"></c:out>" /> 
		<table class="add-info-table">
			<tbody>
				<tr align="center">
					<th colspan="2">修改用户信息</th>
				</tr>
				<tr>
					<td class="word">主帐号</td>
					<td><input id="accountCode" readonly style="background-color: #F5F5F5" name="User!accountCode" type="text" class="inputtext" value="<c:out value="${User.accountCode }"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
				<tr>
					<td class="word">辅帐号1</td>
					<td><input id="accountSubcode1" name="User!accountSubcode1" class="inputtext" value="<c:out value="${User.accountSubcode1 }"></c:out>" /> 
					</td>
				</tr>
				<tr>
        			<td class="word">辅帐号2</td>
        			<td ><input  id="accountSubcode2" name="User!accountSubcode2" class="inputtext"  value="<c:out value="${User.accountSubcode2 }"></c:out>"/> </td>
        		</tr> 
				<tr>
					<td class="word">手机号码</td>
					<td><input type="text" id="phone" name="User!phone"	class="inputtext" value="<c:out value="${User.phone }"></c:out>" /></td>
				</tr>
				<tr>
					<td class="word">电子邮箱</td>
					<td>
						<input type="text" id="email" name="User!email"class="inputtext" value="<c:out value="${User.email}"></c:out>" /> 
					</td>
				</tr>
				<tr>
					<td class="word">昵称</td>
					<td>
						<input type="text" id="nickname" name="User!nickname" class="inputtext" value="<c:out value="${User.nickname}"></c:out>" />
					</td>
				</tr>
				<tr>
					<td class="word">姓名</td>
					<td>
						<input id="chineseName" name="User!chineseName" class="inputtext" value="<c:out value="${User.chineseName}"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
				<tr>
					<td class="word">帐号类型</td>
					<td>
						<tag:select id="type" name="User!type" dictCode="dictionary.auth.userAccount.type" checkValue="${User.type }" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
				<tr>
					<td class="word">帐号状态</td>
					<td>
						<tag:select id="state" name="User!state" dictCode="dictionary.auth.userAccount.status" checkValue="${User.state }" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
			</tbody>
		</table>
		<div class="btnbox">
			<a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp; 置</a>&nbsp<a class="confirmBtn" title="保存" id="save-btn" href="###" onclick="javascript:doEdit();">保&nbsp;存</a>
		</div>
	</form>
</body>
</html>
