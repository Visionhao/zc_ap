<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>新增表单信息</title>
      <%@include file="../import.jsp" %>
      <link href="${pageContext.request.contextPath}/view/admin/this.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
 	 	<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/widget/select/jQuery.FillOptions.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css">
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
			 jQuery("#formId").formValidator().inputValidator({
		           min: 1,
		           max:32,
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
				     type: "size",
			         onerror:"长度不对，请输入1000个以内的字符"
			        });
		});
	function doSave(){
		opt="doSave";
		var menuText = document.getElementById("txt").innerHTML;
		if(menuText!="该编号已被使用，请重新输入"){
			jQuery("#addForm").submit();
		}
	}
	function doSaveToAdd(){
		opt = "doSave";
		var menuText = document.getElementById('txt').innerHTML;
			if(menuText!="该编号已被使用，请重新输入"){
			jQuery("#addForm").attr("action", "${pageContext.request.contextPath}/view/admin/privilege/form/Up-saveToAdd.action");
			jQuery("#addForm").submit();
		}
	}
	function addPage(){
		var url = "${pageContext.request.contextPath}/view/admin/privilege/form/Up-addPage.action";
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
	function validate(val) {
    	var menuText = document.getElementById('txt');
    	var id = document.getElementById('formId');
    	if(id.value!=""){
			$.ajax({  
		            url:'${pageContext.request.contextPath}/view/admin/privilege/form/Up-Validate.action',//先走校验的action   
		            //cache:false,        //拒绝缓存   
		            //async:false,        //异步提交   
		            type:"POST",          
		            data:"resId="+val,       
		            dataType:'text',  
		            success:function(obj){
		            	if(obj=="yes"){
		            		menuText.innerHTML = "该编号已被使用，请重新输入";
		            	}else{
		            		menuText.innerHTML = "&nbsp;*";
		            	}
		            }
		        }); 
    	}
	};
	</script>	
    </head>
    <body>
    <form id="addForm" name="addForm"  action="${pageContext.request.contextPath}/view/admin/privilege/form/Up-add.action" method="post" > 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增表单信息</th>
        		</tr>
        		<tr>
        			<td class="word">表单编号</td>
        			<td ><input   id="formId" name="Form!formId" onblur="validate(this.value)" class="inputtext" type="text" /> <font id="txt" class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">表单名称</td>                      
        			<td ><input   id="formName" name="Form!formName"  class="inputtext" type="text" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">功能名称</td>
        			<td ><input id="openName" name="openName" readonly="readonly" class="inputtext" type="text" onclick="javasrcipt:openwindow('${pageContext.request.contextPath}/view/admin/privilege/form/Up-alertSelect.action','功能列表信息',1000,600)" /><input type="hidden" name="Form!fusId" id="fusId" /> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>
        		<tr>
        			<td class="word">类名</td>
        			<td ><input   id="classname" name="Form!classname"  class="inputtext" type="text" /></td>
        		</tr>
        		<tr>
        			<td class="word">资源路径</td>
        			<td ><input   id="formUrl" name="Form!formUrl"  class="inputtext" type="text" /></td>
        		</tr>
        		<tr>
        			<td class="word">描述</td>
        			<td><textarea rows="3" cols="3" id="description" name="Form!description" style="width:185px;height:100px;resize: none;" ></textarea></td>
        		</tr>	
        		<tr>
        			<td class="word">帮助</td>
        			<td>
        			<textarea rows="3" cols="3" id="help" name="Form!help" style="width:185px;height:100px;resize: none;" ></textarea>
        			</td>
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
