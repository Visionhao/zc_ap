<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@include file="import.jsp" %>
<html>
<head>
<title>联系方式</title>
<link href="${pageContext.request.contextPath}/view/admin/this.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css">
<style type="text/css">
a{
	text-decoration: none;
}	
.addr-nav {
    border-bottom: 1px solid #d5d5d9;
    border-left: 1px solid #d5d5d9;
    height: 30px;
    margin: 40px -20 0 20px;
    font-size: 12px;
    font-weight: bold;
} 
.addr-nav ul {left: 0;top: 0;height: 31px; list-style-type:none;}
.addr-nav ul li{float: left;border-right: 1px solid #d5d5d9;border-top: 1px solid #d5d5d9;background-color: #efefef;border-bottom: 1px solid #d5d5d9;}
.addr-nav ul li a{padding:0 12px;display: inlne-block;height: 29px;line-height: 29px;color: #333;}
.addr-nav ul li a:hover{text-decoration: none;}
.addr-nav ul li.on{border-bottom: 1px solid #FFF;background-color: #FFF;}	
</style>
<script type="text/javascript">
var opt = "doSave";
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
		 					refresh();
	 					 }else{
	 						alert("修改失败");
	 					 }
	 				 },		
	 			     type:"post",                     
	 			     resetForm : true
	 			};  
	 			jQuery("#editForm").ajaxSubmit(options);
	 			return false;
         }
    });
	 /* jQuery("#phone").formValidator().inputValidator({
         min:1,
         onerror:"不能为空"
      }).regexValidator({
		   regexp: regexEnum.mobile,
	         onerror:"格式不对,请输入正确的手机号码"
	      });
	 //if(!documnet.getElementById("email").value==""){
		 jQuery("#email").formValidator().regexValidator({
			   regexp: regexEnum.email,
	         onerror:"格式不对,请输入正确的邮箱"
	      }); 
	// } */
});
function doSave(){
	jQuery("#editForm").submit();
}
function reset(){
	jQuery("#editForm")[0].reset();
} 
function refresh(){
	var url = "${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editcontactInforPage.action";
	window.location.href=url;
}
</script>
</head>
<body>
	<div id="addr-nav" class="addr-nav">
			<ul style="padding-left: 0px;margin-top: 20px;">
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-main.action">基本信息</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editPasswordPage.action">修改密码</a></li>
				<li  class="on"><a href="#">联系方式</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editsetSecurityPage.action">帐号安全</a></li>
			</ul>
	</div>
	<p>
	<form id="editForm" name="editForm" action="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editcontactInfor.action" method="post">
		<input type="hidden" id="systemUserId" name="User!systemUserId" value="<c:out value="${User.systemUserId}"></c:out>" style="width: 180px;height: 20px;"/>
			<table style="font-size:13px;line-height: 35px;margin-top: 50px;margin-left: 80px;">
				<tr>
					<td style="text-align: right;">联系电话：</td>
					<td><input type="text" id="phone" name="User!phone" style="width: 180px;height: 20px;" value="<c:out value="${User.phone}"></c:out>" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">电子邮箱：</td>
					<td><input type="text" id="email" name="User!email" style="width: 180px;height: 20px;" value="<c:out value="${User.email}"></c:out>"/></td>
				</tr>	
			</table>
		
		<div class="btnbox">
          <a class="confirmBtn"  style="float: left;" title="重置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp;置</a>
          <a class="confirmBtn"  style="float: left;" title="保 存"  id="save-btn" href="###" onclick="javascript:doSave()">保 &nbsp;存</a>
        </div>	
	</form>
</body>
</html>