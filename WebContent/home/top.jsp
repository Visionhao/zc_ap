<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>UAP1.0 控件 DEMO</title>
<style>
body{font-family:"宋体"; font-size:12px;}
.top{height:50px; padding-top:5px; padding-left:45px;}
.logo{ float:left;margin-bottom: 10px;}
.qixin{margin-left:25px; font-size:30px; line-height:50px;}

a{color:white;float: left; display:black; width:60px; background:#80bdfe;padding-left: 10px;padding-right: 10px;font-size: 14px;text-decoration: none;}
a:HOVER{color:white;float: left; display:black; width:60px; background:#3e87dc  ;font-size: 14px;text-decoration: none;font-weight: bold;}
.nav{ font:700 15px/40px "microsoft yahei"; height:40px;padding-left:180px; line-height:40px;background-color: #80bdfe}
.navz{padding-left:18px; padding-right:10px;background-color:#3e87dc  ; text-align:center; font-weight: bold;}
.navzi{padding-left:10px; padding-right:10px;  }
.left{background:#89b5e9; width:165px; height:520px; margin-top:10px; margin-left:20px;}
.cai{width:165px; height:30px; color:#d0dce9;}
.dl{ float:right;width: 350px;}
.topButton{ width: 150px; float:left;text-align: right;padding-right: 15px;}
.topButton a { color: #959595; background-color: white; font-size: 12px ;display: inline-block; }
.topButton a:hover {
	color: #626262;background-color: white;font-size: 12px ;display: inline-block; 
}

.topButton2{ width: 50px; float:left;}
.topButton2 a { color: #959595; background-color: white; font-size: 12px ;display: inline-block; }
.topButton2 a:hover {
	color: #626262;background-color: white;font-size: 12px ;display: inline-block; 
}

</style>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script>
$(document).ready(function(){
	$("div a").click(function(){
		$('div a').addClass("navzi").siblings().removeClass("navz");
		$(this).addClass("navz").siblings().removeClass("navzi");
		
	});
	
});
function show(){
	parent.frame.cols="195,*";
}
</script>
</head>
<body>

<div class="top">
	<div class="logo"><img src="${pageContext.request.contextPath}/view/admin/images/index/logo.png" /></div><span class="qixin"><font color="#74bcee">企信通管理平台2.0</font></span>
    <div class="dl"><div class="topButton"><label>${CurrentUserName}</label>&nbsp;<img src="${pageContext.request.contextPath}/view/admin/images/index/show.png" /></div><div class="topButton2"><a href="#">咨询</a></div><div class="topButton2"><a href="#">帮助</a></div><div class="topButton2"><a href="<%=request.getContextPath() %>/view/admin/home/logout.action">退出</a></div></div>
</div>

<div class="nav">
	<c:forEach  items="${menus1}" var="menus"
						varStatus="vs"> 
		<c:if test="${vs.count==1 }">
		<a class="navz" href="<%=request.getContextPath() %>/view/admin/home/Do-left.action?parentCataId=${menus.menuId }" target="leftFrame" onclick="show()">${menus.name }</a></label>
		<input type="hidden" value="${menus.menuId }" id="top1Menu" name="top1Menu" />
		</c:if>
		<c:if test="${vs.count!=1 }">
		<a class="navzi" href="<%=request.getContextPath() %>/view/admin/home/Do-left.action?parentCataId=${menus.menuId }" target="leftFrame" onclick="show()">${menus.name } </a></label>
		</c:if>
    </c:forEach>
 </div>
 <div style="border-bottom: 2px solid #ff9800"></div>
</body>
</html>