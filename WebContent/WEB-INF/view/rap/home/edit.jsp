<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改成员信息页面</title>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<%@ include file="import.jsp"%>
<link href="<%=request.getContextPath() %>/view/rap/css/index/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

jQuery(document).ready(function(){
	 jQuery.formValidator.initConfig({
       formid: "editMemberForm",
       submitonce: true,
       onerror: showCustomErrors,
        onsuccess:function(){
      	 validate=true;
	 			var options = {
	 				 success : function(obj){
	 					 if(obj=="yes"){
	 						alert("修改密码成功，重新登录生效");
	 						closeWin();
	 					 }
	 				 },		
	 			     type:"post",                     
	 			     resetForm : true
	 			};  
	 			jQuery("#editMemberForm").ajaxSubmit(options);
	 			return false;
        }
   });
	 jQuery("#oldPwd").formValidator().inputValidator({
        min:1,
        onerror:"请输入原密码"
     }).ajaxValidator({
         async : true,
         url : "<%=request.getContextPath() %>/view/rap/home/MemberLoginAction-validatePwd.action", 
         success : function(data){
             if( data == "0" ) {
            	 return true;
             }else{
           	  //alert('输入的密码不正确');
           	  //jQuery("#pwd").val("");
             }
             },
         onerror : "原密码不正确，请重新输入。",
         onwait : "正在进行合法性校验，请稍候..."
 });
	 
	 jQuery("#newPwd").formValidator().inputValidator({
        min:1,
        onerror:"请输入新密码"
     });
	 jQuery("#pass").formValidator().inputValidator({
        min:1,
        onerror:"请再次输入新密码"
     }).compareValidator({desid:"newPwd",operateor:"=",onerror:"两次输入的新密码不一致,请确认"});
}); 

	//修改成功关闭页面
	function closeWin(){
		window.close();	
	    window.opener.location.reload();		
	}

	function success(mass){
		var show_img = document.getElementById("show_img");
		var fileName = document.getElementById("file").value;
		if(mass=='yes'){
			$("#massage").text("");
			$("#photo").hide();
			var spath = show_img.src="<%=request.getContextPath()%>/files/"+fileName;
			if(spath){
       			var array = new Array();
               	array = fileName.split("\\");
               	var name = array[array.length-1];
                //ie
                if (window.navigator.userAgent.indexOf("MSIE")>=1){
                	show_img.src="<%=request.getContextPath()%>/files/"+name;
                }
                //firefox
                else if(window.navigator.userAgent.indexOf("Firefox")>=1){
                	show_img.src="<%=request.getContextPath()%>/files/"+fileName;
                }
                //goolge
                else if(window.navigator.userAgent.indexOf("Chrome")>=1){
                	show_img.src="<%=request.getContextPath()%>/files/"+name;
                }
		  	}
		}else{
			show_img.src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${membersView.membersId }";
			$("#massage").show();
			$("#massage").css("color","red");
			
			$("#photo").hide();
			$("#massage").text(mass);
		}
	};
	${path};
	
	function doSave(){
		jQuery("#editMemberForm").submit();
	}
	function reset(){
		jQuery("#editMemberForm")[0].reset();
	}  

</script>
</head>
<body>
	<form id="uploadFileForm" name="uploadFileForm" enctype="multipart/form-data" action="<%=request.getContextPath()%>/view/rap/home/MemberLoginAction-upload.action" method="post" target="hidden_iframe">
				<table style="margin-left: 0px;float:left;width:100%;margin-top:10px;">
					<tr>
						<td style="text-align:center;" width="100px;">成员头像:</td>
						<td>
							<div style="margin-left:40px;">
								<a id="img_show" href="javascript:void(0)" title="上传图片"><img id="show_img" alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${membersView.membersId }" width="70px" height="70px" style="z-index: 1;position: absolute;"/><input type="file" id="file" accept="image/*" onchange="document.forms[0].submit();" class="hidden_input" name="file"/></a>
							</div>
							<div id="photo" class="uploadphoto">
								<div id="ti"><span class="tiMess">点击上传图片</span><br><div style="width: 360px;margin-left:90px;">尺寸80px*80px,大小2Mb以内,支持jpg、png或gif等格式</div></div>
							</div>
							<div class="uploadphoto">
								<div class="massage" id="massage"></div>
							</div> 
						</td> 
						
					</tr>
				</table>
			</form>
			<iframe name="hidden_iframe" id="hidden_iframe" style="display:none;"></iframe>
			
			<form id="editMemberForm" name="editMemberForm" action="${pageContext.request.contextPath}/view/rap/home/MemberLoginAction-edit.action" method="post">
				<input style="display: none" id="memberId" name="memberId" type="text" value="<c:out value="${membersView.membersId }"></c:out>"/>
				
				<table style="font-size:13px;line-height: 45px;margin-top: 50px;margin-left: 10px;float:left">
					<tr>
						<td style="text-align: right;">原&nbsp;密&nbsp;码：</td>
						<td style="width:400px;height:40px;"><input type="password" id="oldPwd" name="Password" value="" onfocus="this.value=''" style="width: 180px;height: 20px;float:left;margin-left:20px;"/></td>
					</tr>
					<tr>
						<td style="text-align: right;">设置新密码：</td>
						<td style="width:400px;height:40px;"><input type="password" id="newPwd" onfocus="this.value=''" style="width: 180px;height: 20px;float:left;margin-left:20px;"/></td>
					</tr>
					<tr>
						<td style="text-align: right;">重置新密码：</td>
						<td style="width:400px;height:40px;"><input type="password" name="newPassword" onfocus="this.value=''" id="pass" style="width: 180px;height: 20px;float:left;margin-left:20px;"/></td>
					</tr> 
				</table>
		     	<div class="btnbox">
		          <a  title="保 存"  id="save-btn" href="javascript:void(0)" onclick="javascript:doSave()">保&nbsp;存</a>
		          <a  title="重置"  id="save-btn1" href="javascript:void(0)" onclick="javascript:reset()">重&nbsp;置 </a>
	         	</div> 
		    </form>
</body>
</html>