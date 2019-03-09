<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<%@ include file="import.jsp"%>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    <title>修改操作键信息</title>
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
		/* 操作键标识*/
		jQuery("#accessId").formValidator().inputValidator({
	           min: 1,
	           max:32,
	           type:"size",
	           onerror:"不能为空或长度不对,长度为1~32个字符"
	        });
		/*中文名称*/
		jQuery("#accessChnName").formValidator().inputValidator({
	           min: 4,
	           max:20,
	           type:"size",
	           onerror:"不能为空或长度不对,长度为2~10个中文"
	        }).regexValidator({
			   regexp: regexEnum.chinese,
	           onerror:"格式不对,长度为2~10个中文"
	        });

		/*英文名称*/
		   jQuery("#accessEngName").formValidator().inputValidator({ 
			     min:1,
		         max:20,
		         type:"size",
		         onerror:"不能为空或长度不对,长度为1~20的字母"
		        }).regexValidator({
					   regexp: regexEnum.letter,
			           onerror:"格式不对,长度为1~20的字母"
			        });
		   
		   jQuery("#type").formValidator().inputValidator({ 
			   min:1,
			   onerror:"请选择类型"
			});
		   /*序号*/
		   jQuery("#accessNo").formValidator().inputValidator({ 
			     min:1,
		         max:2,
		         type:"size",
		         onerror:"不能为空,长度为1~2位数字"
			}).regexValidator({ 
			   regexp: regexEnum.intege1,
			   onerror:"格式不正确,请输入数字"
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
    <form id="editForm" name="editForm" action="${pageContext.request.contextPath}/view/admin/privilege/access/Do-edit.action" method="post">
       <input type="hidden" name="Access!accessId" value="<c:out value="${Access.accessId }"></c:out>" />
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">修改操作键信息</th>
        		</tr>
        		<tr>
        			<td class="word">操作键编号</td>
        			<td ><input   id="accessId" name="Access!accessId" readonly style="background-color: #F5F5F5"  class="inputtext" value="<c:out value="${Access.accessId }"></c:out>" type="text" /> <font class="fontredcolor">&nbsp;*</font> </td>
        		</tr>
        		<tr>
        			<td class="word">中文名称</td>
        			<td ><input   id="accessChnName" name="Access!accessChnName"  class="inputtext" value="<c:out value="${Access.accessChnName }"></c:out>" type="text" /> <font class="fontredcolor">&nbsp;*</font> </td>
        		</tr>
        		<tr>
        			<td class="word">英文名称</td>
        			<td ><input   id="accessEngName" name="Access!accessEngName"  class="inputtext" value="<c:out value="${Access.accessEngName }"></c:out>" type="text" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">动作路径</td>
        			<td >
        				<input   id="actionUrl" readonly style="background-color: #F5F5F5" name="Access!actionUrl"  class="inputtext" value="<c:out value="${Access.actionUrl }"></c:out>"   type="text" />
        			</td>
        		</tr>
        		<tr>
        			<td class="word">类型</td>
        			<td >
        				<tag:select id="type" name="Access!type" dictCode="dictionary.privilege.access.type" checkValue="${Access.type }"/> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>
        		<tr>
        			<td class="word">序号</td>
        			<td ><input   id="accessNo" name="Access!accessNo"  class="inputtext" value="<c:out value="${Access.accessNo }"></c:out>"   type="text" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a><a class="confirmBtn" title="保存"  id="save-btn" href="###" onclick="javascript:doEdit();">保 存</a></div>
      </form>
      
    </body>
    
</html>
