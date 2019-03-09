<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>审核成员</title>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script src="${pageContext.request.contextPath}/view/rap/js/member/jquery-ui-1.8.23.custom.min.js"></script>
<link href="<%=request.getContextPath() %>/view/rap/css/member/member.css" rel="stylesheet" type="text/css" />
<%@ include file="import.jsp"%>
<script type="text/javascript">
    	var groupId_all="";
		jQuery(document).ready(function() {
			jQuery.formValidator.initConfig({
				formid : "addForm",
				submitonce : true,
				onerror : showCustomErrors,
				onsuccess : function() {
					validate = true;
					var options = {
						success : function(obj){
		 			    	 if(obj=='yes'){
		 			    		 refresh();
		 			    	 }else if(obj=='no'){
		 			    		 mp_alter("提示","添加失败！");
		 			    	 }else if(obj=='1'){
		 			    		 mp_alter("提示","添加成功！");
		 			    	 }else if(obj=='0'){
		 			    		 mp_alter("提示","添加失败！");
		 			    	 }
		 			     },
						type : "post",
						resetForm : true
					};
					jQuery("#addForm").ajaxSubmit(options);
					return false;
				}
			});
			  //工号
			   jQuery("#jobNumber").formValidator().inputValidator({
				   min: 1,
		           max:32,
		           type:"size",
		           onerror:"不能为空或长度不对,长度为1~32个字符"
		        });
			   //姓名
			   jQuery("#chnName").formValidator().inputValidator({
				   min: 1,
		           max:16,
		           type:"size",
		           onerror:"不能为空或长度不对,长度为1~16个字符"
		        });
			   //密码
			   jQuery("#passWord").formValidator().inputValidator({
				   min: 1,
		           max:20,
		           type:"size",
		           onerror:"不能为空或长度不对,长度为1~20个字符"
		        });
			 	//手机号码
			 	jQuery("#mobilePhone").formValidator().inputValidator({
         			min:1,
         			onerror:"不能为空"
      			}).regexValidator({
		   			regexp: regexEnum.mobile,
	        		onerror:"格式不对,请输入正确的手机号码"
	      		});
			 	
	   });
		
		$(function(){
		 	$('.label_title,.label_title_none').click(function(){
				$(".members").removeClass("members").addClass("unbanked");
				$(this).parent().removeClass("unbanked").addClass("members");  
			}); 
		});
		
		//新增保存的刷新页面
		function refresh(){
			var url = "${pageContext.request.contextPath}/view/rap/team/member/MemberAction-main.action";	
		    window.location.href = url;	
		}
		
		//遍历成员的详细信息(状态,组ID,工号或者名称的查询)
		function onloadList(state,groupId,chnName){
			groupId_all=groupId;
			var funName1="";
			var funName2="";
			var funName3="";
			var Name1="";
			var Name2="";
			var picColor="";
			var onStyle1="";
			var onStyle2="";
			$("#member_list").html("");
		 	$.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-list.action",{"membersView.state":state,"membersView.groupId":groupId,"membersView.chnName":chnName},function(list){
	            	$.each(list,function(index,value){
	            		if(value.state=="正常"){
	            			picColor="online_pic";
	            			funName1="pauseMember";
	            			funName2="exitMember";
	            			funName3="changeGroupName";
	            			Name1="暂停";
	            			Name2="退出";
	            			onStyle1="state_z";
	            			onStyle2="state_t";
	            		}else if(value.state=="暂停"){
	            			picColor="leave_pic";
	            			funName1="joinMember";
	            			funName2="exitMember";
	            			funName3="changeGroupName";
	            			Name1="正常";
	            			Name2="退出";
	            			onStyle1="state_j";
	            			onStyle2="state_t";
	            		}else{
	            			picColor="nojoin_pic";
	            			funName1="joinMember";
	            			funName2="deleteM";
	            			funName3="changeGroupName";
	            			Name1="加入";
	            			Name2="删除";
	            			onStyle1="state_j";
	            			onStyle2="state_t";
	            		}
	            		$("#member_list").append(
	            				"<div class=\"mem_detail\" id="+value.membersId+" >"+
								"<table>"+
			    					"<tr>"+   
			          					"<td>"+
			          						"<div style=\"width: 110px;height: 185px;\">"+
			          							"<img alt='正在加载..' onerror='this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'' src='<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id="+value.membersId+"' width='70px' height='70px' style=\"margin-top:60px;margin-left:18px;vertical-align: middle;\"/>"+
			          						"</div>"+
			          					"</td>"+
										"<td class=\"list_msg\">"+
											"<div style=\"display: none\">"+"<span class=\"membersId\">"+value.membersId+"</span></div>"+
											"<div class='"+picColor+"'>"+"</div>"+"<div class=\"massage_name\">"+"<span>"+value.jobNumber+"</span>&nbsp;&nbsp;<span>"+value.chnName+"</span></div>"+
											"<div class='massage' id=s"+value.membersId+">"+"<span id=a"+value.membersId+">"+value.groupName+"<a title=\"修改群组\"  href='javascript:void(0)' class=\"rightdirection\"  onclick=\""+funName3+"('"+value.groupId+"','"+value.membersId+"')\"></a></span></div>"+
											"<div class=\"massage\">"+value.dates+"&nbsp;加入"+"</div>"+
											"<div class=\"massage\">"+"<span>"+"<a class="+onStyle1+" href='javascript:void(0)' onclick=\""+funName1+"(this)\">"+Name1+"</a></span><span>&nbsp;&nbsp;&nbsp;"+"<a class="+onStyle2+" href=\"javascript:void(0)\" onclick=\""+funName2+"(this)\">"+Name2+"</a></span></div>"+
										"</td>"+
			          				"</tr>"+  
								"</table>"+
							"</div>"
	            		);
	            	});
	            	$(function(){
	    				var count=$(".membersId").length;
	    				var hpx="";
	    				var member_list="";
	    				if((count/3) > 3){
	    					hpx=parseInt(count)*90+"px";
	    					member_list = parseInt(count)*80+"px";
	    					$("#total").css("height",hpx);
	    					$("#member_list").css("height",member_list);
	    				}else{
	    					$("#total").css("height","700px");
	    					$("#member_list").css("height","600px");
	    				}
	    			});
	         });	
		}
		 
		$(function(){
			$(".unbanked").droppable();
			
			$("#leftUl").sortable({ 
				stop: function(event, ui) {
					var gid="";
					 $("#group_div").html("");
					 $.each($("#leftUl li"),function(index,value){
						 gid=$(this).attr("id");
						  $("#group_div").append("<input type='hidden' name='groupList["+index+"].groupId' value="+gid.split(",")[0]+" />"
								               +"<input type='hidden' name='groupList["+index+"].groupName' value="+gid.split(",")[1]+" />"
								               +"<input type='hidden' name='groupList["+index+"].seq' value="+(index+1)+" />"); 
					 });
					var params = $("#group_from").serialize();
					$.post("${pageContext.request.contextPath}/view/rap/team/member/MemberAction-sortGroup.action",params,function(){});
			     } 
			}); 
			
		});
		
		
		 function success(messagePictrue){
			var img_pictrue = document.getElementById("img_pictrue");
			var fileName = document.getElementById("file").value;
			if(messagePictrue=='yes'){
				$("#messagePictrue").text("");
				$("#pictrue").hide();
				var spath = img_pictrue.src="<%=request.getContextPath()%>/files/"+fileName;
				if(spath){
		   			var array = new Array();
		           	array = fileName.split("\\");
		           	var name = array[array.length-1];
		            //ie
		            if (window.navigator.userAgent.indexOf("MSIE")>=1){
		            	img_pictrue.src="<%=request.getContextPath()%>/files/"+name;
		            }
		            //firefox
		            else if(window.navigator.userAgent.indexOf("Firefox")>=1){
		            	img_pictrue.src="<%=request.getContextPath()%>/files/"+fileName;
		            }
		            //goolge
		            else if(window.navigator.userAgent.indexOf("Chrome")>=1){
		            	img_pictrue.src="<%=request.getContextPath()%>/files/"+name;
		            }
			  	}
			}else{
				img_pictrue.src="<%=request.getContextPath()%>/view/rap/images/member/headpic.gif";
				$("#messagePictrue").show();
				$("#messagePictrue").css("color","red");
				
				$("#pictrue").hide();
				$("#messagePictrue").text(messagePictrue);
			} 
		}
		${uploadPathName};
		
		
