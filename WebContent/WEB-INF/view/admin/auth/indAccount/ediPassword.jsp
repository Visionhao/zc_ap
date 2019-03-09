<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="import.jsp" %>
<html>
<head>
<title>修改密码</title>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
 	 	<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/widget/select/jQuery.FillOptions.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css">
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
	 						alert("修改密码成功，重新登录生效");
	 						refresh();
	 					 }
	 				 },		
	 			     type:"post",                     
	 			     resetForm : true
	 			};  
	 			jQuery("#editForm").ajaxSubmit(options);
	 			return false;
         }
    });
	 jQuery("#pwd").formValidator().inputValidator({
         min:1,
         onerror:"请输入原密码"
      }).ajaxValidator({
          async : true,
          url : "<%=request.getContextPath() %>/view/admin/auth/indAccount/Do-checkPwd.action", 
          success : function(data){
              if( data == "0" ) {return true;}else{
            	 // alert('输入的密码不正确');
            	 //jQuery("#pwd").val("");
              }
              },
          onerror : "原密码不正确，请重新输入。",
          onwait : "正在进行合法性校验，请稍候..."
  });
	 
	 jQuery("#pwd1").formValidator().inputValidator({
         min:1,
         onerror:"请输入新密码"
      });
	 jQuery("#pass").formValidator().inputValidator({
         min:1,
         onerror:"请再次输入新密码"
      }).compareValidator({desid:"pwd1",operateor:"=",onerror:"两次输入的新密码不一致,请确认"});
});
	function doSave(){
		jQuery("#editForm").submit();
	}
	function reset(){
		jQuery("#editForm")[0].reset();
	} 
	function refresh(){
		var url = "${pageContext.request.contextPath}/view/admin/home/logout.action";
		window.location.href=url;
	}
</script>
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
</head>
<body>
	<div id="addr-nav" class="addr-nav">
			<ul style="padding-left: 0px;margin-top: 20px;">
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-main.action">基本信息</a></li>
				<li class="on"><a href="#">修改密码</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editcontactInforPage.action">联系方式</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editsetSecurityPage.action">帐号安全</a></li>
			</ul>
	</div>
	<p>
	<form id="editForm" name="editForm" action="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editPassword.action" method="post">
		<input type="hidden" id="systemUserId" name="User!systemUserId" value="<c:out value="${User.systemUserId}"></c:out>" />
			<table style="font-size:13px;line-height: 35px;margin-top: 50px;margin-left: 80px;">
				<tr>
					<td style="text-align: right;">原密码：</td>
					<td><input type="password" id="pwd" name="Password" value="" onfocus="this.value=''" style="width: 180px;height: 20px;"/></td>
				</tr>
				 <tr>
					<td style="text-align: right;">设置新密码：</td>
					<td><input type="password" id="pwd1" onfocus="this.value=''" style="width: 180px;height: 20px;"/></td>
				</tr>	
				<tr>
					<td style="text-align: right;">重置新密码：</td>
					<td><input type="password" name="newPassword" onfocus="this.value=''" id="pass" style="width: 180px;height: 20px;"/></td>
				</tr>  
			</table>
		
		<div class="btnbox">
          <a class="confirmBtn"  style="float: left;" title="重置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp;置</a>
          <a class="confirmBtn"  style="float: left;" title="保 存"  id="save-btn" href="###" onclick="javascript:doSave()">保 &nbsp;存</a>
        </div>	
	</form>
</body>
</html>