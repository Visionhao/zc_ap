<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="tag" uri="/uap-tags"%>
<html>
<head>
<title>查询条件</title>
<%@ include file="import.jsp"%>
<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/common/navigation.css"  rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resource/tools/common/navigation.js"></script>
<script type="text/javascript">
			function del(ids){
				$.ajax({  
		            url:'${pageContext.request.contextPath}/view/admin/auth/user/Do-delete.action',//先走校验的action   
		            type:"POST",          
		            data:"id="+ids,       
		            dataType:'text',  
		            success:function(obj){
		            	if(obj=="yes"){
		            		alert("删除成功");
		            		refresh();
		            	}else{
		            		alert("删除失败");
		            	}
		            }
		        });
			}
			function mp_confirm(title,content,height,ids){
				mp_confirm_base(title,content);
				 $("#dialog-confirm").dialog({
						resizable: false,
						height:height,
						modal: true,
						buttons: {
							'确定': function() {
								$(this).dialog('close');
								del(ids);
							},
							'取消': function() {
								$(this).dialog('close');
							}
						}
					});
			}
			function reset(){
				$("#QT_type").val('-1');
				$("#QT_state").val('-1');
				var   e=document.getElementsByTagName("input"); 
			    for(var   i=0;i <e.length;i++) 
			    { 
			        if   (e[i].type== "text") 
			        { 
			            e[i].value = '';
			        } 
			    } 
			}
			function checkTheForm(){
				document.UserForm.submit();
			}
			function showCondition(){
				document.getElementById("condition").style.display="block";
				document.getElementById("down").style.display="none";
				document.getElementById("up").style.display="block";
			}
			function hidenCondition(){
				document.getElementById("condition").style.display="none";
				document.getElementById("down").style.display="block";
				document.getElementById("up").style.display="none";
			}
			function checkCondition(obj){
				if(!document.getElementById("chk1").checked &&
						  !document.getElementById("chk2").checked && 
						  !document.getElementById("chk3").checked &&
						  !document.getElementById("chk4").checked &&
						  !document.getElementById("chk5").checked &&
						  !document.getElementById("chk6").checked &&
						  !document.getElementById("chk7").checked){
							 mp_alter("提示","至少选择保留一个条件");
							 document.getElementById(obj.id).checked=true;
							return ;
						}
				if(obj.id=="chk1"){
					if(document.getElementById("chk1").checked){
						document.getElementById("con1").style.display="block";
					}
					if(!document.getElementById("chk1").checked){
						document.getElementById("con1").style.display="none";
					}
				}
				if(obj.id=="chk2"){
					if(document.getElementById("chk2").checked){
						document.getElementById("con2").style.display="block";
					}
					if(!document.getElementById("chk2").checked){
						document.getElementById("con2").style.display="none";
					}
				}
				if(obj.id=="chk3"){
					if(document.getElementById("chk3").checked){
						document.getElementById("con3").style.display="block";
					}
					if(!document.getElementById("chk3").checked){
						document.getElementById("con3").style.display="none";
					}
				}
				if(obj.id=="chk4"){
					if(document.getElementById("chk4").checked){
						document.getElementById("con4").style.display="block";
					}
					if(!document.getElementById("chk4").checked){
						document.getElementById("con4").style.display="none";
					}
				}
				if(obj.id=="chk5"){
					if(document.getElementById("chk5").checked){
						document.getElementById("con5").style.display="block";
						document.getElementById("QT_type").disabled=false;
					}
					if(!document.getElementById("chk5").checked){
						document.getElementById("con5").style.display="none";
						document.getElementById("QT_type").disabled=true;
					}
				}
				if(obj.id=="chk6"){
					if(document.getElementById("chk6").checked){
						document.getElementById("con6").style.display="block";
						document.getElementById("QT_state").disabled=false;
					}
					if(!document.getElementById("chk6").checked){
						document.getElementById("con6").style.display="none";
						document.getElementById("QT_state").disabled=true;
					}
				}
				if(obj.id=="chk7"){
					if(document.getElementById("chk7").checked){
						document.getElementById("con7").style.display="block";
					}
					if(!document.getElementById("chk7").checked){
						document.getElementById("con7").style.display="none";
					}
				}
			}
			function out(){
				document.getElementById("condition").style.display="none";
				document.getElementById("down").style.display="block";
				document.getElementById("up").style.display="none";
			}
			function over(){
				document.getElementById("condition").style.display="block";
				document.getElementById("down").style.display="none";
				document.getElementById("up").style.display="block";
			}
			function getIfrmaeCheckValue(objThis,iframeName,checkName,opt){
				var skip = 0;
				var modifyUrl = "${pageContext.request.contextPath}/view/admin/auth/user/Do-editPage.action?id=";
				var ids = "";
				 var iframeObject = window.frames[iframeName];
				 var itemsObj = iframeObject.document.getElementsByName(checkName);
				 for(var i = 0;i<itemsObj.length;i++){
					 if(itemsObj[i].checked==true){
						 if((opt=='edit' || opt=='show') && skip>0){
							 mp_alter("提示","每次只能操作一条记录");
							return ;
						 }else{
							 ids += itemsObj[i].value + ",";
						 }
						 skip++;
					 }
				 }
				 if(ids == ""){
					 mp_alter("提示","请选择一条记录");
					 return ;
				 }
				 ids = ids.substring(0,ids.length-1);
				 var comp = modifyUrl+ids;
				 if(opt=='delete'){
					 mp_confirm('确认提示','是否删除该信息?',180,ids);
				 }
				 if(opt=='edit'){
					 openwindow(comp,'修改用户信息',600,550);
				 }
				 if(opt=='show'){
					 var url = "${pageContext.request.contextPath}/view/admin/auth/user/Do-show.action?id="+ ids;
	            	 openwindow(url,'查看用户信息',600,550); 
				 }
			}
			$(function() {	
				$("#add-info").click(
						function() {
							openwindow('${pageContext.request.contextPath}/view/admin/auth/user/Do-addPage.action','新增用户信息',600,550); 
						});
			});
			function refresh(){
				var url = "${pageContext.request.contextPath}/view/admin/auth/user/Do-main.action";				
				window.location.href=url;
			}
