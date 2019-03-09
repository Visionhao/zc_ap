<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="tag" uri="/uap-tags" %>
<%@ include file="../import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    <title>修改表单信息</title>
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidator.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidatorRegex.js"type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/showErrors.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath() %>/resource/widget/select/jQuery.FillOptions.js"></script>
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.core.js"></script>
	<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.widget.js"></script>
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
		jQuery("#formId").formValidator().inputValidator({
	           min: 1,
	           max:42,
	           type:"size",
	           onerror:"不能为空或长度不对,长度为1~32个字符"
	        });
		 jQuery("#formName").formValidator().inputValidator({
	           min: 4,
	           max:20,
	           type:"size",
	           onerror:"不能为空或长度不对,长度为2~10个中文"
	        }).regexValidator({
			   regexp: regexEnum.chinese,
	           onerror:"格式不对,长度为2~10个中文"
	        });
		   jQuery("#openName").formValidator().inputValidator({ 
			     min:1,
		         onerror:"请选择功能名称"
		        });
		   jQuery("#description").formValidator().inputValidator({ 
			     max:255,
		         onerror:"长度不对，请输入127个以内的字符"
		        });
		   jQuery("#help").formValidator().inputValidator({ 
			     max:2000,
			     type:"size",
		         onerror:"长度不对，请输入1000个以内的字符"
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
    <form id="editForm" name="editForm" action="${pageContext.request.contextPath}/view/admin/privilege/form/Up-edit.action" method="post">
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">修改表单信息</th>
        		</tr>
        		<tr>
        			<td class="word">表单编号</td>
        			<td ><input   id="formId" readonly style="background-color: #F5F5F5" name="Form!formId"  class="inputtext" value="<c:out value="${Form.formId }"></c:out>" type="text" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">表单名称</td>                      
        			<td ><input   id="formName" name="Form!formName"  class="inputtext" value="<c:out value="${Form.formName }"></c:out>" type="text" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">功能名称</td>
        			<td ><input   id="openName" name="openName" readonly="readonly" class="inputtext" value="<c:out value="${FucResource.chnName}"></c:out>" type="text" onclick="javasrcipt:openwindow('${pageContext.request.contextPath}/view/admin/privilege/form/Up-alertSelect.action','功能列表信息2',1000,600)" /><input type="hidden" id="fusId" name="Form!fusId" value="<c:out value="${FucResource.fusId}"></c:out>"/> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>
        		<tr>
        			<td class="word">类名</td>
        			<td ><input   id="classname" name="Form!classname"  class="inputtext" value="<c:out value="${Form.classname }"></c:out>" type="text" /></td>
        		</tr>
        		<tr>
        			<td class="word">资源路径</td>
        			<td ><input   id="formUrl" name="Form!formUrl"  class="inputtext" value="<c:out value="${Form.formUrl }"></c:out>" type="text" /></td>
        		</tr>
        		<tr>
        			<td class="word">描述</td>
        			<td><textarea rows="3" cols="3" id="description" name="Form!description" style="width:180px;height:100px;resize: none;" ><c:out value="${Form.description }"></c:out></textarea></td>
        		</tr>	
        		<tr>
        			<td class="word">帮助</td>
        			<td><textarea rows="3" cols="3" id="help" name="Form!help" style="width:180px;height:100px;resize: none;" ><c:out value="${Form.help }"></c:out></textarea></td>
        		</tr>
        	</tbody>	
        </table>
        <div class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a><a class="confirmBtn" title="保存"  id="save-btn" href="###" onclick="javascript:doEdit();">保 存</a></div>
      </form>
    </body>
</html>
