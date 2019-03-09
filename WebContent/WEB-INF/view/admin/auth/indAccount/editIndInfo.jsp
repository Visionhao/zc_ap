<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="import.jsp" %>
<html>
<head>
<title>修改个人帐号信息</title>
<link href="${pageContext.request.contextPath}/view/admin/this.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePicker.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePickerJavaAdaptor.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css">
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
	 jQuery("#individualName").formValidator().inputValidator({
           min: 1,
           max:16,
           type:"size",
           onerror:"不能为空或长度不对,长度为1~16个字符"
        });
	});
	function doSave(){
		jQuery("#editForm").submit();
	}
	function reset(){
		jQuery("#editForm")[0].reset();
	} 
	function refresh(){
		var url = "${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-main.action";
		window.location.href=url;
	}
</script>
<style type="text/css">
a{
	text-decoration: none;
}
table{
	padding-left: 25px;

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
				<li class="on"><a href="#">基本信息</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editPasswordPage.action">修改密码</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editcontactInforPage.action">联系方式</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editsetSecurityPage.action">帐号安全</a></li>
			</ul>
	</div>
	<p>
	<form id="editForm" style="margin-top: 15px;" name="editForm" action="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editIndInfo.action" method="post" >
			<input type="hidden" id="individualId" name="Individual!individualId"  value="<c:out value="${Individual.individualId}"></c:out>"/>
			<input type="hidden" name="User!systemUserId"  value="<c:out value="${user.systemUserId}"></c:out>"/>
			<table style="line-height: 35px;font-size:13px;">
				<tr>
					<td style="text-align: right;">姓 名：</td>
					<td><input type="text" id="individualName" name="User!chineseName" style="width: 180px;height: 20px;" value="<c:out value="${ user.chineseName}"></c:out>"/> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
				<tr>
					<td style="text-align: right;">性 别：</td>
					<td>
						<input  id="Individual!gendernan" name="Individual!gender" ${ Individual.gender=='男'?'checked':''} value="男" type="radio"  />
        				<label for="Individual!gendernan">男</label>  
						<input  id="Individual!gendernan" name="Individual!gender" ${ Individual.gender=='女'?'checked':''} value="女" type="radio"  />
        				<label for="Individual!gendernan">女</label>  
						<input  id="Individual!gendernan" name="Individual!gender" ${ Individual.gender=='保密'?'checked':''} value="保密" type="radio"  />
        				<label for="Individual!gendernan">保密</label>  
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">婚姻状况：</td>
					<td>
						<input  id="Individual!maritalStatusYes" name="Individual!maritalStatus" ${ Individual.maritalStatus=='已婚'?'checked':''} value="已婚" type="radio"  />
        				<label for="Individual!maritalStatusYes">已婚</label>  
        				<input  id="Individual!maritalStatusNo" name="Individual!maritalStatus"  ${ Individual.maritalStatus=='未婚'?'checked':''}  value="未婚" type="radio" /> 
        				<label for="Individual!maritalStatusNo">未婚</label>
        				<input  id="Individual!maritalStatusBm" name="Individual!maritalStatus"  ${ Individual.maritalStatus=='保密'?'checked':''}  value="保密" type="radio" /> 
        				<label for="Individual!maritalStatusBm">保密</label>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">出生日期：</td> 
					<td>
						<input id="birthday" name="Individual!birthday" style="width: 180px;height: 20px;" class="Wdate" value="<fmt:formatDate value="${Individual.birthday }"></fmt:formatDate>"
						onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',maxDate: '%y-%M-%d'})"/>
                    </td>
				</tr>
				<tr>
					<td style="text-align: right;">宗 教：</td>
					<td><input type="text" id="religion" style="width: 180px;height: 20px;" name="Individual!religion" value="<c:out value="${Individual.religion}"></c:out>"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">民 族：</td>
					<td>
						<tag:select  id="nation" name="Individual!nation" dictCode="dictionary.auth.indAccount.nation" checkValue="${Individual.nation }"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">教育水平：</td>
					<td>
						<tag:select  id="educationLevel" name="Individual!educationLevel" dictCode="dictionary.auth.indAccount.educationLevel" checkValue="${Individual.educationLevel}"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">国 籍：</td>
					<td><input type="text" id="nationality"  name="Individual!nationality" style="width: 180px;height: 20px;" value="<c:out value="${Individual.nationality}"></c:out>"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">单 位：</td>
					<td><input type="text" id="employer" name="Individual!employer" style="width: 180px;height: 20px;" value="<c:out value="${Individual.employer}"></c:out>"/></td>
				</tr>
			</table>
		
		<div class="btnbox">
          <a class="confirmBtn"  style="float: left;" title="重置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp;置</a>
          <a class="confirmBtn"  style="float: left;" title="保 存"  id="save-btn" href="###" onclick="javascript:doSave()">保 &nbsp;存</a>
        </div> 
	</form>
</body>
</html>