</script>
</head>
<body id="main_body">
<form name="UserForm" action="<%=request.getContextPath()%>/view/admin/auth/user/Do-list.action" method="post" target="mainFrame">
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table width="100%">
	<tr valign="top" >
		<td valign="top" >
		<table id="searchArea" width="100%" >
			<tr>
				<td valign="top">
				<div class="search-condition clearfix">
			      	<div class="search-table" >
			      	<div id="con1"><div class="field">主帐号</div><input type="text" class="txt-input" id="QT_accountCode" name="QT_accountCode" style="width:180px" /></div>
			        <div id="con2"><div class="field">辅帐号1</div><input type="text" class="txt-input" id="QT_accountSubcode1" name="QT_accountSubcode1" style="width:180px"/></div>
			        <div id="con3"><div class="field">辅帐号2</div><input type="text" class="txt-input" id="QT_accountSubcode2" name="QT_accountSubcode2" style="width:180px" /></div>
			        <div id="con4" style="display: none"><div class="field">姓名</div><input type="text" class="txt-input" id="QT_chineseName" name="QT_chineseName" style="width:180px" /></div>
			        <div id="con5" style="display: none"><div class="field">帐号类型</div><tag:select id="QT_type" name="QT_type" dictCode="dictionary.auth.userAccount.type"/></div>
			        <div id="con6" style="display: none"><div class="field">帐号状态</div><tag:select  id="QT_state" name="QT_state" dictCode="dictionary.auth.userAccount.status"/></div>
			        <div id="con7" style="display: none;width: 650px;">
				        <div style="width: 300px;float: left;"><div class="field">开通时间（起）</div>
				        	<input style="height: 19px;width: 184px;" type="text" class="Wdate" id="QD_startDate" name="QD_created" onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'QD_endDate\')||\'2020-10-01\'}'})" />
				        </div>
				         <div><div class="field">开通时间（止）</div>
				        	<input style="width: 184px;height: 19px;" type="text" class="Wdate" id="QD_endDate" name="QD_endcreated" onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'QD_startDate\')}',maxDate:'2020-10-01'})" />
				        </div>
			        </div> 
			    	<div id="condition"  onmouseout="javascript:out()" onmouseover="javascript:over()" class="tout-chose" style="display:none;">
			      		<table border="0" class="other-chose">
			      			<tr>
			      				<td><input type="checkbox" checked id="chk1" onClick="javascript:checkCondition(this)" name="QT_accountCode"/><label for="chk1">主帐号</label></td>
		      				</tr>
			      			<tr>
			      				<td><input type="checkbox" checked id="chk2"  onClick="javascript:checkCondition(this)" name="QT_accountSubcode1" /><label for="chk2">辅帐号1</label></td>
		      				</tr>
			      			<tr>
			      				<td><input type="checkbox" checked id="chk3" onClick="javascript:checkCondition(this)" name="QT_accountSubcode2"/><label for="chk3">辅帐号2</label></td>
			      			</tr>
			      			<tr>
                                <td><input type="checkbox" id="chk4"  onClick="javascript:checkCondition(this)" name="QT_chineseName"  /><label for="chk4">姓名</label></td>
		      				</tr>
			      			<tr>
			      				<td><input type="checkbox" id="chk5" onClick="javascript:checkCondition(this)"  /><label for="chk5">帐号类型</label></td>
		      				</tr>
		      				<tr>
			      				<td><input type="checkbox"  id="chk6" onClick="javascript:checkCondition(this)"  /><label for="chk6">帐号状态</label></td>
		      				</tr>
		      				<tr>
			      				<td><input type="checkbox" id="chk7" onClick="javascript:checkCondition(this)" /><label for="chk7">开通时间</label></td>
		      				</tr>
			      		</table>
			      </div>
			        <div class="btn-s"><a id="down" style="display: block" href="javascript:showCondition()" title="更多" class="more-icon">&nbsp;</a> <a id="up" style="display: none" href="javascript:hidenCondition()" title="收回" class="up-iocn">&nbsp;</a> <a href="###" title="清空" class="clear-icon" onClick="javascript:reset()">&nbsp;</a></div>
			         </div>
			      </div>
			      <div class="clear"></div>
				 <div class="search-tool">
          			<span class="tool">
	          			<a href="#"  id="add-info"  title="新增"  class="icon-new"></a>
	          			<a href="#" title="修改" onClick="getIfrmaeCheckValue(this,'mainFrame','items','edit')"  class="icon-edit"></a>
	          			<a href="#" title="查看" onClick="getIfrmaeCheckValue(this,'mainFrame','items','show')"  class="icon-show"></a>
	          			<a href="#" title="刷新"  class="icon-refresh" onClick="refresh()"></a>
	          			<a href="#" title="删除" onClick="getIfrmaeCheckValue(this,'mainFrame','items','delete')" class="icon-delete"></a>
          			</span>
          			<span class="search-btn"><a href="javascript:checkTheForm()" title="查询" class="icon-search"></a></span>
       				 </div>
			  </td>
			 </tr>
			</table>
			</td>
			</tr>
			<tr>
				<td valign="top"><iframe id="mainFrame" name="mainFrame"
					src="<%=request.getContextPath()%>/view/admin/auth/user/Do-list.action?ajax=true"
					width='100%' height='450' frameborder="0"></iframe></td>
			</tr>
		</table>
		</form> 
</body>
</html>
