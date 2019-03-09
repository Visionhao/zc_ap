<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css"	href="${pageContext.request.contextPath}/view/admin/css/login.css"	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css" />
<title>登陆页面</title>
<script type="text/javascript">
var loginFail = '<%=request.getAttribute("loginFail")%>';

jQuery(document).ready(function(){
	 jQuery.formValidator.initConfig({
	        formid: "loginForm",
	        submitonce: true,
	        onerror: showCustomErrors,
	         onsuccess:function(){
	       	 validate=true;
		    }
	    });
	 
	 if(loginFail=="F"){
			jQuery("#div1").css('display','none'); 
			document.getElementById("userAccountName").disabled=true;
			document.getElementById("userPassword").disabled=true;
			jQuery("#div2").css('display','block'); 
			jQuery("#code").formValidator().inputValidator({
		           min:1,
		           max:4,
		           type:"size",
		           onerror:"请输入正确的校验码"
		        });
			jQuery("#name").formValidator().inputValidator({
		           min:1,
		           max:20,
		           type:"size",
		           onerror:"不能为空，请输入用户名"
		        });
			jQuery("#pwd").formValidator().inputValidator({
		           min:1,
		           max:16,
		           type:"size",
		           onerror:"不能为空，请输入密码"
		        });
		 }else{
			jQuery("#div2").css('display','none'); 
			document.getElementById("name").disabled=true;
			document.getElementById("pwd").disabled=true;
			jQuery("#div1").css('display','block'); 
			jQuery("#userAccountName").formValidator().inputValidator({
		           min:1,
		           max:20,
		           type:"size",
		           onerror:"不能为空，请输入用户名"
		        });
			jQuery("#userPassword").formValidator().inputValidator({
		           min:1,
		           max:16,
		           type:"size",
		           onerror:"不能为空，请输入密码"
		        });
		 } 
});

function login() {
	 var loginFail = '<%=request.getAttribute("loginFail")%>';
	 if(loginFail=="F"){
		jQuery("#loginForm").attr("action", "${pageContext.request.contextPath}/view/admin/home/login.action?withCode=true");
	 }
	jQuery("#loginForm").submit();
}
document.onkeydown = function(e){
	if(e.keyCode==13){
		document.getElementById("login_a").click(); 
	}
}
function changeCode(obj) {    
	/***
	  *   获取当前的时间作为参数，无具体意义   
	  *   每次请求需要一个不同的参数，否则可能会返回同样的验证码    
	  *   这和浏览器的缓存机制有关系，也可以把页面设置为不缓存，这样就不用这个参数了。  
	  */
	var timenow = new Date().getTime();    
	   
	obj.src= "<%=request.getContextPath() %>/randCode.action?d="+timenow;    
	} 
</script>
</head>

<body>

	<div class="kuang"></div>
	<form id="loginForm" name="loginForm" action="${pageContext.request.contextPath}/view/admin/home/login.action"  method="post">
		<div id="div1" class="logo" style="display: block">
			<p class="titile" align="center">
				帐号登录 <img class="fen" src="${pageContext.request.contextPath}/view/admin/images/login/fen.png" style="border: none;" /> <img class="fen02"
					src="${pageContext.request.contextPath}/view/admin/images/login/fen02.png" style="border: none;" />
			</p>
			<div class="tips"><font color="red"> ${mesg }</font></div>
			<div class="input_div_div" style="display: none">
				<div class="input_titel"><label>组织号</label></div>
				<div class="input_div">
					<input type="text" onFocus="this.value=''" name="orgAccountId" value="QY-10001" 	onBlur="if(!value){value=defaultValue;}"  />
				</div>
			</div>
			<div class="input_div_div1">
				<div class="input_titel">帐户名</div>
				<div class="input_div">
					<input type="text" id="userAccountName" onFocus="this.value=''" name="userAccountName" />
				</div>
			</div>
			<div class="input_div_div1">
				<div class="input_titel">密&nbsp;码</div>
				<div class="input_div">
					<input type="password" id="userPassword" name="userPassword" />
				</div>
			</div>
			<div class="input_div_pass1">
				<div class="input_rem"><input class="jz" type="checkbox"/>&nbsp;记住密码</div>
				<div class="input_forget">忘记密码？</div>
			</div>
			<div class="DL" align="center"><a id="login_a" onclick="javascript:login(); ">登录</a></div>
			</div>
			<div id="div2" class="logo" style="display: none">
			<p class="titile" align="center">
				帐号登录 <img class="fen" src="${pageContext.request.contextPath}/view/admin/images/login/fen.png" style="border: none;" /> <img class="fen02"
					src="${pageContext.request.contextPath}/view/admin/images/login/fen02.png" style="border: none;" />
			</p>
			<div class="tips"><font color="red"> ${mesg }</font></div>
			<div class="input_div_div" style="display: none">
				<div class="input_titel"><label>组织号</label></div>
				<div class="input_div">
					<input type="text" onFocus="this.value=''" name="orgAccountId" value="QY-10001" 	onBlur="if(!value){value=defaultValue;}"  />
				</div>
			</div>
			<div class="input_div_div">
				<div class="input_titel">帐户名</div>
				<div class="input_div">
					<input type="text" id="name" onFocus="this.value=''" name="userAccountName"/>
				</div>
			</div>
			<div class="input_div_div">
				<div class="input_titel">密&nbsp;码</div>
				<div class="input_div">
					<input type="password" id="pwd" name="userPassword"/>
				</div>
			</div>
			<div class="input_div_div">
				<div class="input_titel">验&nbsp;证&nbsp;码</div>
				<div class="input_div_code">
					<input type="text" id="code"  name="code" class="codeText" />
					<img src="${pageContext.request.contextPath}/randCode.action" id="codeImg" class="codeImg" onclick="changeCode(this)" title="点击图片刷新验证码"/>
					<img src="${pageContext.request.contextPath}/view/admin/images/login/reload.png" class="codeReLo" onclick="changeCode(codeImg)" />
				</div>
			</div>
			<div class="input_div_pass">
				<div class="input_rem"><input class="jz" type="checkbox"/>&nbsp;记住密码</div>
				<div class="input_forget">忘记密码？</div>
			</div>
			<div class="DL" align="center"><a id="login_a" onclick="javascript:login(); ">登录</a></div>
			</div>
	</form>
</body>
</html>
