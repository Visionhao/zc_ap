<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>新增功能信息</title>
      <%@taglib prefix="tag" uri="/uap-tags" %>
      <%@include file="import.jsp" %>
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
	function doSave(){
		opt="doSave";
		var menuText = document.getElementById('text').innerHTML;
		if(menuText!="该功能编号已被使用，请重新输入"){
			jQuery("#addForm").submit();
		}
		
	}
	function doSaveToAdd(){
		opt = "doSave";
		var menuText = document.getElementById('text').innerHTML;
		if(menuText!="该功能编号已被使用，请重新输入"){
			jQuery("#addForm").attr("action", "${pageContext.request.contextPath}/view/admin/privilege/fuct/Do-saveToAdd.action");;
			jQuery("#addForm").submit();
		}
	}
	function addPage(){
		var url = "${pageContext.request.contextPath}/view/admin/privilege/fuct/Do-addPage.action";
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
    	var menuText = document.getElementById('text');
    	var id = document.getElementById('fusId');
    	if(id.value!=""){
			$.ajax({  
		            url:'${pageContext.request.contextPath}/view/admin/privilege/fuct/Do-Validate.action',//先走校验的action   
		            type:"POST",          
		            data:"resId="+val,       
		            dataType:'text',  
		            success:function(obj){
		            	if(obj=="yes"){
		            		menuText.innerHTML = "该功能编号已被使用，请重新输入";
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
    <form id="addForm" name="addForm"  action="${pageContext.request.contextPath}/view/admin/privilege/fuct/Do-add.action" method="post" > 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增功能信息</th>
        		</tr>
        		<tr> 
        			<td class="word">资源编号</td>
        			<td ><input id="fusId" name="FucResource!fusId" onblur="validate(this.value)" type="text" class="inputtext" /> <font id="text" class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">中文名称</td>
        			<td ><input type="text" id="chnName" name="FucResource!chnName" class="inputtext"/> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">英文名称</td>
        			<td ><input type="text" id="engName" name="FucResource!engName" class="inputtext"/></td>
        		</tr>
        		<tr>
        			<td class="word">资源类型</td>
        			<td >
        				<tag:select id="type" name="FucResource!type" dictCode="dictionary.privilege.funt.type" checkValue="AD101101"/> <font class="fontredcolor">&nbsp;*</font> 
        			</td>
        		</tr>
        		<tr>
        			<td class="word">资源地址</td>
        			<td ><input id="url" name="FucResource!url"   type="text" class="inputtext"   /></td>
        		</tr>
        		<tr>
        			<td class="word">状态</td>
        			<td >
        				<tag:select id="isactive" name="FucResource!isactive" dictCode="dictionary.privilege.funt.status" checkValue="AD101001"/> <font class="fontredcolor">&nbsp;*</font>  
        			</td>
        		</tr>
        		<tr>
        			<td class="word">跳转类型</td>
        			<td ><input id="jumpType" name="FucResource!jumpType"   type="text" class="inputtext"   /></td>
        		</tr>
        		<tr>
        			<td class="word">映射路径</td>
        			<td ><input id="mappingForward" name="FucResource!mappingForward"   type="text" class="inputtext"   /></td>
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
