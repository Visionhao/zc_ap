<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>审核工作台(排雷)</title>
<%@ include file="./import.jsp"%>
<script type="text/javascript">
$(function() {
	initView();
}); 


//标签名称(01 端口标签,02内容标签,03号码标签,04行为标签)type_code=XF0033  
//标签标识(01 端口投诉风险 02 近3个月投诉次数03动机分类 04敏感词 05内容相似标识  06号码总量07投放省量 08地市数量  09投诉号码个数)type_code=XF0034   
////1预警任务 2 正常任务  3我投票 4我求帮助  5别人投票给我的任务  6.别人求我帮助的任务
function initView(){
	//$("#checkBox").attr("class","box ticked");
	$(".sms_div").remove();
	$(".baseline").remove();
	var style='style=display:none;';
	var showResult ='style=color:red;';
	var showStyle='style=cursor:pointer;';
 	$.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditMineAction-membersAuditTask.action",function(auditTaskList){
    	$.each(auditTaskList,function(index,value){
			//预警任务
    	 	 if(value.decideType==1){
    			appendTask(1,value,'lingxing_hong','25px;','60px;',style,showStyle,showStyle,showStyle,'发起投票','求帮助','','chk_list');
			}else if(value.decideType==2){//2 正常任务
				appendTask(2,value,'lingxing_hui','75px;','10px;',style,showStyle,showStyle,showStyle,'发起投票','求帮助','','chk_list');
			}else if(value.decideType==3){//3我投票
				appendTask(3,value,'lingxing_huang','48px;','37px;',showResult,showStyle,style,style,'发起投票','求帮助','','chk_list');
			}else if(value.decideType==4){//我求帮助
				appendTask(4,value,'lingxing_huang','48px;','37px;',showResult,showStyle,style,style,'发起投票','求帮助','','chk_list');
			}else if(value.decideType==5){//别人投票给我的任务
				appendTask(5,value,'lingxing_huang','48px;','37px;',style,style,style,style,'投票','求帮助','','chk_list');
			}else if(value.decideType==6){//别人求我帮助的任务
				appendTask(6,value,'lingxing_huang','48px;','37px;',style,style,style,showStyle,'发起投票','帮助','style=visibility:hidden;','chk_list1');
			}  
    	}); 
	}); 
}	
	//value 任务对象  linxingClass菱形样式 leftLi1 第一个li左边的距离 
	//reslut 求帮助和投票的结果标签  fenCuo 分错标签 touPiao 投票标签 help求帮助标签
 	function appendTask(types,value,linxingClass,leftLi1,leftLi2,reslut,fenCuo,touPiao,help,touPiaoText,helpText,cheboxStyle,cheboxName){
 		var json = eval(value.decideMap);
 		$(".content_left_bottom").append("<div  class='sms_div'  id='big"+value.auditTaskId+"' >"+
                "<ul class='sms_ul'>"+
					  "<li id='msg"+value.auditTaskId+"' >"+value.msg+"</li>"+
					  "<li style='margin-left: 0px;'>"+
					        "<ul class='gouxuan_ul' >"+
						    "<li class='"+linxingClass+"' style='margin-left:"+leftLi1+"'><input  id='type"+value.auditTaskId+"' type='hidden' value="+types+"  /></li>"+
						    "<li style='margin-top: 1px;margin-left:"+leftLi2+"margin-right:14px;'><input type='checkbox' "+cheboxStyle+" checked='checked' name="+cheboxName+"  value="+value.auditTaskId+" /></li>"+   
						     "<font color='#FF6407'>"+value.createTime.split("T")[0]+"</font>"+
						     " <label>["+value.custName+"："+value.custGrade+"]</label>"+
						     " <label>["+json["XF003406"].reason+"]</label>"+
						     " <label>[总量："+json["XF003405"].reason+"]</label>"+
						     " <label>[当日已放："+value.reason+"]</label>"+
							"</ul>"+
					  "</li>"+ 
				      "<li><font color='#FF6407' style='margin-right: 18px;'>"+value.createTime.split("T")[1]+"</font>"+
				           "<label>[投诉风险："+json["XF003401"].reason+"]</label>"+
				           "<label "+reslut+">["+value.decideResult+"]</label>"+
				      "</li>"+ 
					  "<li style='text-align: left;padding-left: 50%'>"+
					       "<label class='detailslabel'  id='detail"+value.auditTaskId+"'  onclick=\"showDetail('"+value.auditTaskId+"',"+types+")\" >详情</label>"+
					       "<label "+fenCuo+" onclick=\"showTaskError('"+json["XF003406"].reason+"','"+value.auditTaskId+"')\"  >分错了</label>"+ 
					       "<label "+touPiao+"  onclick=\"showVoto('"+value.auditTaskId+"')\"  >"+touPiaoText+"</label>"+
					       "<label "+help+" onclick=\"showHelp('"+value.auditTaskId+"')\"   id='help"+value.auditTaskId+"' >"+helpText+"</label>"+
					  "</li>"+    
                "</ul>"+
                "</div><div class='baseline'></div>"); 
 	}
	
 	//标签标识(01 端口投诉风险 02 端口近3个月投诉次数03号码池离散度04动机离散度    05受众数量  06动机分类 07敏感词  08内容相似标识  09投诉号码个数)type_code=XF0034
	function getLaberName(key){
		var laberName={"XF003401":"端口投诉风险","XF003402":"近3个月投诉次数","XF003403":"号码池离散度",
			"XF003404":"动机离散度","XF003405":"受众数量","XF003406":"动机分类","XF003407":"敏感词","XF003409":"投诉号码个数"};
		return laberName[key];
	}
	
   //1预警任务 2 正常任务  3我投票 4我求帮助  5别人投票给我的任务  6.别人求我帮助的任务
   $(function(){
	   $(".ul_buttom li").click(function(){
			    var taskId='';
				var param='';
				var flag=0;
				var type='';
				var flag2=0;
				var className=$(this).attr("class");
				$.each($("input[name='chk_list']"),function(index,value){
					if($(this).attr("checked")=="checked"){
						taskId=$(this).val();
						type=$("#type"+taskId).val();
						param+=type+":"+taskId+",";
						if(type!="2"){
							flag2=1;
						}
						flag=1;
					}
				}); 
			
				if(flag==0){
				   mp_alter("提示","至少选择一条短信进行操作");
				}else if(flag2==1 && className=="skip" ){
				   mp_alter("提示","勾选短信中包含投票或者报警或者帮助短信不能跳过");
				}else{
					$("#paramValue").val(param);
					$("#paramClass").val(className);
					 mp_alter2("提示","是否要对勾选短信进行操作？",operations);
				}  
	   }); 
	
    }); 
    
  //批量操作
  function operations(){
	  $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-aduitOperation.action",{"auditTaskView.auditTaskId":$("#paramValue").val(),"auditTaskView.personDecide":$("#paramClass").val()},function(reslut){
			if(reslut=="ok"){
				initView();
			}else{
				 mp_alter("提示","操作失败请联系管理员");
			}
	  }); 
  } 


   //详情点击放行和拦截跳过操作
   function operation(id,type,opt){
	   var param=type+":"+id;
	    $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-aduitOperation.action",{"auditTaskView.auditTaskId":param,"auditTaskView.personDecide":opt},function(reslut){
			if(reslut=="ok"){
				componentCancel();
				initView();
			}else{
				 mp_alter("提示","操作失败请联系管理员");
			}
		}); 
	   
   }