</script>		
</head>
<body onload="onloadList('','','')">
	<div id="total">
		<div class="head" align="center"><div style="padding-top: 10px;">审核成员管理<span style="float: right;text-align: center;font-size: 12px;margin-top:10px;margin-right:10px;font-family: fantasy;">欢迎您&nbsp;&nbsp;${memberName}</span></div></div>
	
		<!-- left -->
		<div class="left_label" align="left">
			<div class="left_label_tal">
				<div class="left_label_total">
					<img style="padding-left: 40px;" src="${pageContext.request.contextPath}/view/rap/images/member/group.png" onclick="javascript:addGroup()" title="新增群组">
				</div>
				<div class="left_label_total1">
					<img style="padding-left: 20px;" src="${pageContext.request.contextPath}/view/rap/images/member/member.png" onclick="javascript:addMember()"  title="新增成员">
				</div>
			</div>
			
			<div class="search">
				<input class="search_inp" type="text" maxlength="10" onfocus="search(this);" id="search-input" onblur="out(this)"  name="QT_jobNumber" value="搜索"> 
			</div>
			
			<div class="left_bottom">
			<form id="group_from"><div id="group_div"></div></form>
			  <ul>
			    <li class="members" onclick="onloadList('','','')" id="m_all"><div class="label_title_none" >所有成员&nbsp;(${allCount})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div><div class="baseline"></div></li>
			  </ul>
				<ul id="leftUl">
					<c:forEach items="${group}" var="entry" varStatus="sta">
						<c:if test="${entry.groupName=='未分组'}">
							<li class="unbanked" id="${entry.groupId},${entry.groupName}"  onclick="onloadList('','${entry.groupId}','')"><div class="label_title_none">${entry.groupName}&nbsp;(${entry.count})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></li><div class="baseline"></div>
						</c:if>
						<c:if test="${entry.groupName!='未分组'}">
		        			<li class="unbanked" id="${entry.groupId},${entry.groupName}" onclick="onloadList('','${entry.groupId}','')">
			        			<div class="label_title" id="n${entry.groupId}" >
			        				<span id="s${entry.groupId}">${entry.groupName}</span>(${entry.count})
			        			</div>
			        			<input style="display:none;" name="MembersGroup!groupName" value="${entry.groupName}" id="h${entry.groupId}" onblur="inputBlur('${entry.groupId}')"/>
			        			<a class="edit_img"  href="javascript:void(0)" id="e${entry.groupId}">
			        				<img onclick="editGroup('${entry.groupId}',this)" src="${pageContext.request.contextPath }/view/rap/images/member/edit.png"/>&nbsp;&nbsp;
			        			</a>
			        			<a class="delete_img" href="javascript:void(0)" id="d${entry.groupId}" >
			        				<img onclick="deleteGroup('${entry.groupId}')" src="${pageContext.request.contextPath }/view/rap/images/member/delete.png"/>
			        			</a> 
		        			</li>
		        			<div class="baseline"></div>
       					</c:if>
       				</c:forEach> 
				</ul>
			</div>
		</div>
		
		<!-- right -->
		<div id="right_label">
				<div class="rig_tal">
					<div class="rig_select">
						<ul>
							<li><a href="javascript:showSate('')" id="all_member1" class="all_member1"></a></li>
							<li><a href="javascript:showSate('XF003001')" id="online" class="online"></a></li>
							<li><a href="javascript:showSate('XF003002')" id="leave" class="leave"></a></li>
							<li><a href="javascript:showSate('XF003003')" id="nojoin" class="nojoin"></a></li>
						</ul>
					</div>
				</div>	
				
				<div id="member_list"></div>
		</div>
	
		<!-- add -----right -->
		<div id="right_add">
			<div class="add_tal">
				<div class="add_select">
					<ul>
						<li><a href="javascript:void(0)" id="add_member1" class="add_member1"></a></li>
						<li><a href="javascript:void(0)" id="channel_member" class="channel_member"></a></li>
					</ul>
				</div>
			</div>	
			
			<div class="member_add">
				<form id="uploadFileForm" name="uploadFileForm" enctype="multipart/form-data" action="<%=request.getContextPath()%>/view/rap/team/member/MemberAction-upload.action" method="post" target="hidden_iframe">
					<table class="table_add">
						<tr>
							<td align="right" style="width: 65px;height: 80px;">成员头像</td>
							<td>
								<div style="margin-left: 25px;">
									<a class="a_pictrue" href="javascript:void(0)">
										<img id="img_pictrue" alt="正在加载..." src="<%=request.getContextPath()%>/view/rap/images/member/headpic.gif"/>
										<input type="file" id="file" name="file" accept="image/*" onchange="document.forms[1].submit()" class="hidden_file"/>
									</a>
									
								</div>
								<div id="pictrue" class="uploadPictrue">
									<div id="tishi"><span class="tiMess">点击上传图片</span><br/><div style="width: 350px;">尺寸80px*80px,大小2Mb以内,支持jpg、png或gif等格式</div></div>
								</div>
								<div class="uploadPictrue">
									<div id="messagePictrue" class="messagePictrue"></div>
								</div>
							</td>
						</tr>
					</table>
				</form>
				<iframe id="hidden_iframe" name="hidden_iframe" style="display: none;"></iframe>
				<form name="addForm" id="addForm" action="${pageContext.request.contextPath}/view/rap/team/member/MemberAction-save.action" method="post">
					<table class="table_add">
						<tr>
							<td align="right">工号</td>
							<td class="td_style"><input type="text" id="jobNumber" name="Members!jobNumber" class="add_int" onblur="validates(this.value)" style="color: #bfbfbf" onfocus="ondown(this)" value="该工号可以用于成员的登录"/><font id="menutext" class="fontcolor">&nbsp;*</td>
						</tr>
						<tr>
							<td align="right">姓名</td>
							<td><input type="text" id="chnName" name="Members!chnName" class="add_int" onblur="validateName(this.value)"/><font id="menutext1" class="fontcolor">&nbsp;*</td>
						</tr>
						<tr>
							<td align="right">手机号码</td>
							<td><input type="text" id="mobilePhone" name="Members!mobilePhone" class="add_int" onfocus="onPwd(this)" onblur="onPass(this)" style="color: #bfbfbf" value="该手机号码可以用于成员的登录"/><font class="fontcolor">&nbsp;*</td>
						</tr>
						<tr>
							<td align="right">密码</td>
							<td><input type="password" id="passWord" class="add_int" name="Members!passWord"/><font class="fontcolor">&nbsp;*</td>
						</tr>
						<tr>
							<td align="right">确认密码</td>
							<td><input type="password" id="truepassWord" class="add_int" onblur="judgePwd(this.value)"/><font class="fontcolor" id="mesg">&nbsp;*</td>
						</tr>
						
						<tr>
							<td align="right">选择分组</td>
							<td>
								<select id="groupId" name="MembersGroup!groupId" class="add_int">
							        <c:forEach  items="${groupList}" var="entry" varStatus="sta">
							            <option value="${entry.groupId}">${entry.groupName}</option> 								
								    </c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td align="right">备注</td>
							<td><input type="text" id="remark" name="Members!remark" class="add_int"/></td>
						</tr>
						<tr>
							<td colspan="2"><p class="td_p"></p></td>
						</tr>
						<tr>
							<td align="right" colspan="2">
								<div class="btnbox">
							          <a  title="重 置" id="reset-btn" href="javascript:void(0)" onclick="javascript:reset()">重&nbsp; 置</a>
							          <a  title="保 存"  id="save-btn1" href="javascript:void(0)" onclick="javascript:doSave()">保 &nbsp;存</a>
							          <a  title="保 存并新增"  id="save-btn" href="javascript:void(0)" onclick="javascript:saveToAdd()">保存并新增</a>
	         					</div> 
         					</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>