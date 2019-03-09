function search(obj){
	$(obj).val("");
	$(obj).css('color','black');
}
//搜索框移出
function out(value){
	if(!value){
		$("#search-input").val('搜索');
		$("#search-input").css('color','#ddd');
	}else{
		$("#search-input").css('color','#000');
	}
}

//跳转到新增成员界面
function addMember(){
	$("#right_label").hide();
	$("#right_add").show(); 
	var s = document.getElementById("right_label").style.display;
	if(s=="none"){
		 $(".unbanked").click(function(){
			 $("#right_label").show();
			 $("#right_add").hide(); 
		 }); 
		 $(".members").click(function(){
			 $("#right_label").show();
			 $("#right_add").hide(); 
		 }); 
	}
}

function setLink(obj){
	$(obj).parent().find("span").hide();
	$(obj).parent().find("input").show();
	$(obj).parent().find("input").focus();
}
//新增时的重置操作
function reset(){
	$("#state").val('-1');
	jQuery("#addForm")[0].reset();
}

//判断两次输入的密码是否一致
function judgePwd(obj){
	var pwd = $("#passWord").val();
	var mesg = document.getElementById("mesg");
	if(obj!=''){
		if(obj!=pwd){
			mesg.innerHTML= "两次密码输入不一致，请重新输入";
		}else{
			mesg.innerHTML = "&nbsp;*";
		}
	}else{
		mesg.innerHTML= "请再次输入密码";
	}
}

//保存
function doSave(){
	opt="doSave";
	var menuText = document.getElementById('menutext').innerHTML;
	var menuText1 = document.getElementById('menutext1').innerHTML;
	//判断上传的图片是否会报错
	var text = document.getElementById("messagePictrue").innerHTML;
	//判断输入的密码是否错误
	var mesg = document.getElementById("mesg").innerHTML;
	
	if(menuText == "该工号已被使用，请重新输入" && menuText1 =="该姓名已被使用，请重新输入"){
	    return false;
	}else if(text =="上传的文件太大！" || text =="上传的图片格式不对！" || text =="上传的图片高度和宽度不对！"){
		return false;
	}else if(mesg == "请再次输入密码" || mesg == "两次密码输入不一致，请重新输入"){
		return false;
	}else{
		jQuery("#addForm").submit();
	}
}
//保存并新增
function saveToAdd(){
	opt="doSave";
	var menuText = document.getElementById('menutext').innerHTML;
	var menuText1 = document.getElementById('menutext1').innerHTML;
	//判断上传的图片是否会报错
	var text = document.getElementById("messagePictrue").innerHTML;
	//判断输入的密码是否错误
	var mesg = document.getElementById("mesg").innerHTML;

	if(menuText == "该工号已被使用，请重新输入" && menuText1 =="该姓名已被使用，请重新输入"){
	    return false;
	}else if(text =="上传的文件太大！" || text =="上传的图片格式不对！" || text =="上传的图片高度和宽度不对！"){
		return false;
	}else if(mesg == "请再次输入密码" || mesg == "两次密码输入不一致，请重新输入"){
		return false;
	}else{
		jQuery("#addForm").submit();
	}
}


//查询成员状态的方法
function showSate(state){
	var as = $(".rig_select ul li a");
	for(var i = 0 ; i < as.length ; i++){
		$(as[i]).css({"z-index":3-i});
	}
	if(state=='XF003001'){
		$(".online").css({"z-index":"4"});
		$(".rig_select").css("border-bottom","3px solid #66CBFF");
	}else if(state=='XF003002'){
		$(".leave").css({"z-index":"4"});
		$(".rig_select").css("border-bottom","3px solid #FF9900");
	}else if(state=='XF003003'){
		$(".nojoin").css({"z-index":"4"});
		$(".rig_select").css("border-bottom","3px solid #CD99FF");
	}else{
		$(".all_member1").css({"z-index":"4"});
		$(".rig_select").css("border-bottom","3px solid #66CD66");
	}
	onloadList(state,groupId_all,"");
}

