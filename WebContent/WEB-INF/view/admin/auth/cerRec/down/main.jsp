<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tag" uri="/uap-tags"%>	
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
		document.getElementById("QT_clientIp").value="请输入客户端IP";
	}
	function hidd() {
		document.getElementById("div1").style.display="none";
		document.searchForm.reset();
	}
	function checkTheForm() {
		if(document.getElementById("QT_clientIp").value=="请输入客户端IP"){
			   document.getElementById("QT_clientIp").value="";
			}		
		document.downListTemplateForm.submit();
	}
	function clickSearchForm() {
		document.getElementById("div1").style.display="none";
		document.searchForm.submit();
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
</script>
</head>
<body>
<form name="downListTemplateForm" action="<%=request.getContextPath()%>/view/admin/auth/cerRec/Down-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>" method="post" target="downMainFrame">		
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table class="dataTable">
	<tr valign="top" >
		<td valign="top" >
					<div class="demo-wrap">
     				<div class="tool-btn">
							<a href="#" title="刷新" class="icon-refresh" onclick="refresh('downMainFrame')"></a>
						</div>
						<div class="search">
							 <input type="text" maxlength="32" class="search-text" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" id="QT_clientIp" name="QT_clientIp"  value="请输入客户端IP" /> 
               			 	<a  class="h-search"  href="###" title="更多查询" onclick="condition()" >更多查询</a>
						</div>
					</div>
			  </td>
			<tr>
				<td valign="top"><iframe id="downMainFrame" name="downMainFrame"
						src="<%=request.getContextPath()%>/view/admin/auth/cerRec/Down-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>"
						width='100%' height='400' frameborder="0"></iframe></td>
			</tr>
		</table>		
		</form>
	<div id="div1" class="div1">
		<div  class="title">更多查询
			<a href="#" onclick="javascrtip:hidd()"><span id="span2" style="background-color:#02a4e8; cursor: pointer"><img src="${pageContext.request.contextPath}/resource/images/standard/cancel.png" style="float: right;"></span></a>
		</div>
		<hr />
		<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
		<form id="searchForm" name="searchForm" action="<%=request.getContextPath()%>/view/admin/auth/cerRec/Down-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>" method="post" target="downMainFrame">
			<div class="content">
			<table class="more-search-table">
				<tr>
					<td class="word">认证方式</td>
					<td><tag:select id="QT_cerType" name="QT_cerType" dictCode="dictionary.auth.userAccount.cerType"/>
					<td class="word">认证结果</td>
					<td><tag:select id="QT_cerResult" name="QT_cerResult" dictCode="dictionary.auth.userAccount.cerResult"/></td>
				</tr>
				<tr>
					<td class="word">认证日期(起)</td>
				    <td><input type="text"  id="QD_startDate" class="Wdate" name="QD_startcerTime" onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'QD_endDate\')||\'2020-10-01\'}'})" /></td>			        
				    <td class="word">认证日期(止)</td>
				    <td><input type="text"  id="QD_endDate" class="Wdate" name="QD_endcerTime" onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'QD_startDate\')||\'2020-10-01\'}'})" /></td>
				</tr>
			</table>
			</div>
			<hr />
			<div class="foot">
				<div class="btnbox_query"><a class="confirmBtn" title="查询"  style="float: right;" id="save-btn" href="###" onclick="javascript:clickSearchForm();">查&nbsp;询</a></div>
			</div>
		</form>
	</div>
</body>
</html>