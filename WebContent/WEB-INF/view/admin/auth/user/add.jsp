<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <%@include file="import.jsp" %>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>新增用户信息</title>
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
			 //主帐号
			 jQuery("#accountCode").formValidator().inputValidator({
		           min: 1,
		           max:20,
		           type:"size",
		           onerror:"不能为空或长度不对,长度为1~20个字符"
		        });
			 //姓名
			     jQuery("#chineseName").formValidator().inputValidator({
			           min: 1,
			           max:16,
			           type:"size",
			           onerror:"不能为空或长度不对,长度为1~16个字符"
			        });
			//开户机构
			     jQuery("#orgCode").formValidator().inputValidator({
			           min: 1,
			           max:32,
			           type:"size",
			           onerror:"不能为空或长度不对,长度为1~32个字符"
			        });
			//帐号状态
			     jQuery("#state").formValidator().inputValidator({
					   min:1,
			           onerror:"请选择帐号状态"
				});
			//帐号类型
			     jQuery("#type").formValidator().inputValidator({
					   min:1,
			           onerror:"请选择帐号类型"
				});
   });
	function addPage(){
		var url = "${pageContext.request.contextPath}/view/admin/auth/user/Do-addPage.action";
		window.location.href = url;
		window.opener.location.reload();
	}
	function doSave(){
		opt="doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该主账号已被使用，请重新输入"){
			jQuery("#addForm").submit();
		}
	}
	function doSaveToAdd(){
		opt = "doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该主账号已被使用，请重新输入"){
			jQuery("#addForm").attr("action", "${pageContext.request.contextPath}/view/admin/auth/user/Do-saveToAdd.action");;
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
    	var id = document.getElementById('accountCode');
    	if(id.value!=""){
			$.ajax({  
		            url:'${pageContext.request.contextPath}/view/admin/auth/user/Do-Validate.action',//先走校验的action   
		            //cache:false,        //拒绝缓存   
		            //async:false,        //异步提交   
		            type:"POST",          
		            data:"resId="+val,       
		            dataType:'text',  
		            success:function(obj){
		            	if(obj=="yes"){
		            		menuText.innerHTML = "该主账号已被使用，请重新输入";
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
    <form id="addForm" name="addForm"  action="${pageContext.request.contextPath}/view/admin/auth/user/Do-add.action" method="post" > 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增用户信息</th>
        		</tr>
        		<tr>
        			<td class="word">主帐号</td>
        			<td ><input id="accountCode" name="User!accountCode" onblur="validate(this.value)"  type="text" class="inputtext"   /> <font id="txt" class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">辅帐号1</td>
        			<td ><input id="accountSubcode1" name="User!accountSubcode1" class="inputtext" /></td>
        		</tr>
        		<tr>
        			<td class="word">辅帐号2</td>
        			<td ><input  id="accountSubcode2" name="User!accountSubcode2" class="inputtext" /> </td>
        		</tr> 
        		<tr>
        			<td class="word">手机号码</td>
        			<td >
        				<input type="text" id="phone" name="User!phone" class="inputtext"/>
        			</td>
        		</tr>
        		<tr>
        			<td class="word">电子邮箱</td>
        			<td >
        				<input type="text" id="email" name="User!email" class="inputtext"/>
        			</td>	
        		</tr>
        		<tr>
        			<td class="word">昵称</td>
        			<td >
	        			 <input type="text" id="nickname" name="User!nickname" class="inputtext"/>
        			</td>
        		</tr>
        		<tr>
        			<td class="word">姓名</td>
        			<td ><input type="text"  id="chineseName" name="User!chineseName" class="inputtext" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">出生日期</td>
        			<td >
        				<input id="birthday" name="User!birthday" type="text" style="height: 17px;" class="Wdate inputtext"
							onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',maxDate: '%y-%M-%d' })"
								value="${birthday}" />
        			</td>
        		</tr>
        		<tr>
        			<td class="word">帐号类型</td>
        			<td >
        				<tag:select id="type" name="User!type" dictCode="dictionary.auth.userAccount.type" checkValue="AD100103"/> <font class="fontredcolor">&nbsp;*</font>
        		    </td>
        		</tr>
        		<tr>
        			<td class="word">帐号状态</td>
        			<td >
        				<tag:select id="state" name="User!state" dictCode="dictionary.auth.userAccount.status" checkValue="AD100201"/> <font class="fontredcolor">&nbsp;*</font>
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