//点击详情
 function showDetail(id,type){
 $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-showDetail.action",{"auditTaskView.auditTaskId":id,"auditTaskView.decideType":type},function(bean){
	 var json = eval(bean.decideMap);
	 var html="<div class='x_div_buttom' >"
     +"<ul class='x_ul_buttom' >"
     +" <li class='x_fang' title='放行' onclick=\"operation('"+id+"',"+type+",'fang')\"  ></li>"
     +"  <li class='x_skip' title='跳过' onclick=\"operation('"+id+"',"+type+",'skip')\" ></li>"
     +"  <li class='x_intercept' title='拦截' onclick=\"operation('"+id+"',"+type+",'intercept')\" ></li>"
     +"</ul></div>";  
    html+="<div  class='sms_div' style='text-align:left;'>"+
                "<ul class='detailUl'>"+
					  "<li>"+bean.msg+"</li>"+
					  "<li style='margin-left: 0px;'>"+
						     "<font color='#FF6407'>"+bean.createTime.split("T")[0]+"</font>"+
						     " <label>["+bean.custName+"："+bean.custGrade+"]</label>"+
						     " <label>["+json["XF003406"].reason+"]</label>"+
						     " <label>[总量："+json["XF003405"].reason+"]</label>"+
						     " <label>[当日已放："+bean.reason+"]</label>"+
					  "</li>"+ 
				      "<li><font color='#FF6407' style='margin-right: 20px;' >17:25:20</font>"+
				           "<label>[投诉风险：安全]</label>"+
				           "<label></label>"+
				      "</li>"+ 
             "</ul><div  class='detailsDiv'><div id='laber1' ><b>端口风险相关信息</b><br></div><div id='laber2'><b>内容相关度信息<br></b></div>"+
                   "<div id='laber3' ><b>行为相关度信息</b><br></div></div></div>";
	      showdialogComponent("任务详情",600,550,html);
	        $.each(bean.decideMap,function(index,value){
			 //端口标签
			 if(value.labelName=="XF003301"){
				 $("#laber1").append(""+getLaberName(value.labelId)+"："+value.reason+"<br>");
			 }else if(value.labelName=="XF003302" && value.labelId!="XF003408"){//内容标签
				$("#laber2").append(""+getLaberName(value.labelId)+"："+value.reason+"<br>");
			 }else if(value.labelName=="XF003303"){//行为标签
				$("#laber3").append(""+getLaberName(value.labelId)+"："+value.reason+"<br>");
			 }
		  });  
	        //如果不是正常短信没有跳过操作
	        if(type!="2"){
	        	$(".x_skip").css({"visibility":"hidden"});
	        }
  }); 
} 