//新增成员小组是出现的input
function addGroup(){
	var saveGroup="saveGroup";
    $("#leftUl").append(
		"<li class=\"unbankeds\">"+
    		"<form class=\"addGroup\">"+
    			"<input style=\"margin-top:18px\" id=\"groupAdd\" type=\"text\" onblur='validateGroup(this.value)' name='group.groupName'/>"+
    		"</form>"+
		"</li>"
    );
    $("#groupAdd").focus();
}
//新增成员小组的保存操作
function saveGroup(){
		if($("#groupAdd").val()!=""){
			 var params = $(".addGroup").serialize();
			 $.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-addGroup.action",params,function(obj){
				 refresh();
			 });
		}
}
//校验组名是否唯一
function validateGroup(val) {
		var id = document.getElementById('groupAdd');
		var len = document.getElementById('groupAdd').value.length;
		if(len > 8){
			 mp_alter("提示","输入的字符不能超过16个！");
			 return ;
		}else if(id.value!=""){
			$.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-validateGroup.action",{"resId":val},function(obj){
			if(obj=="yes"){
				mp_alter("提示","组名已经存在！");
				return ;
	    	}else{
	    		saveGroup();
	    		return true;
	    	}
		});
	}else{
		$(".unbankeds").remove();
	}
};

//修改成员小组中出现input操作
function editGroup(id,obj){
	$("#n"+id).hide();
	//图片
	$("#e"+id).hide();
	$("#d"+id).hide();
	//文本框
	$("#h"+id).show();
	$("#h"+id).focus();
}
//异步修改成员小组保存的操作
function inputBlur(id){
	 var name = $("#h"+id).val();
	 $.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-editGroup.action",{"id":id,"name":name},function(data){
			$("#n"+id).show();
			$("#h"+id).hide();
			//图片
			$("#e"+id).show();
			$("#d"+id).show();
			$("#s"+id).text(name);
			//refresh();
	 });
}

//修改审核员所在的群组
function changeGroupName(groupId,membersId){
	$("#a"+membersId).hide();
	var gid="";
	$("#s"+membersId).append("<select id='group_"+membersId+"' style=\"width: 120px;height: 20px;\"  onblur=\"changeGroup('"+membersId+"')\">");
	 $.each($("#leftUl li"),function(index,value){
		 gid=$(this).attr("id");
		 if(gid.split(",")[0]==groupId){
			 $("#group_"+membersId).append("<option value="+gid.split(",")[0]+" selected=\"selected\">"+gid.split(",")[1]+"</option></select>");
		 }else{
		     $("#group_"+membersId).append("<option value="+gid.split(",")[0]+">"+gid.split(",")[1]+"</option></select>");
	      }
	 }); 
}
//修改成员所在的组的异步操作
function changeGroup(id){
	var gid=$("#group_"+id).val();
	$.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-editGroupName.action",{"membersView.membersId":id,"membersView.groupId":gid},function(data){
		$("#group_"+id).remove();
		$("#a"+id).show();
		refresh();
	});
}

