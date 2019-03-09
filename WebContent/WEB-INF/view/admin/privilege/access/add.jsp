<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>新增操作键信息</title>
      	<%@include file="import.jsp" %>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
 	 	<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
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
	function doSave(){
		opt="doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该编号已被使用，请重新输入"){
			jQuery("#addForm").submit();
		}
	}
	function doSaveToAdd(){
		opt = "doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该编号已被使用，请重新输入"){
			jQuery("#addForm").attr("action", "${pageContext.request.contextPath}/view/admin/privilege/access/Do-saveToAdd.action");
			jQuery("#addForm").submit();
		}
		
	}
	function addPage(){
		var url = "${pageContext.request.contextPath}/view/admin/privilege/access/Do-addPage.action";
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
    	var id = document.getElementById('accessId');
    	if(id.value!=""){
			$.ajax({  
		            url:'${pageContext.request.contextPath}/view/admin/privilege/access/Do-Validate.action',//先走校验的action   
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
    <form id="addForm" name="addForm"  action="${pageContext.request.contextPath}/view/admin/privilege/access/Do-add.action" method="post" > 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增操作键信息</th>
        		</tr>
        		<tr>
        			<td class="word">操作键编号</td>
        			<td ><input id="accessId" name="Access!accessId" onblur="validate(this.value)" type="text" class="inputtext" /> <font id="txt" class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">中文名称</td>
        			<td ><input id="accessChnName" name="Access!accessChnName" type="text" class="inputtext" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">英文名称</td>
        			<td ><input id="accessEngName" name="Access!accessEngName"   type="text" class="inputtext"   /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">动作路径</td>
        			<td ><input type="text" id="actionUrl" name="Access!actionUrl" class="inputtext"/></td>
        		</tr>
        		<tr>
        			<td class="word">类型</td>
        			<td >
        				<tag:select id="type" name="Access!type" dictCode="dictionary.privilege.access.type" checkValue="AD101201"/> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>
        		<tr>
        			<td class="word">序号</td>
        			<td ><input id="accessNo" name="Access!accessNo"   type="text" class="inputtext"   /> <font class="fontredcolor">&nbsp;*</font></td>
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