function showVoto(id){
	$("#paramValue").val(id);
	mp_alter2("提示","是否要对改短信发起审核投票？",LaunchVoto);
}

//显示求帮助页面
function showHelp(id){
	if($("#help"+id).text()=='求帮助'){
	   var html="请选择求助对象：<select id='helpSelect' style='width:120px;'></select><div>";
	   mp_alter2("短信求助",html,help);
	   $("#paramValue").val(id);
	  $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-normalMembers.action",function(list){
		  $.each(list,function(index,value){
			  $("#helpSelect").append("<option value='"+value.membersId+"'>"+value.membersName+"</option>");
		  });
	  }); 
	}else{//帮助别人
		showHelpOthers(id);
	}
}

//求帮助
function help(){
	$.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-help.action",{"teamDecisions.auditTaskId": $("#paramValue").val(),"teamDecisions.membersId":$("#helpSelect").val()},function(reslut){
		if(reslut=="ok"){
			 componentCancel();
			 initView();
		}else{
			 mp_alter("提示","操作失败请联系管理员");
		}
	}); 
	  
}


//显示我帮助别人页面
function showHelpOthers(id){
	  var html="备注信息：<input type='text' style='width:200px;height:50px;' id='othersRemork' maxlength='100' /><div style='margin-top:8px;'>"+
	  "<span style='visibility:hidden' >ddddddd</span><input type='button' value='放行' onclick=\"helpOthers('"+id+"','00')\" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
	  "<input type='button' value='拦截' onclick=\"helpOthers('"+id+"','01')\" /></div>";
	  showdialogComponent("帮助别人",400,180,html);
	  
}

//帮助别人
function  helpOthers(id,op){
	$.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-helpOthers.action",{"teamDecisions.auditTaskId":id,"teamDecisions.decideBasis":$("#othersRemork").val(),"teamDecisions.decideResult":op},function(reslut){
		if(reslut=="ok"){
			 componentCancel();
			 initView();
		}else{
			 mp_alter("提示","操作失败请联系管理员");
		}
	}); 
}




