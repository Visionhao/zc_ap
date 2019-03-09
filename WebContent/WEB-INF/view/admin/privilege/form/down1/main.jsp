<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../import.jsp"%>
<title>查询条件</title>
<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/common/navigation.css"  rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resource/tools/common/navigation.js"></script>
<script type="text/javascript">
	function condition() {
		document.getElementById("div1").style.display="block";
		document.getElementById("QT_accessId").value="请输入操作键编号";
	}
	function hidd() {
		document.getElementById("div1").style.display="none";
		document.searchaccess.reset();
	}
	function checkTheaccess() {
		if(document.getElementById("QT_accessId").value=="请输入操作键编号"){
			document.getElementById("QT_accessId").value="";
		}
		document.DoListTemplateform.submit();
	}
	function clickSearchaccess() {
		document.getElementById("div1").style.display="none";
		document.searchaccess.submit();
	}
	function confirm_sure(ids) {
		var url = "${pageContext.request.contextPath}/view/admin/privilege/form/Down1-delete.action?id="
				+ ids;
		window.location.href = url;
	}
	function mp_confirm(title, content, height, ids) {
		mp_confirm_base(title, content);
		$("#dialog-confirm").dialog({
			resizable : false,
			height : height,
			modal : true,
			buttons : {
				'确定' : function() {
					$(this).dialog('close');
					confirm_sure(ids);
				},
				'取消' : function() {
					$(this).dialog('close');
				}
			}
		});
	}
	function reset() {
		var e = document.getElementsByTagName("input");
		for (var i = 0; i < e.length; i++) {
			if (e[i].type == "text") {
				e[i].value = '';
			}
		}
	}
	
	$(function() {
		$("#add-info")
				.click(
						function() {
							openwindow(
									'${pageContext.request.contextPath}/view/admin/privilege/form/Down1-addPage.action?formId=<%=request.getParameter("QA_PARENT_ROW_KEY")%>',
									'配置操作键信息', 510, 550);
						});
	});
	function ref(){
		var url="${pageContext.request.contextPath}/view/admin/privilege/form/Down1-main.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>";
		window.location.href=url;
	}
</script>
</head>
<body>
<form name="DoListTemplateform" action="<%=request.getContextPath()%>/view/admin/privilege/form/Down1-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>" method="post" target="DoListFrame">	
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table class="dataTable">
	<tr valign="top" >
		<td valign="top" >
     				<div class="tool-btn">
                		<a href="#"  id="add-info"  title="配置操作"  class="icon-new"></a>
	          			<a href="#" title="刷新"  class="icon-refresh" onclick="ref()"></a>
             		</div>
             		<div class="search">
               			 <input type="text" maxlength="32" class="search-text" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" id="QT_accessId" name="QT_accessId"  value="请输入操作键编号" /> 
               			 <a  class="h-search"  href="###" title="更多查询" onclick="condition()" >更多查询</a>
            		 </div>
		</td>
			<tr>
				<td valign="top"><iframe id="DoListFrame" name="DoListFrame"
					src="<%=request.getContextPath()%>/view/admin/privilege/form/Down1-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>"
					width='100%' height='400' frameborder="0"></iframe></td>
			</tr>
	</tr>
 </table>	
</form>
	<div id="div1" class="div1">
		<div  class="title">更多查询
			<a href="#" onclick="javascrtip:hidd()"><span id="span2" style="background-color:#02a4e8; cursor: pointer"><img src="${pageContext.request.contextPath}/resource/images/standard/cancel.png" style="float: right;"></span></a>
		</div>
		<hr/>
		<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
		<form id="searchaccess" name="searchaccess" action="<%=request.getContextPath()%>/view/admin/privilege/form/Down1-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>" method="post" target="DoListFrame">
			<div class="content">
				<table class="more-search-table">
					<tr>
						<tr>
						<td class="word">中文名称</td>
						<td><input type="text" id="accessChnName" name="QT_accessChnName"  style="width:180px" /></td>
						<td class="word">英文名称</td>
						<td><input type="text" id="accessEngName" name="QT_accessEngName" style="width:180px" /></td>
					</tr>
				</table>
			</div>
			<hr/>
			<div class="foot">
				<div class="btnbox_query"><a class="confirmBtn" title="查询"  id="save-btn" href="###" onclick="javascript:clickSearchaccess();">查 询</a></div>
			</div>
		</form>
	</div>
</body>
</html>