//进行点击输入用户名输入框方法。
function ondown(obj){
	if($(obj).val()=='请输入工号或手机号码'){
		$(obj).val('');
		obj.style.color = "#bfbfbf";
	}
}
   
//进行离开输入用户名输入框方法。
function onAdd(obj){
	if($(obj).val()==''){
		obj.style.color = "#bfbfbf";
		$(obj).val("请输入工号或手机号码");
	}else{
		obj.style.color = "#565656";
	}
}

//进行输入密码判断方法。
function onPwd(obj){
	if($(obj).val()=='请输入密码'){
		$(obj).val('');
		obj.type = "password";
	}
}

//进行离开输入密码输入框方法。	
function onPass(obj){
	if($(obj).val()==''){
		$(obj).val('请输入密码');
		obj.type = "text";
		obj.style.color = "#bfbfbf";
	}else{
		obj.style.color = "#565656";
	}
}

function membersLogin(){
	var val = $("#memberName").val();
	var pwd = $("#passWord").val();
	if(val!=''&&val != '请输入工号或手机号码' ){
		$("#memberName_mass").text("");
		if(pwd != ''&& pwd !='请输入密码'){
			$("#passWord_mass").text("");
			$.ajax({  
	            url:'${pageContext.request.contextPath}/view/rap/home/MemberLoginAction-membersLogin.action',
	            type:"POST",          
	            data:{"QT_chnName":val,"QT_passWord":pwd},       
	            dataType:'text',  
	            success:function(obj){
	           		if(obj=='yes'){
	           			refresh();
	           		}else{
		            	$("#error_hint").text('工号或手机号码或密码错误，请重新输入');
		            	return false;
	            	} 
	            }
			});  
	}else{
		$("#passWord_mass").text("请输入密码");}
	}else{
		if(val ==''||val == '请输入工号或手机号码') $("#memberName_mass").text("请输入工号或手机号码");
		if(pwd ==''||pwd =='请输入密码') $("#passWord_mass").text("请输入密码");
	}
}

//按entry键登录
document.onkeydown=function(event){
	 var e = event || window.event || arguments.callee.caller.arguments[0];
	 if(e && e.keyCode==13){ // enter 键
		 membersLogin();
	 }
}; 