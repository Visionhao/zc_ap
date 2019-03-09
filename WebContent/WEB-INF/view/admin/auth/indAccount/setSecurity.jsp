<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@include file="import.jsp" %>
<html>
<head>
<title>修改个人帐号信息</title>
<style type="text/css">
a{
	text-decoration: none;
}	
.addr-nav {
    border-bottom: 1px solid #d5d5d9;
    border-left: 1px solid #d5d5d9;
    height: 30px;
    margin: 40px -20 0 20px;
    font-size: 12px;
    font-weight: bold;
} 
.addr-nav ul {left: 0;top: 0;height: 31px; list-style-type:none;}
.addr-nav ul li{float: left;border-right: 1px solid #d5d5d9;border-top: 1px solid #d5d5d9;background-color: #efefef;border-bottom: 1px solid #d5d5d9;}
.addr-nav ul li a{padding:0 12px;display: inlne-block;height: 29px;line-height: 29px;color: #333;}
.addr-nav ul li a:hover{text-decoration: none;}
.addr-nav ul li.on{border-bottom: 1px solid #FFF;background-color: #FFF;}
</style>
</head>
<body>
	<div id="addr-nav" class="addr-nav">
			<ul style="padding-left: 0px;margin-top: 20px;">
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-main.action">基本信息</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editPasswordPage.action">修改密码</a></li>
				<li><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-editcontactInforPage.action">联系方式</a></li>
				<li class="on"><a href="#">帐号安全</a></li>
			</ul>
	</div>
	<p>
	<form  action="" method="post">
	<table  border="1" bordercolor="black" style="border-collapse:collapse;margin-top: 50px;margin-left: 50px;line-height: 35px;text-align: center;" width="80%" >
		<tr style="background-color: #F5F5F5;font-weight: bold;font-size:14px;">
			<td>帐号安全设置</td>
			<td>是否使用</td>
			<td>详情</td>
			<td>操作</td>
		</tr>
		<tr style="font-size:14px;">
			<td>保密邮箱</td>
			<td><img src="${pageContext.request.contextPath}/view/admin/images/u_select.jpg"/></td>
			<td>15119912641@163.com</td>
			<td>
				<span><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-edit.action">修改</a>&nbsp;</span><span><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-reset.action">重置</a>&nbsp;</span><span><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-verify.action">验证</a></span>
			</td>
		</tr>
		<tr style="font-size:14px;">
			<td>关联手机</td>
			<td><img src="${pageContext.request.contextPath}/view/admin/images/u_notselect.jpg"/></td>
			<td>13435955478</td>
			<td>
				<span><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-edit.action">修改</a>&nbsp;</span><span><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-reset.action">重置</a>&nbsp;</span><span><a href="${pageContext.request.contextPath}/view/admin/auth/indAccount/Do-verify.action">验证</a></span>
			</td>
		</tr>
	</table>
		<div class="btnbox">
          <a class="confirmBtn"  style="float: left;" title="重置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp;置</a>
          <a class="confirmBtn"  style="float: left;" title="保 存"  id="save-btn" href="###" onclick="javascript:doSave()">保 &nbsp;存</a>
        </div>	
	</form>
</body>
</html>