//发起投票
function LaunchVoto(){
   $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-launchVotes.action",{"teamDecisions.auditTaskId":$("#paramValue").val()},function(reslut){
		if(reslut=="ok"){
			initView();
		}else{
			 mp_alter("提示","操作失败请联系管理员");
		}
	}); 
}


//显示分错了页面
function showTaskError(classType,id){
	$.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-isCorrect.action",{"auditTaskView.auditTaskId":id},function(reslut){	
		if(reslut=="ok"){
				var html="系统分类："+classType+"<div>纠正大类：<select id='bigClass' style='width:100px;' onchange='changeSmall()' ></select></div><div>纠正小类：<select id='smallClass' style='width:100px;'></select></div>";
				  mp_alter2("短信分类我来纠正",html,taskError);
				  $("#paramValue").val(id);
					$("#paramClass").val(classType);
				   $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-getBigClass.action",function(list){
					  $.each(list,function(index,value){
						  $("#bigClass").append("<option value='"+value.textcateId+"'>"+value.textcateName+"</option>");
					  });
					  changeSmall();
				  }); 
			}else{
				 mp_alter("提示","当前短信已纠正过");
			}
	});    
}

function changeSmall(){
	 $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-SmallClass.action",{"teamDecisions.auditTaskId":$("#bigClass").val()+""},function(textList){
		 $.each(textList,function(index,value){
			  $("#smallClass").append("<option value='"+value.textcateId+"'>"+value.textcateName+"</option>");
		  });
	}); 
}

//处理分错
function taskError(){
	var id=$("#paramValue").val();
	var msg=$("#msg"+id).text();
	var menClass=$("#bigClass").find("option:selected").text()+" "+$("#smallClass").find("option:selected").text();
	   $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTable/AuditTableAction-taskError.action",{"auditTaskView.auditTaskId":id,"auditTaskView.msg":msg,"auditTaskView.decideResult":$("#paramClass").val(),"auditTaskView.decideType":menClass},function(reslut){
	   }); 
}

