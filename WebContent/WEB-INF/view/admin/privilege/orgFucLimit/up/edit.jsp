<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@ include file="../import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    <title>账号授权</title>
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidator.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidatorRegex.js"type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/showErrors.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath() %>/resource/widget/select/jQuery.FillOptions.js"></script>
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.core.js"></script>
	<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.widget.js"></script>
	<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePicker.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePickerJavaAdaptor.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/tools/jquery/validator/formcheck.css" />
	<script type="text/javascript">
	jQuery(document).ready(function(){
		jQuery.formValidator.initConfig({
	        formid: "editForm",
	        submitonce: true,
	        onerror: showCustomErrors,
	         onsuccess:function(){
	       	 validate=true;
	 			var options = {    
	 			     success : closeWin,
	 			     type:"post",                     
	 			     resetForm : true
	 			};  
	 			jQuery("#editForm").ajaxSubmit(options);  
	 			return false;
	         }
	    });
		   //授权账号数量
			  jQuery("#grantAccountNum").formValidator().regexValidator({ 
				   regexp:regexEnum.intege,
				   onerror:"格式不正确,请输入正确数量"
				});
	});	
	function doEdit(){
		jQuery("#editForm").submit();
	}
	function reset(){
		jQuery("#editForm")[0].reset();
	}
	function closeWin(){
		window.close();
		window.opener.location.reload();
	}
	</script>	
    </head>
    <body>
    <form id="editForm" name="editForm" action="${pageContext.request.contextPath}/view/admin/privilege/orgFucLimit/Up-edit.action" method="post">
      <input type="hidden" name="OrgAccount!orgAccountId" id="orgAccountId"  value="<c:out value="${OrgAccount.orgAccountId }"></c:out>" />    
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">账号授权</th>
        		</tr>
        		<tr>
        			<td class="word">机构编号</td>
        			<td ><c:out value="${OrgAccount.orgId}"></c:out>&nbsp;</td>
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
        			<td class="word">授权帐号数量</td>
        			<td ><input type="text" id="grantAccountNum" name="OrgAccount!grantAccountNum" class="inputtext" value="<c:out value="${OrgAccount.grantAccountNum}"></c:out>"/> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">已用帐号数量</td>
        			<td >
        				<c:out value="${OrgAccount.useAccountNum }"></c:out>&nbsp;
        			</td>
        		</tr>
        		<tr>
        			<td class="word">账户状态</td>
        			<td id="state"><c:out value="${OrgAccount.state}"></c:out>&nbsp;</td>
        		</tr>
        		<tr>
        			<td class="word">开户时间</td>
        			<td >
        				<fmt:formatDate value="${OrgAccount.openAccountDate }" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>&nbsp;
        			</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a><a class="confirmBtn" title="保存"  id="save-btn" href="###" onclick="javascript:doEdit();">保 存</a></div>
      </form>
    </body>
</html>
