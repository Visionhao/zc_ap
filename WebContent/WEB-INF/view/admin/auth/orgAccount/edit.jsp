<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="import.jsp"%>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    <title>修改机构账户</title>
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
	 			     success : function(obj){
	 			    	 if(obj=="yes"){
	 			    		 alert("修改成功");
	 			    		 closeWin();
	 			    	 }else{
	 			    		 alert("修改失败");
	 			    		 reset();
	 			    	 }
	 			     },
	 			     type:"post",                     
	 			     resetForm : true
	 			};  
	 			jQuery("#editForm").ajaxSubmit(options);  
	 			return false;
	         }
	    });
		//机构编号
		jQuery("#orgAccountId").formValidator().inputValidator({
              min: 1,
              max:32,
              type:"size",
              onerror:"不能为空或长度不对，长度为1~32个字符"
           });
		  //机构名称
		  jQuery("#orgChnName").formValidator().inputValidator({
              min: 1,
              max:100,
              type:"size",
              onerror:"不能为空或长度不对，长度为1~100个字符"
           });
		   //授权账号数量
			 jQuery("#grantAccountNum").formValidator().regexValidator({ 
				   regexp: regexEnum.num1,
				   onerror:"格式不正确,请输入数字"
				});
		   //账户状态
			jQuery("#state").formValidator().inputValidator({
					   min:1,
			           onerror:"请选择帐户状态"
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
	$(function(){
		if(document.getElementById("contactPhone").value=='0'){
	 		document.getElementById("contactPhone").value='';
	 	}
	});
	</script>	
    </head>
    <body>
    <form id="editForm" name="editForm" action="${pageContext.request.contextPath}/view/admin/auth/orgAccount/Do-edit.action" method="post">
      <input type="hidden" name="OrgAccount!orgAccountId" id="orgAccountId"  value="<c:out value="${OrgAccount.orgAccountId }"></c:out>" />    
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">修改机构账户</th>
        		</tr>
        		<tr>
        			<td class="word">机构编号</td>
        			<td ><input id="orgId" name="OrgAccount!orgId" readonly style="background-color: #F5F5F5" type="text" class="inputtext"  value="<c:out value="${OrgAccount.orgId }"></c:out>"/> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">机构名称</td>
        			<td ><input id="orgChnName" name="OrgAccount!orgChnName"   type="text" class="inputtext"   value="<c:out value="${OrgAccount.orgChnName }"></c:out>"/> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">机构账户名</td>
        			<td ><input id="accountCode" name="OrgAccount.user!accountCode" class="inputtext" readonly="readonly" style="background-color: #F5F5F5;" value="<c:out value="${OrgAccount.user.accountCode}"></c:out>"/> </td>
        		</tr>
        		<tr>
        			<td class="word">联系人</td>
        			<td ><input id="principal" name="OrgAccount!principal" class="inputtext" value="<c:out value="${OrgAccount.principal }"></c:out>"/></td>
        		</tr>
        		<tr>
        			<td class="word">联系电话</td>
        			<td ><input id="contactPhone" name="OrgAccount!contactPhone" class="inputtext" value="<c:out value="${OrgAccount.contactPhone }"></c:out>"/></td>
        		</tr>
        		<tr>
        			<td class="word">电子邮箱</td>
        			<td ><input id="contactEmail" name="OrgAccount!contactEmail" class="inputtext" value="<c:out value="${OrgAccount.contactEmail }"></c:out>"/> </td>
        		</tr>
        		<tr>
        			<td class="word">授权账号数量</td>
        			<td >
	        			<input type="text" id="grantAccountNum" name="OrgAccount!grantAccountNum" class="inputtext" value="<c:out value="${OrgAccount.grantAccountNum}"></c:out>"/> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>
        		<tr>
        			<td class="word">账户状态</td>
        			<td>
        				<tag:select  id="state" name="OrgAccount!state" dictCode="dictionary.auth.userAccount.orgStatus" checkValue="${OrgAccount.state }"/> <font class="fontredcolor">*</font>	
					</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp;&nbsp; 置</a>&nbsp<a class="confirmBtn" title="保存"  id="save-btn" href="###" onclick="javascript:doEdit();">保&nbsp;&nbsp;存</a></div>
      </form>
    </body>
</html>
