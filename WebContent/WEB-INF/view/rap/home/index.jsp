<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<html>
<head>
<title>首页</title>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<link href="<%=request.getContextPath() %>/view/rap/css/index/index.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/view/rap/js/index/index.js" type="text/javascript"></script>
<%@ include file="import.jsp"%>
<script type="text/javascript">
 	//刷新页面
	function refresh(){
		var url = "${pageContext.request.contextPath}/view/rap/home/IndexAction-index.action";	
	    window.location.href = url;	
	}	
 	
	 $(function(){
	       var member_msg = $("#a_memId").text();
	 	   if(member_msg !=''){
	 		   document.getElementById("div_memId").style.display='block';
	 	   }
	   });   
 	
	//初始化判断session是否有值，有值则可以修改信息
    $(function() {	
	   var membersId = $("#membersId").val();
	   var pictureId = $("#pictureId").val();
		if(membersId !='' && pictureId !=''){
			$("#a_memId").click(
					function() {
						openwindow('${pageContext.request.contextPath}/view/rap/home/MemberLoginAction-editMember.action?id='+membersId+"&pictureId="+pictureId,'修改成员信息',600,400);  
						/* window.open ('${pageContext.request.contextPath}/view/rap/home/MemberLoginAction-editMember.action?id='+membersId,'修改成员信息','height=400px','width=350px','top=0','center=yes','toolbar=no','menubar=no','scrollbars=no', 'resizable=no','location=no', 'status=no'); */
					});
		}
	}); 
	
	//判断session中没有值的时候追加登录的层
	function loginTier(){
		var tier = "";
		$(function(){
			tier += "<form id=\"loginForm\" name=\"loginForm\">"+ 
						"<div id=\"div1\" style=\"display: block\">"+
								"<div class=\"input_div_div1\">"+
									"<div class=\"input_titel\"><img width=\"20px;\" height=\"25px;\" src=\"${pageContext.request.contextPath }/view/rap/images/home/loginName.png\"/></div>"+
									"<div id=\"memberName_mass\" style=\"font-family: 微软雅黑;font-size: 14px;float:left;margin-left:35px;margin-top:-20px;color:red;border-color: #00ff00;border-width: 1px;\"  weight=\"50px\"></div>"+
									"<div class=\"input_div\">"+
										"<input type=\"text\" id=\"memberName\" name=\"memberName\"  onfocus=\"ondown(this)\" onblur=\"onAdd(this)\" value=\"请输入工号或手机号码\"/>"+
									"</div>"+
									
								"</div>"+
								"<div class=\"input_div_div1\">"+
									"<div class=\"input_titel\"><img width=\"20px;\" height=\"25px;\" src=\"${pageContext.request.contextPath }/view/rap/images/home/passWord.png\"/></div>"+
									"<div id=\"passWord_mass\" style=\"font-family: 微软雅黑;font-size: 14px;float:left;margin-left:35px;margin-top:-25px;color:red;border-color: #00ff00;border-width: 1px;\"  weight=\"50px\"></div>"+
									"<div class=\"input_div\">"+
										"<input type=\"password\" id=\"passWord\" name=\"passWord\" onfocus=\"onPwd(this)\" onblur=\"onPass(this)\" value=\"请输入密码\"/>"+
									"</div>"+
								"</div>"+
								"<div id=\"error_hint\" style=\"font-family: 微软雅黑;font-size: 14px;dispaly:block;float:left;margin-left:90px;color:red;border-color: #00ff00;border-width: 1px;\"></div>"+
								"<div class=\"DL\" align=\"center\"><a id=\"login_a\" href=\"javascript:void(0)\" onclick=\"javascript:membersLogin()\">登&nbsp;录</a></div>"+
						"</div>"+ 
					"</form>";
			showdialogComponent("成员登录",400,350,tier);
		});
	} 
	 
	 ${Login};
	//判断是否已经登录过
   function	loginSucceed(){}

		