</script>
</head>
<body>
  <div class="container">
		<div class="head" align="center"><div style="padding-top: 10px;">审核工作台(排雷)<span style="float: right;text-align: center;font-size: 12px;margin-top:10px;margin-right: 10px;font-family: fantasy;">欢迎您&nbsp;&nbsp;${memberName}</span></div></div>
		<input type="hidden" id="paramValue" />
		<input type="hidden" id="paramClass"  />
		<div class="content" id="conDiv">
		<!-- 左边审批短信和操作 -->
		   <div class="content_left" >
		      <!-- 操作和统计当前信息 -->
		       <div class="content_left_top">
		          <div class="div_top">
		           <ul class="ul_top" >
	               	   <li style="text-align: center;padding-top: 15px;">
			               <p style="margin-top: 1px;"><label>当前任务/今日已审</label></p>
			                <c:if test="${fn:length(membersTaskList)<1 && fn:length(taskSumList)>0}">
		         				<c:forEach items="${taskSumList }" var="entr" varStatus="status">
				         			<c:forEach items="${memberLogin }" var="ents" varStatus="vars">
			         					<c:if test="${entr.membersId == ents.membersId}">
								            <p style="margin-top: -9px;"><span>${entr.isLock}</span>/<span>0</span></p>
							            </c:if>
				         			</c:forEach>
				         		</c:forEach>	
				         	</c:if>
				         	
				         	<c:if test="${fn:length(membersTaskList)>0 && fn:length(taskSumList)>0}">
			         			<c:forEach items="${membersTaskList }" var="entr" varStatus="vart">
			         				<c:forEach items="${taskSumList }" var="entry" varStatus="status">
					         			<c:forEach items="${loginMember }" var="ents" varStatus="vars">
				         					<c:if test="${entr.decideType == ents.decideType }">
									            <p style="margin-top: -9px;"><span>${entry.isLock}</span>/<span>${entr.custGrade}</span></p>
								           	</c:if>	
					         			</c:forEach>
					         		</c:forEach>	
				         		</c:forEach>	
				         	</c:if>
				         	
				         	<c:if test="${fn:length(membersTaskList)>0 && fn:length(taskSumList)<1}">
			         			<c:forEach items="${membersTaskList }" var="entr" varStatus="vart">
			         				
					         			<c:forEach items="${loginMember }" var="ents" varStatus="vars">
				         					<c:if test="${entr.decideType == ents.decideType }">
									            <p style="margin-top: -9px;"><span>0</span>/<span>${entr.custGrade}</span></p>
								           	</c:if>
					         			</c:forEach>
					         		
				         		</c:forEach>	
				         	</c:if>
				         	
				         	<c:if test="${fn:length(membersTaskList)<1 && fn:length(taskSumList)<1}">
				         		<p style="margin-top: -9px;"><span>0</span>/<span>0</span></p>
				         	</c:if> 
					   </li>
					   
	               	  <li style="text-align: center;padding-top: 15px;">
			                <p style="margin-top: 1px;"><label>看看他们</label></p>
			                	<c:if test="${fn:length(exceptTotalList)>0 && fn:length(exceptPassList)>0}">
					                <c:forEach items="${exceptTotalList}" var="ent" varStatus="var">
					         			<c:forEach items="${exceptPassList }" var="entr" varStatus="vart">
						         			<p style="margin-top: -9px;"><span>${ent.custGrade==null ?'0':ent.custGrade }</span>/<span>${entr.custGrade==null ? '0':entr.custGrade }</span>/<span>${ent.custGrade - entr.custGrade}</span></p>
						         		</c:forEach>	
				         			</c:forEach>
				         		 </c:if>
						</li>
		                <li>
		               		<label>总任务</label><div></div><label>
			               		<c:forEach items="${sumTaskList}" var="ent" varStatus="var">
			               			<span>${ent.membersId}</span>
			               		</c:forEach>	
		               		</label>
			            </li>
		           </ul>
		          </div>
		          <div class="baseline2"></div>
		          
		        <div class="div_buttom" >
		             <ul class="ul_buttom" >
		               <li class="fang" ></li>
		               <li class="skip"></li>
		               <li class="intercept"></li>
		             </ul>
		          </div> 
		          <div class="baseline2"></div>
		          
		       </div>
		       
		       
		      <!-- 审批任务列表 --> 
		       <div class="content_left_bottom">
		            <div class="left_bottom_div">
		                <ul class="content_left_ul">
		                    <li class="lingxing_hong" ></li>
		                    <li class="lingxing_huang"></li>
		                    <li class="lingxing_hui"></li>
		                    <li>
		                        <div class="control">
								    <!-- <div class="box ticked" id="checkBox">
								        <div class="shadow"></div>
								        <div class="spear"></div>
								    </div>
								    <label style="font-weight: bold;" >全选</label> -->
								</div>
		                    </li>
		                    <!-- <li style="width:8%;height: 35px;float: right;margin-top:5px;"><span class="full" title="全屏"></span></li> -->
		                </ul>
		            </div>
		       </div>
		   </div>
		       <!-- 右边排名 -->
			   <div class="content_right" >
		       <div style="width:100%;height: 15px;background-color: #ECF3F9;"></div>
		         <div style="width:100%;height: 120px;"> 
		         	<ul class="content_right_Ul_user"> 
		         		<c:forEach items="${totalList}" var="ent" varStatus="var">
		         			<c:forEach items="${passList }" var="entr" varStatus="vart">
			         			<c:forEach items="${loginMember }" var="ents" varStatus="vars">
			         				<c:if test="${ent.decideType == ents.decideType }">
			         					<c:if test="${entr.decideType == ents.decideType }">
					         				<div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${ents.decideType }" width="70px" height="70px" style="margin-top: 10px;padding-top: 10px;margin-left: 20px;margin-right: 12%;"/></div>
						               		<li style="text-align: left;padding-top: 15px;margin-left: 30px;">
						               			<p><span>${ent.custName}</span></p>
								                <p><span>${ent.custGrade }</span>/<span>${entr.custGrade }</span>/<span>${ent.custGrade - entr.custGrade}</span></p>
							           		</li>
							           	</c:if>	
						           	</c:if>	
			         			</c:forEach>
			         		</c:forEach>	
		         		</c:forEach>
			        </ul>
			     </div>
		         
           	  <!-- 有1个人 -->
       			<c:if test="${fn:length(totalList)==1 }">
			         <div class="baseline1"></div>
			         <div style="width:100%;height: 230px;">
				           <div class="title_content" >领先</div>
				           <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
			           	   		<c:forEach items="${passList }" var="entry2" varStatus="varsta2">
				           			<c:if test="${entry1.decideType == entry2.decideType}"> 
			                   			<c:if test="${varsta1.count ==1 }"> 
								           <ul class="content_right_Ul"> 
								               <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
									                <p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                
									           </li>
								           </ul>
					           			</c:if>
					           		</c:if>
					           	</c:forEach>
					        </c:forEach>
       				  </div>
       			</c:if>
       			<!-- 有2个人 -->
       			<c:if test="${fn:length(totalList)==2 }">
			         <div class="baseline1"></div>
			         <div style="width:100%;height: 230px;">
				           <div class="title_content" >领先</div>
				           <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
			           	   		<c:forEach items="${passList }" var="entry2" varStatus="varsta2">
				           			<c:if test="${entry1.decideType == entry2.decideType}"> 
			                   			<c:if test="${varsta1.count ==1 }"> 
								           <ul class="content_right_Ul"> 
								               <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
									                <p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                
									           </li>
								           </ul>
					           			</c:if>
					           		</c:if>
					           	</c:forEach>
					        </c:forEach>
       				  </div>
       				  <div class="baseline1"></div>
			          <div style="width:100%;height: 220px;">
				          <div class="title_content">奋起</div>
				          <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
				           	   <c:forEach items="${passList }" var="entry2" varStatus="varsta2">
					           		<c:if test="${entry1.decideType == entry2.decideType}"> 
								          <c:if test="${varsta1.count ==2}">
								          <ul class="content_right_Ul"> 
								              <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
							                		<p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                	                              
									           </li>
									       </ul>
									       </c:if>
							         </c:if>
							    </c:forEach>
						    </c:forEach>
					  </div>	
       			</c:if>
       			
       			<!-- 有3个人 -->
       			<c:if test="${fn:length(totalList)==3 }">
			         <div class="baseline1"></div>
			         <div style="width:100%;height: 230px;">
				           <div class="title_content" >领先</div>
				           <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
			           	   		<c:forEach items="${passList }" var="entry2" varStatus="varsta2">
				           			<c:if test="${entry1.decideType == entry2.decideType}"> 
			                   			<c:if test="${varsta1.count ==1 }"> 
								           <ul class="content_right_Ul"> 
								               <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
									                <p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                
									           </li>
								           </ul>
					           			</c:if>
					           		</c:if>
					           	</c:forEach>
					        </c:forEach>
       				  </div>
       				  <div class="baseline1"></div>
			          <div style="width:100%;height: 220px;">
				          <div class="title_content">奋起</div>
				          <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
				           	   <c:forEach items="${passList }" var="entry2" varStatus="varsta2">
					           		<c:if test="${entry1.decideType == entry2.decideType}"> 
								          <c:if test="${varsta1.count >1}">
								          <ul class="content_right_Ul"> 
								              <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								              
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
							                		<p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                	                              
									           </li>
									       </ul>
									       </c:if>
							         </c:if>
							    </c:forEach>
						    </c:forEach>
					  </div>	
       			</c:if>	
       			<!-- 有4个人 -->
       			<c:if test="${fn:length(totalList)==4 }">
			         <div class="baseline1"></div>
			         <div style="width:100%;height: 230px;">
				           <div class="title_content" >领先</div>
				           <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
			           	   		<c:forEach items="${passList }" var="entry2" varStatus="varsta2">
				           			<c:if test="${entry1.decideType == entry2.decideType}"> 
			                   			<c:if test="${varsta1.count <3 }"> 
								           <ul class="content_right_Ul"> 
								               <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
									                <p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                
									           </li>
								           </ul>
					           			</c:if>
					           		</c:if>
					           	</c:forEach>
					        </c:forEach>
       				  </div>
       				  <div class="baseline1"></div>
			          <div style="width:100%;height: 220px;">
				          <div class="title_content">奋起</div>
				          <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
				           	   <c:forEach items="${passList }" var="entry2" varStatus="varsta2">
					           		<c:if test="${entry1.decideType == entry2.decideType}"> 
								          <c:if test="${varsta1.count >2}">
								          <ul class="content_right_Ul"> 
								              <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								              
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
							                		<p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                	                              
									           </li>
									       </ul>
									       </c:if>
							         </c:if>
							    </c:forEach>
						    </c:forEach>
					  </div>	
       			</c:if>	
       			
       			<!-- 有5个人 -->
       			<c:if test="${fn:length(totalList)==5 }">
			         <div class="baseline1"></div>
			         <div style="width:100%;height: 230px;">
				           <div class="title_content" >领先</div>
				           <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
			           	   		<c:forEach items="${passList }" var="entry2" varStatus="varsta2">
				           			<c:if test="${entry1.decideType == entry2.decideType}"> 
			                   			<c:if test="${varsta1.count <3 }"> 
								           <ul class="content_right_Ul"> 
								               <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
									                <p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                
									           </li>
								           </ul>
					           			</c:if>
					           		</c:if>
					           	</c:forEach>
					        </c:forEach>
       				  </div>
       				  <div class="baseline1"></div>
			          <div style="width:100%;height: 220px;">
				          <div class="title_content">奋起</div>
				          <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
				           	   <c:forEach items="${passList }" var="entry2" varStatus="varsta2">
					           		<c:if test="${entry1.decideType == entry2.decideType}"> 
								          <c:if test="${varsta1.count >2}">
								          <ul class="content_right_Ul"> 
								              <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								              
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
							                		<p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                	                              
									           </li>
									       </ul>
									       </c:if>
							       
							         </c:if>
							    </c:forEach>
						    </c:forEach>
					  </div>	
       			</c:if>	
       			
       			<!-- 有6个人 -->
       			<c:if test="${fn:length(totalList)==6 }">
			         <div class="baseline1"></div>
			         <div style="width:100%;height: 230px;">
				           <div class="title_content" >领先</div>
				           <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
			           	   		<c:forEach items="${passList }" var="entry2" varStatus="varsta2">
				           			<c:if test="${entry1.decideType == entry2.decideType}"> 
			                   			<c:if test="${varsta1.count <4 }"> 
								           <ul class="content_right_Ul"> 
								               <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
									                <p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                
									           </li>
								           </ul>
					           			</c:if>
					           		</c:if>
					           	</c:forEach>
					        </c:forEach>
       				  </div>
       				  <div class="baseline1"></div>
			          <div style="width:100%;height: 220px;">
				          <div class="title_content">奋起</div>
				          <c:forEach items="${totalList }" var="entry1" varStatus="varsta1">
				           	   <c:forEach items="${passList }" var="entry2" varStatus="varsta2">
					           		<c:if test="${entry1.decideType == entry2.decideType}"> 
								          <c:if test="${varsta1.count >3}">
								          <ul class="content_right_Ul"> 
								              <div style="float: left;"><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${entry1.decideType }" width="70px" height="70px" style="margin-top: 0px;padding-top: 0px;margin-left: 20px;margin-right: 12%;"/></div>
								              
								               <li style="float: right;margin-right: 90px;">
									                <p><span>${varsta1.count}</span><span>${entry1.custName}</span></p>
							                		<p><span>${entry1.custGrade }</span>/<span>${entry2.custGrade }</span>/<span>${entry1.custGrade - entry2.custGrade}</span></p>                                	                              
									           </li>
									       </ul>
									       </c:if>
							       
							         </c:if>
							    </c:forEach>
						    </c:forEach>
					  </div>	
       			</c:if>	
	          </div>
		   </div>
 </div>
</body>
</html>