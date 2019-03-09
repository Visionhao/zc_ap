<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>查询条件</title>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@ include file="../import.jsp"%>
<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/common/navigation.css"  rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resource/tools/common/navigation.js"></script>
<script type="text/javascript">
	function checkTheForm() {
		if(document.getElementById("QT_roleChnName").value=="请输入角色名称"){
			document.getElementById("QT_roleChnName").value=="";
		}
		document.down1ListTemplateForm.submit();
	}
	function condition() {
		document.getElementById("div1").style.display="block";
		document.getElementById("QT_roleChnName").value="请输入角色名称";
	}
	function hidd() {
		document.getElementById("div1").style.display="none";
		document.searchForm.reset();
	}
	function clickSearchForm() {
		document.getElementById("div1").style.display="none";
		document.searchForm.submit();
	}
	function ref(){
		var url="${pageContext.request.contextPath}/view/admin/privilege/userFucLimit/Down1-main.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>";
		window.location.href=url;
	}
</script>
<body >
<form name="down1ListTemplateForm" action="<%=request.getContextPath()%>/view/admin/privilege/userFucLimit/Down1-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>" method="post" target="down1MainFrame">
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table class="dataTable">
	<tr valign="top" >
		<td valign="top" >
			<div class="demo-wrap">
             <div class="tool-btn">
	          			<a href="#" title="刷新"  class="icon-refresh" onclick="ref()"></a>
             </div>
             <div class="search">
                <input type="text" maxlength="32" class="search-text" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" id="QT_roleChnName" name="QT_roleChnName" value="请输入角色名称" /> 
                <a class="h-search" href="###" title="更多查询" onclick="condition()"  >更多查询</a>
             </div>
            </div>
			</td>
			</tr>
			<tr>
				<td valign="top"><iframe id="down1MainFrame" name="down1MainFrame"
					src="<%=request.getContextPath()%>/view/admin/privilege/userFucLimit/Down1-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>"
					width='100%' height='400' frameborder="0"></iframe></td>
			</tr>
		</table>
		</form> 
	<div id="div1" class="div1">
		<div  class="title">更多查询
				<a href="#" onclick="javascrtip:hidd()"><span id="span2" style="background-color:#02a4e8; cursor: pointer"><img src="${pageContext.request.contextPath}/resource/images/standard/cancel.png" style="float: right;"></span></a>
		</div>
		<hr/>
		<form id="searchForm" name="searchForm" action="<%=request.getContextPath()%>/view/admin/privilege/userFucLimit/Down1-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>" method="post" target="down1MainFrame">
			<div class="content">
				<table class="more-search-table">
					<tr>
						<td class="word">角色类型</td>
						<td><tag:select id="QT_roleType" name="QT_roleType" dictCode="dictionary.privilege.role.type"/></td>
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