</script>		
</head>
<body onload="setMouse()">
	<div id="div_memId" style="float: right;margin-top:20px;margin-right:40px;display: none;">
		<span style="float: right;margin-right:180px;">欢迎您&nbsp;&nbsp;</span><a id="a_memId" style="color: #51C2EB;text-align: center;padding-top: 5px;" href="javascript:void(0)"><span style="float: right;text-align: center;font-size: 12px;margin-right:-80px;">${memberName}</span></a>
		<input style="display: none" id="membersId" name="membersId" type="text" value='<c:out value="${membersView.membersId }"></c:out>'/>
		<input style="display: none" id="pictureId" name="pictureId" type="text" value='<c:out value="${membersView.groupId }"></c:out>'/>
	</div>
	
	<div class="content">
		<div class="box">
			<a href="${pageContext.request.contextPath }/view/rap/team/member/MemberAction-main.action" class="a_link" target="_blank">
				<img src="${pageContext.request.contextPath }/view/rap/images/home/cygl.png"/>
			</a>
			<p class="mass">我们都是火眼金星,每一条垃圾短信都不会放过</p>
			<div class="a_title_div"><a href="${pageContext.request.contextPath }/view/rap/team/member/MemberAction-main.action" target="_blank">成员管理</a><br /></div>
		</div>
		
		
		<div class="box">
			<a href="${pageContext.request.contextPath }/view/rap/seats/taskDivide/TaskDivideAction-taskList.action" class="a_link" target="_blank">
				<img src="${pageContext.request.contextPath }/view/rap/images/home/fprw.png" alt="分配任务" />
			</a>
			<p class="mass">分配任务</p>
			<div class="a_title_div"><a href="javascript:void(0)" target="_blank">分配任务</a><br /></div>
		</div>
		
		
		<div class="box">
			<a href="${pageContext.request.contextPath }/view/rap/auditing/auditTable/AuditTableAction-main.action" class="a_link" target="_blank">
				<img src="${pageContext.request.contextPath }/view/rap/images/home/shgzt-sm.png" alt="审核工作台" />
			</a>
			<p class="mass">审核工作台(快速扫描)</p>
			<div class="a_title_div"><a href="javascript:void(0)" target="_blank">审核工作台(快速扫描)</a><br /></div>
		</div>
		
		<div class="box" style="margin-right:0px;">
			<a href="${pageContext.request.contextPath }/view/rap/auditing/auditTable/AuditMineAction-main.action" class="a_link" target="_blank">
				<img src="${pageContext.request.contextPath }/view/rap/images/home/shgzt-pl.png" alt="排雷" />
			</a>
			<p class="mass">审核工作台(排雷)</p>
			<div class="a_title_div"><a href="javascript:void(0)" target="_blank">审核工作台(排雷)</a><br /></div>
		</div>
		
		<div class="box">
			<a href="${pageContext.request.contextPath }/view/rap/auditing/auditTrategy/AuditTrategyAction-main.action" class="a_link" target="_blank">
				<img src="${pageContext.request.contextPath }/view/rap/images/home/shclpz.png" alt="审核策略配置" />
			</a>
			<p class="mass">审核策略配置</p>
			<div class="a_title_div"><a href="${pageContext.request.contextPath }/view/rap/auditing/auditTrategy/AuditTrategyAction-main.action" target="_blank">审核策略配置</a><br /></div>
		</div>
		
		<div class="box">
			<a href="<%=request.getContextPath() %>/view/rap/team/Complaintsback/ComplaintsBackAction-main.action" class="a_link" target="_blank">
				<img src="${pageContext.request.contextPath }/view/rap/images/home/tshs.png" alt="投诉回溯" />
			</a>
			<p class="mass">投诉回溯</p>
			<div class="a_title_div"><a href="<%=request.getContextPath() %>/view/rap/team/Complaintsback/ComplaintsBackAction-main.action" target="_blank">投诉回溯</a><br /></div>
		</div>
		
		<div class="box" style="margin-right:0px;">
			<a href="${pageContext.request.contextPath }/view/rap/team/evaluating/EvaluationSystemAction-main.action"  class="a_link" target="_blank">
				<img src="${pageContext.request.contextPath }/view/rap/images/home/pcxt.png" alt="评测系统" />
			</a>
			<p class="mass">评测系统</p>
			<div class="a_title_div"><a href="${pageContext.request.contextPath }/view/rap/team/evaluating/EvaluationSystemAction-main.action"  target="_blank">评测系统</a><br /></div>
		</div>
	</div>
	<%@ include file="./foot.jsp"%>
</body>
</html>