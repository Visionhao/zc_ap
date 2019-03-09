<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分配任务</title>
<%@ include file="import.jsp"%>
<script type="text/javascript">
var myreg= /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?$/;
function updateTask(){
	var count=0;
	var value="";
	    for(var index=0;index < $(".input_proportion").length;index++){
	    	value=$($(".input_proportion").get(index)).val();
		    if(value==""){
		         mp_alter("提示",$("#member"+index).text()+"的任务占比不能为空");
			     return;
			}else if(!myreg.test(value) || value.indexOf(".")!=-1){
		         mp_alter("提示",$("#member"+index).text()+"的任务占比不是有效的整数");
			    return;
			}
		    count+=parseInt(value);
	    }
	   if(count!=100){
	      mp_alter("提示","总任务占比不等于100");
	      return ;
	   }
	    var params = $("#taskDivideList").serialize();
	     $.post("${pageContext.request.contextPath}/view/rap/seats/taskDivide/TaskDivideAction-updateTask.action",params,function(result){
		     if(result=="ok"){
			   mp_alter("提示","设置成功");
			   }else{
				   mp_alter("提示","设置失败");
			   } 
			     
		}); 
  }
   
$(function(){
	var count=$(".input_proportion").length;
	var hpx="";
	if(count > 4){
		hpx=parseInt(count)*135+"px";
		$("#conDiv").css("height",hpx);
	}else{
		$("#conDiv").css("height","700px");
	}
	
	if(count==0){
		$("#btns").hide();
	}
	
});
</script>
</head>
<body>
  <div class="container" >
		<!-- <div class="head" align="center">分配任务[按量]</div> -->
		<div class="head" align="center"><div style="padding-top: 10px;">分配任务[按量]<span style="float: right;text-align: center;font-size: 12px;margin-top:10px;margin-right:10px;font-family: fantasy;">欢迎您&nbsp;&nbsp;${memberName}</span></div></div>
		<div class="fonts"></div>
		<div class="column" align="center">
		   <table><tr><td style="width: 760px;">审核员</td><td>任务占比(%)</td></tr></table>
		</div>
		
		<div class="content" id="conDiv">
		 <form id="taskDivideList">
		   <ul class="contentUl">
		     <c:forEach items="${taskDivideList}" var="bean" varStatus="s" begin="0" >
			      <li style="width: 805px;height: 120px;">
			         <ul class="contentUl"> 
			              <li ><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${bean.membersId }" width="70px" height="70px" style="margin-top:18px;margin-left:18px;vertical-align: middle;margin-right:10px;"/></li>
			               <li style="text-align: left">
				                <p style="font-weight:bold;">${bean.jobNumber}&nbsp;<span id="member${s.index}">${bean.membersName}</span></p>
				                <p>${bean.membersGroupName}</p>                                
				                <p><fmt:formatDate value="${bean.createDate}" pattern="yyyy年MM月dd日 hh:mm"/>&nbsp;上线</p>
				           </li>
			           </ul>
			      </li>
			      <li class="input_li">
			         <input type="hidden" value="${bean.taskAssignId}" name="TaskDivideList[${s.index}].taskAssignId" />
			         <input type="hidden" value="${bean.workCategory}"  name="TaskDivideList[${s.index}].workCategory"   />
			          <input type="hidden" value="${bean.membersId}" name="TaskDivideList[${s.index}].membersId"  />
			          <input type="text" value="${bean.workLoad}" class="input_proportion" name="TaskDivideList[${s.index}].workLoad" />
			      </li>
			      <li class="bottom_xian"></li>
		      </c:forEach>
		    </ul>
		    <div><input id="btns" class="buttom_submit" type="button" value="分配"  onclick="updateTask();" /></div>
		   </form>
        </div>
 </div>
 
</body>
</html>