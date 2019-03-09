<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <%@include file="../import.jsp" %>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>新增角色信息</title>
      <link href="${pageContext.request.contextPath}/view/admin/this.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
 	 	<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/widget/select/jQuery.FillOptions.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css">
		<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePicker.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePickerJavaAdaptor.js" type="text/javascript"></script>
	<script type="text/javascript">
	var opt = "doSave";
		jQuery(document).ready(function(){
			 jQuery.formValidator.initConfig({
			        formid: "addForm",
			        submitonce: true,
			        onerror: showCustomErrors,
			         onsuccess:function(){
			       	 validate=true;
				       	 if(opt=="doSave"){
				 			var options = {    
				 			     success : function(obj){
				 			    	 if(obj=='yes'){
				 			    		 alert("添加成功");
				 			    		closeWin();
				 			    	 }else if(obj=='no'){
				 			    		 alert("添加失败");
				 			    	 }else if(obj=='1'){
				 			    		alert("添加成功");
				 			    		addPage();
				 			    	 }else if(obj=='0'){
				 			    		alert("添加失败");
				 			    	 }
				 			     },
				 			     type:"post",                     
				 			     resetForm : true
				 			};  
				 			jQuery("#addForm").ajaxSubmit(options);
				 			return false;
				         }
			         }
			    });
			 jQuery("#roleChnName").formValidator().inputValidator({
		           min: 4,
		           max:20,
		           type:"size",
		           onerror:"不能为空或长度不对,长度为2~10个中文"
		        }).regexValidator({
				   regexp: regexEnum.chinese,
		           onerror:"格式不对,长度为2~10个中文"
		        });
			 jQuery("#roleType").formValidator().inputValidator({ 
			     min:1,
		         onerror:"请选择角色类型"
		        });
			 jQuery("#state").formValidator().inputValidator({ 
			     min:1,
		         max:20,
		         type:"size",
		         onerror:"请选择状态"
		        });
			 jQuery("#roleRemark").formValidator().inputValidator({ 
		         max:100,
		         type:"size",
		         onerror:"长度不对，请输入50个以内的字符"
		        });
   });
	function doSave(){
		opt="doSave";
		jQuery("#addForm").submit();
		
	}
	function doSaveToAdd(){
		opt = "doSave";
		jQuery("#addForm").attr("action", "${pageContext.request.contextPath}/view/admin/privilege/role/Up-saveToAdd.action");
		jQuery("#addForm").submit();
		
	}
	function addPage(){
		var url = "${pageContext.request.contextPath}/view/admin/privilege/role/Up-addPage.action";
		window.location.href = url;
		window.opener.location.reload();
	}
	function closeWin(){
		window.close();	
	    window.opener.location.reload();
		
	}
	function reset(){
		jQuery("#addForm")[0].reset();
	}
	</script>	
    </head>
    <body>
    <form id="addForm" name="addForm"  action="${pageContext.request.contextPath}/view/admin/privilege/role/Up-add.action" method="post" > 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增角色信息</th>
        		</tr>
        		<tr>
        			<td class="word">角色名称</td>
        			<td ><input id="roleChnName" name="Role!roleChnName" type="text" class="inputtext" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">角色类型</td>                      
        			<td ><tag:select id="roleType" name="Role!roleType" dictCode="dictionary.privilege.role.type" checkValue="AD100601"/> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">状态</td>
        			<td ><tag:select id="state" name="Role!state" dictCode="dictionary.privilege.role.status" checkValue="AD100701" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">说明</td>
        			<td ><textarea rows="3" cols="3" id="roleRemark" name="Role!roleRemark" style="width:185px;height:100px;resize: none;" ></textarea></td>
        		</tr>
        	</tbody>
        </table>
          <div class="btnbox">
          <a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a>
          <a class="confirmBtn" title="保 存并新增"  id="save-btn" href="###" onclick="javascript:doSaveToAdd()">保存并新增</a>
          <a class="confirmBtn" title="保 存"  id="save-btn" href="###" onclick="javascript:doSave()">保 存</a>
          </div>   
      </form>
    </body>
</html>