//成员离线状态的修改
function pauseMember(obj){
	var parent = $(obj).parent().parent().parent().parent();
	var id = $(parent[0]).find("td div span.membersId")[0].innerHTML;
	if(id!=""){
		$.ajax({  
	            url:'${pageContext.request.contextPath}/view/rap/team/member/MemberAction-changeState.action',
	            type:"POST",          
	            data:"id="+id+"&tag=pauseMember",       
	            dataType:'text',  
	            success:function(obj){
	            	if(obj=="yes"){
	            		refresh();
	            	}else{
	            		mp_alter("提示","操作失败！");
	            		return false;
	            	}
	            }
	        }); 
	} 
};
//成员上线状态的修改
function joinMember(obj){
	var parent = $(obj).parent().parent().parent().parent();
	var id = $(parent[0]).find("td div span.membersId")[0].innerHTML;
	if(id!=""){
		$.ajax({  
	            url:'${pageContext.request.contextPath}/view/rap/team/member/MemberAction-changeState.action',
	            type:"POST",          
	            data:"id="+id+"&tag=joinMember",       
	            dataType:'text',  
	            success:function(obj){
	            	if(obj=="yes"){
	            		refresh();
	            	}else{
	            		mp_alter("提示","操作失败！");
	            		return false;
	            	}
	            }
	        }); 
	}
};
//成员退出状态的修改
function exitMember(obj){
	var parent = $(obj).parent().parent().parent().parent();
	var id = $(parent[0]).find("td div span.membersId")[0].innerHTML;
	if(id!=""){
		$.ajax({  
	            url:'${pageContext.request.contextPath}/view/rap/team/member/MemberAction-changeState.action',
	            type:"POST",          
	            data:"id="+id+"&tag=exitMember",       
	            dataType:'text',  
	            success:function(obj){
	            	if(obj=="yes"){
	            		refresh();
	            	}else{
	            		mp_alter("提示","操作失败！");
	            		return false;
	            	}
	            }
	        }); 
	} 
};

function deleteM(obj){
	if(window.confirm('你确定要删除应用吗？')){
		deleteMember(obj);
		return true; 
	}else{
		return ;
	}
	
}

//删除成员
function deleteMember(obj){
	var parent = $(obj).parent().parent().parent().parent();
	var id = $(parent[0]).find("td div span.membersId")[0].innerHTML;
	if(id!=""){
		$.ajax({  
	            url:'${pageContext.request.contextPath}/view/rap/team/member/MemberAction-changeState.action',
	            type:"POST",          
	            data:"id="+id+"&tag=",       
	            dataType:'text',  
	            success:function(obj){
	            	if(obj=="yes"){
	            		refresh();
	            	}else{
	            		mp_alter("提示","操作失败！");
	            		return false;
	            	}
	            }
	        }); 
	} 
};

//删除组的操作
function deleteGroup(id){
	$.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-delete.action",{"id":id},function(obj){
		mp_alter2("提示","你确定要删除该组吗？删除组后该组成员会移到未分组中！",refresh);
	 });
}

//查询时按entry键触发的查询功能
document.onkeydown=function(event){
	 var e = event || window.event || arguments.callee.caller.arguments[0];
	 if(e && e.keyCode==13){ // enter 键
		if($("#search-input").val()==""){
			onloadList('','','');
		}else{
			onloadList('','',$("#search-input").val());
		}
	 }
 }; 
 
 //点击工号时触发
 function ondown(obj){
	if($(obj).val()=='该工号可以用于成员的登录'){
		$(obj).val('');
		obj.style.color = "#bfbfbf";
	}else{
		obj.style.color = "#000000";
	}
 }
 
 //校验工号是否已经存在
 function validates(val) {
		var menuText = document.getElementById('menutext');
		var id = document.getElementById('jobNumber');
		if(id.value!=""){
		id.style.color = "#000000";
		$.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-validates.action",{"resId":val},function(obj){
			if(obj=="yes"){
    		menuText.innerHTML = "该工号已被使用，请重新输入";
    	}else{
    		menuText.innerHTML = "&nbsp;*";
    	}
		});
	}
};


function onPwd(obj){
	if($(obj).val()=='该手机号码可以用于成员的登录'){
		$(obj).val('');
		obj.style.color = "#bfbfbf";
	}else{
		obj.style.color = "#000000";
	}
}

function onPass(obj){
	if($(obj).val()==''){
		$(obj).val('该手机号码可以用于成员的登录');
		obj.style.color = "#bfbfbf";
	}else{
		obj.style.color = "#000000";
	}
}

//校验姓名是否存在
function validateName(val) {
	var menuText1 = document.getElementById('menutext1');
	var id = document.getElementById('chnName');
	if(id.value!=""){
	$.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-validateName.action",{"resId":val},function(obj){
		if(obj=="yes"){
    		menuText1.innerHTML = "该姓名已被使用，请重新输入";
    	}else{
    		menuText1.innerHTML = "&nbsp;*";
    	}
	});
	}
};



