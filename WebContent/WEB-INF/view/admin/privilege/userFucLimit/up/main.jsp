<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@ include file="../import.jsp"%>
<title>查询条件</title>
<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/common/navigation.css"  rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resource/tools/common/navigation.js"></script>
<script type="text/javascript">
	function condition() {
		document.getElementById("div1").style.display="block";
		document.getElementById("QT_chineseName").value="请输入姓名";
	}
	function hidd() {
		document.getElementById("div1").style.display="none";
		document.searchForm.reset();
	}
	function checkTheForm() {
		if(document.getElementById("QT_chineseName").value=="请输入姓名"){
			document.getElementById("QT_chineseName").value="";
		}
		document.upListTemplateForm.submit();
	}
	function clickSearchForm() {
		document.getElementById("div1").style.display="none";
		document.searchForm.submit();
	}
	function reset() {
		var e = document.getElementsByTagName("input");
		for (var i = 0; i < e.length; i++) {
			if (e[i].type == "text") {
				e[i].value = '';
			}
		}
	}
	function getIfrmaeCheckValue(objThis, iframeName, checkName, opt) {
		var skip = 0;
		var modifyUrl = "${pageContext.request.contextPath}/view/admin/privilege/userFucLimit/Up-grantRolePage.action?id=";
		var ids = "";
		var iframeObject = window.frames[iframeName];
		var itemsObj = iframeObject.document.getElementsByName(checkName);
		for (var i = 0; i < itemsObj.length; i++) {
			if (itemsObj[i].checked == true) {
				if ((opt == 'edit' || opt=='show') && skip > 0) {
					mp_alter("提示", "每次只能操作一条记录");
					return;
				} else {
					ids += itemsObj[i].value + ",";
				}
				skip++;
			}
		}
		if (ids == "") {
			mp_alter("提示", "请选择一条记录");
			return;
		}
		ids = ids.substring(0, ids.length - 1);
		var comp = modifyUrl + ids;
		if (opt == 'edit') {
			openwindow(comp, '分配角色信息', 500, 450);
		}
	}
	function ref(){
		var url="${pageContext.request.contextPath}/view/admin/privilege/userFucLimit/Up-main.action";
		window.location.href=url;
	}
</script>
</head>
<body>
<form name="upListTemplateForm" action="<%=request.getContextPath()%>/view/admin/privilege/userFucLimit/Up-list.action" method="post" target="upListFrame">
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table class="dataTable">
	<tr valign="top" >
		<td valign="top" >
     				<div class="tool-btn">
	          			<a href="#" title="分配角色" onclick="getIfrmaeCheckValue(this,'upListFrame','items','edit')"  class="icon-grantrole"></a>
	          			<a href="#" title="刷新"  class="icon-refresh" onclick="ref()"></a>
             		</div>
             		<div class="search">
               			 <input type="text" maxlength="32" class="search-text" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" id="QT_chineseName" name="QT_chineseName"  value="请输入姓名" /> 
               			 <a  class="h-search"  href="###" title="更多查询" onclick="condition()" >更多查询</a>
            		 </div>
			  </td>
			<tr>
				<td valign="top"><iframe id="upListFrame" name="upListFrame"
					src="<%=request.getContextPath()%>/view/admin/privilege/userFucLimit/Up-list.action"
					width='100%' height='400' frameborder="0"></iframe></td>
			</tr>
		</table>
		</form>
	<div id="div1" class="div1">
		<div  class="title">更多查询
				<a href="#" onclick="javascrtip:hidd()"><span id="span2" style="background-color:#02a4e8; cursor: pointer"><img src="${pageContext.request.contextPath}/resource/images/standard/cancel.png" style="float: right;"></span></a>
		</div>
		<hr/>
		<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
		<form id="searchForm" name="searchForm" action="<%=request.getContextPath()%>/view/admin/privilege/userFucLimit/Up-list.action" method="post" target="upListFrame">
			<div class="content">
				<table class="more-search-table">
					<tr>
						<tr>
							<td class="word">主账号</td>
						<td><input type="text" id="accountCode" name="QT_accountCode"/></td>
					    </tr>
					</tr>
				</table>
			</div>
			<hr/>
			<div class="foot">
				<div class="btnbox_query"><a class="confirmBtn" title="查询"  id="save-btn" href="###" onclick="javascript:clickSearchForm();">查 询</a></div>
			</div>
		</form>
	</div>
</body>
</html>