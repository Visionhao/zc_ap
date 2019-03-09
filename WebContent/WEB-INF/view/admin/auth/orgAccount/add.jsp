<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>新增机构账户</title>
      <%@include file="import.jsp" %>
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
			
			 //机构编号
			 jQuery("#orgId").formValidator().inputValidator({
	              min:1,
	              max:32,
	              type:"size",
	              onerror:"不能为空或长度不对，长度为1~32个字符"
	           });
			 
			 //机构名称
			 jQuery("#orgChnName").formValidator().inputValidator({
		           min:1,
		           max:100,
		           type:"size",
		           onerror:"不能为空或长度不对，长度为1~100个字符"
		        });
		   
		     //机构账户名
			  jQuery("#accountCode").formValidator().inputValidator({
		           min:1,
		           max:20,
		           type:"size",
		           onerror:"不能为空或长度不对，长度为1~20个字符"
		        });
		     
			//授权账号数量
			  jQuery("#grantAccountNum").formValidator().regexValidator({ 
				   regexp:regexEnum.intege1,
				   onerror:"格式不正确,请输入正确数量"
				});
			//账户状态
			jQuery("#state").formValidator().inputValidator({
				   min:1,
		           onerror:"请选择帐户状态"
			});
		     
   });
	function addPage(){
		var url = "${pageContext.request.contextPath}/view/admin/auth/orgAccount/Do-addPage.action";
		window.location.href = url;
		window.opener.location.reload();
	}
	function doSave(){
		opt="doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该机构编号已被使用，请重新输入"){
			jQuery("#addForm").submit();
		}
	}
	function doSaveToAdd(){
		opt = "doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该机构编号已被使用，请重新输入"){
			jQuery("#addForm").attr("action", "${pageContext.request.contextPath}/view/admin/auth/orgAccount/Do-saveToAdd.action");;
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
    	var id = document.getElementById('orgId');
    	if(id.value!=""){
			$.ajax({  
		            url:'${pageContext.request.contextPath}/view/admin/auth/orgAccount/Do-Validate.action',//先走校验的action   
		            //cache:false,        //拒绝缓存   
		            //async:false,        //异步提交   
		            type:"POST",          
		            data:"resId="+val,       
		            dataType:'text',  
		            success:function(obj){
		            	if(obj=="yes"){
		            		menuText.innerHTML = "该机构编号已被使用，请重新输入";
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
    <form id="addForm" name="addForm"  action="${pageContext.request.contextPath}/view/admin/auth/orgAccount/Do-add.action" method="post" > 
     
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增机构账户</th>
        		</tr>
        		
        		<tr>
        			<td class="word">机构编号</td>
        			<td ><input id="orgId" name="OrgAccount!orgId" type="text" onblur="validate(this.value)" class="inputtext" /> <font id="txt" class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		
        		<tr>
        			<td class="word">机构名称</td>
        			<td ><input id="orgChnName" name="OrgAccount!orgChnName"   type="text" class="inputtext"   /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		
        		<tr>
        			<td class="word">机构账户名</td>
        			<td ><input id="accountCode" name="User!accountCode" class="inputtext" readonly="readonly" style="background-color: #F5F5F5;" value="admin"/> </td>
        		</tr>
        		
        		<tr>
        			<td class="word">联系人</td>
        			<td ><input  id="principal" name="OrgAccount!principal" class="inputtext" /></td>
        		</tr>
        		
        		
        		<tr>
        			<td class="word">联系电话</td>
        			<td ><input type="text" id="contactPhone" name="OrgAccount!contactPhone" class="inputtext"/></td>
        		</tr>
        		
        		<tr>
        			<td class="word">电子邮箱</td>
        			<td >
        				<input type="text" id="contactEmail" name="OrgAccount!contactEmail" class="inputtext"/>
        			</td>
        		</tr>
        		
        		<tr>
        			<td class="word">授权账号数量</td>
        			<td >
	        			<input type="text" id="grantAccountNum" name="OrgAccount!grantAccountNum" class="inputtext" /> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>
        		
        		<tr>
        			<td class="word">账户状态</td>
        			<td>
        				<tag:select  id="state" name="OrgAccount!state" dictCode="dictionary.auth.userAccount.orgStatus" checkValue="AD100301"/> <font class="fontredcolor">&nbsp;*</font>	
					</td>
        		</tr>
        		
        	</tbody>
        </table>
          <div class="btnbox">
          <a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp;置</a>
          <a class="confirmBtn" title="保 存并新增"  id="save-btn" href="###" onclick="javascript:doSaveToAdd()">保存并新增</a>
          <a class="confirmBtn" title="保 存"  id="save-btn" href="###" onclick="javascript:doSave()">保 &nbsp;存</a>
          </div>   
      </form>
      
    </body>
</html>
