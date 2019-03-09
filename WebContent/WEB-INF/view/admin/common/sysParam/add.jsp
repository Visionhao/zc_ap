<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <%@include file="import.jsp" %>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>新增系统参数</title>
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
			 //参数编号
			 jQuery("#paramId").formValidator().inputValidator({
	              min: 1,
	              max:32,
	              type:"size",
	              onerror:"不能为空或长度不对,长度为1~32个字符"
	           });
			 //参数名
			 jQuery("#paramName").formValidator().inputValidator({
				  min: 1,
	              max:60,
	              type:"size",
	              onerror:"不能为空或长度不对,长度为1~60个字符"
		        });
			//参数值
			   jQuery("#paramValue").formValidator().inputValidator({
				   min: 1,
		           max:60,
		           type:"size",
		           onerror:"不能为空或长度不对,长度为1~60个字符"
		        });
			    //类别
			   jQuery("#paramType").formValidator().inputValidator({ 
				   min: 1,
		           onerror:"请选择类别"
				}); 
			 //应用系统
			     jQuery("#ofSys").formValidator().inputValidator({ 
			    	min: 1,
		            max:32,
		            type:"size",
		            onerror:"不能为空或长度不对,长度为1~32个字符"
					});
			     jQuery("#description").formValidator().inputValidator({
						max : 200,
						type : "size",
						onerror : "长度不对,请输入100个以内的字符"
					});
   });
	function addPage(){
		var url = "${pageContext.request.contextPath}/view/admin/common/sysParam/Do-addPage.action";
		window.location.href = url;
		window.opener.location.reload();
	}
	function doSave(){
		opt="doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该参数编号已被使用，请重新输入"){
			jQuery("#addForm").submit();
		}
	}
	function doSaveToAdd(){
		opt = "doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该参数编号已被使用，请重新输入"){
			jQuery("#addForm").attr("action", "${pageContext.request.contextPath}/view/admin/common/sysParam/Do-saveToAdd.action");;
			jQuery("#addForm").submit();
		}
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
    	var id = document.getElementById('paramId');
    	if(id.value!=""){
			$.ajax({  
		            url:'${pageContext.request.contextPath}/view/admin/common/sysParam/Do-Validate.action',//先走校验的action   
		            //cache:false,        //拒绝缓存   
		            //async:false,        //异步提交   
		            type:"POST",          
		            data:"resId="+val,       
		            dataType:'text',  
		            success:function(obj){
		            	if(obj=="yes"){
		            		menuText.innerHTML = "该参数编号已被使用，请重新输入";
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
    <form id="addForm" name="addForm"  action="${pageContext.request.contextPath}/view/admin/common/sysParam/Do-add.action" method="post" > 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增系统参数</th>
        		</tr>       		
        		<tr>
        			<td class="word">参数编号</td>
        			<td ><input id="paramId" name="CommonParam!paramId" type="text" class="inputtext" onblur="validate(this.value)"/> <font id="txt" class="fontredcolor">&nbsp;*</font></td>
        		</tr>       		
        		<tr>
        			<td class="word">参数名</td>
        			<td ><input id="paramName" name="CommonParam!paramName"   type="text" class="inputtext"   /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>      		
        		<tr>
        			<td class="word">参数值</td>
        			<td ><input id="paramValue" name="CommonParam!paramValue" class="inputtext"  /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>      		
        		<tr>
        			<td class="word">类别</td>
        			<td>
        				<select id="paramType" name="CommonParam!paramType">
        					<option value="-1">--请选择--</option>
        					<option value="01" selected="selected">系统参数</option>
        					<option value="02">业务参数</option>
        					<option value="03">初始化参数</option>
        				</select> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>       		
        		<tr>
        			<td class="word">应用系统</td>
        			<td ><input type="text" id="ofSys" name="CommonParam!ofSys" class="inputtext"/> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>     		
        		<tr>
        			<td class="word">应用模块</td>       			
        				<td ><input type="text" id="ofFuc" name="CommonParam!ofFuc" class="inputtext"/> </td>    			
        		</tr>      		
        		     		
        		<tr>
        			<td class="word">描述</td>
        			<td >
        				<textarea rows="3" cols="3" id="description" name="CommonParam!description" style="width:183px;height:100px;resize: none;" ></textarea>
        			</td>
        		</tr>       		
        	</tbody>
        </table>
          <div class="btnbox">
          <a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp; 置</a>
          <a class="confirmBtn" title="保 存并新增"  id="save-btn" href="###" onclick="javascript:doSaveToAdd()">保存并新增</a>
          <a class="confirmBtn" title="保 存"  id="save-btn" href="###" onclick="javascript:doSave()">保 &nbsp;存</a>
          </div>   
      </form>    
    </body>
</html>
