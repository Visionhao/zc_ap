<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评测系统</title>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<%@ include file="import.jsp"%>
<script type="text/javascript">
		//保存的刷新页面
		function refresh(){
			var url = "${pageContext.request.contextPath}/view/rap/team/evaluating/EvaluationSystemAction-main.action";	
		    window.location.href = url;	
		}
</script>
</head>
<body>
<form id="EvaluationForm" name="EvaluationForm" style="display: none;" action="${pageContext.request.contextPath}/view/rap/team/evaluating/EvaluationSystemAction-save.action" method="post">
	<input id="interceptTotal" name="Evaluation!interceptTotal"/>
	<input id="passTotal" name="Evaluation!passTotal"/>
	<input id="errorTotal" name="Evaluation!errorTotal"/>
	<input id="exactnessTotal" name="Evaluation!exactnessTotal"/>
</form>
  <div class="container" >
	<div class="head" align="center"><div style="padding-top: 10px;">评测系统<span style="float: right;text-align: center;font-size: 12px;margin-top:10px;margin-right:10px;font-family: fantasy;">欢迎您&nbsp;&nbsp;${memberName}</span></div></div>
		<div class="content" id="conDiv">
		
		   <div class="content_left" >
		     
		       <div class="content_left_top" >
		          <div class="div_top">
			           <ul class="ul_top" >
			               <li><label>上次成绩</label><div></div><label><span style="font-weight: bold;color: black;">${lastNum}</span><span>/100</span></label></li>
			               <li><label>最好成绩</label><div></div><label><span style="font-weight: bold;color: black;">${bestNum}</span><span>/100</span></label></li>
			               <li style="color: #28a7fb;"><label>错题集</label><div></div><label>${errorNum}</label></li>
			           </ul>
		          </div>
		          <div class="baseline2"></div>
		          <div class="start_t">
		          		<div class="s_text"><a class="sta_h" href="javascript:void(0)" onclick="start()">开始测试</a></div>
		          		<div class="s_submit"><a class="sub_h" href="javascript:void(0)" onclick="save()">提交</a></div>
		          </div>
		          <div class="baseline22"></div>
		       </div>
		       
		       <div class="append_div"></div>
		       
		       <div class="div_buttom">
		             <ul class="ul_buttom">
		               <a href="javascript:void(0)" title="放" onclick="onPs()"><li class="fang"></li></a>
		               <a href="javascript:void(0)" title="拦" onclick="onIt()"><li class="intercept"></li></a>
		             </ul>
		       </div>
		     
		   </div>
		  
		   <div class="content_right" >
	         	<div style="width:100%;height: 100px;"> 
	         		<ul class="content_right_Ul_user"> 
			               <li><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${membersView}" width="70px" height="70px" style="margin-top:18px;margin-left:18px;vertical-align: middle;margin-right:10px;"/></li>
			               <li style="text-align: left;padding-top: 25px;">
				                <p><span style="color: black;">${totalNum}</span>/<span style="color: blue;">${exactnessNum}</span>/<span style="color: red;">${errorNum}</span></p>
				           		<p style="padding-top:15px;"><span>准确率:</span><span>${rateNum}%</span></p>
				           </li>
		       		</ul>
		        </div>
		        <div class="baseline1"></div>
		        <div class="right_bor"></div>   
	        </div>
		</div>   
		       
</div>
</body>
</html>