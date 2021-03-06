<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
	<%@ include file="import.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    <title>修改功能信息</title>
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidator.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidatorRegex.js"type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/showErrors.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
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
		jQuery("#fusId").formValidator().inputValidator({
	           min: 1,
	           max:32,
	           type:"size",
	           onerror:"不能为空或长度不对,长度为1~32个字符"
	        });
		 jQuery("#chnName").formValidator().inputValidator({
	           min: 4,
	           max:20,
	           type:"size",
	           onerror:"不能为空或长度不对,长度为2~10个中文"
	        }).regexValidator({
			   regexp: regexEnum.chinese,
	           onerror:"格式不对,长度为2~10个中文"
	        });
		 
		   jQuery("#type").formValidator().inputValidator({ 
			     min:1,
		         onerror:"请选择资源类型"
		   });
		   
		   jQuery("#isactive").formValidator().inputValidator({ 
			     min:1,
		         onerror:"请选择状态"
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
    <form id="editForm" name="editForm" action="${pageContext.request.contextPath}/view/admin/privilege/fuct/Do-edit.action" method="post">
       <input type="hidden" name="FucResource!fusId" value="<c:out value="${FucResource.fusId }"></c:out>" />
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">修改功能信息</th>
        		</tr>
        		<tr> 
        			<td class="word">资源编号</td>
        			<td ><input id="fusId" name="FucResource!fusId" type="text" readonly style="background-color: #F5F5F5" class="inputtext" value="<c:out value="${FucResource.fusId}"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">中文名称</td>
        			<td ><input type="text" id="chnName" name="FucResource!chnName" class="inputtext" value="<c:out value="${FucResource.chnName}"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">英文名称</td>
        			<td ><input type="text" id="engName" name="FucResource!engName" class="inputtext" value="<c:out value="${FucResource.engName}"></c:out>" /></td>
        		</tr>
        		<tr>
        			<td class="word">资源类型</td>
        			<td >
        				<tag:select id="type" name="FucResource!type" dictCode="dictionary.privilege.funt.type" checkValue="${FucResource.type }"/> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>
        		<tr>
        			<td class="word">资源地址</td>
        			<td ><input id="url" name="FucResource!url"   type="text" class="inputtext" value="<c:out value="${FucResource.url}"></c:out>"  /></td>
        		</tr>
        		<tr>
        			<td class="word">状态</td>
        			<td >
        				<tag:select id="isactive" name="FucResource!isactive" dictCode="dictionary.privilege.funt.status" checkValue="${FucResource.isactive }"/> <font class="fontredcolor">&nbsp;*</font>  
        			</td>
        		</tr>
        		<tr>
        			<td class="word">跳转类型</td>
        			<td ><input id="jumpType" name="FucResource!jumpType"   type="text" class="inputtext"   value="<c:out value="${FucResource.jumpType}"></c:out>"  /></td>
        		</tr>
        		<tr>
        			<td class="word">映射路径</td>
        			<td ><input id="mappingForward" name="FucResource!mappingForward"   type="text" class="inputtext"   value="<c:out value="${FucResource.mappingForward}"></c:out>" /></td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a><a class="confirmBtn" title="保存"  id="save-btn" href="###" onclick="javascript:doEdit();">保 存</a></div>
      </form>
    </body>
</html>
