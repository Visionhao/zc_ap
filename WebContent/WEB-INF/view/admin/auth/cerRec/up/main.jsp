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
					confirm_cancle();
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
	
	function refresh(){
		var url = "${pageContext.request.contextPath}/view/admin/auth/cerRec/Up-main.action";
		window.location.href=url;
	}
</script>
</head>
<body>
<form name="upListTemplateForm" action="<%=request.getContextPath()%>/view/admin/auth/cerRec/Up-list.action" method="post" target="upListFrame">
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table class="dataTable">
	<tr valign="top" >
		<td valign="top" >
     				<div class="tool-btn">	          			
	          			<a href="#" title="刷新"  class="icon-refresh" onclick="refresh()"></a>
             		</div>
             		<div class="search">
               			 <input type="text" maxlength="32" class="search-text" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" id="QT_chineseName" name="QT_chineseName"  value="请输入姓名" /> 
               			 <a  class="h-search"  href="###" title="更多查询" onclick="condition()" >更多查询</a>
            		 </div>
			  </td>
			<tr>
				<td valign="top"><iframe id="upListFrame" name="upListFrame"
					src="<%=request.getContextPath()%>/view/admin/auth/cerRec/Up-list.action"
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
		<form id="searchForm" name="searchForm" action="<%=request.getContextPath()%>/view/admin/auth/cerRec/Up-list.action" method="post" target="upListFrame">
			<div class="content">
			<table class="more-search-table">
				<tr style="display: none;">
					<td class="word">用户编号</td>
					<td><input type="text" id="QT_systemUserId" name="QT_systemUserId" /></td>
				</tr>
				<tr>
					<td class="word">状态</td>
					 <td><tag:select name="QT_accountState" id="QT_accountState" dictCode="dictionary.auth.userAccount.status" /></td> 
					
					<td class="word">类型</td>
					  <td><tag:select id="QT_accountType" name="QT_accountType" dictCode="dictionary.auth.userAccount.type" /></td>  	
				</tr>		
				<tr>
					<td class="word">认证时间(起)</td>
					<td><input type="text" class="Wdate" id="QD_startDate" name="QD_firstCerTime" onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'QD_endDate\')||\'2020-10-01\'}'})" /></td>
					<td class="word">认证时间(止)</td>
					<td><input type="text" class="Wdate" id="QD_endDate" name="QD_lastCerTime" onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'QD_startDate\')||\'2020-10-01\'}'})" /></td>
				</tr>
			</table>
			</div>
			<hr />
			<div class="foot">
				<div class="btnbox_query"><a class="confirmBtn" title="查询" style="float:right;" id="save-btn" href="###" onclick="javascript:clickSearchForm(); ">查&nbsp;询</a></div>
			</div>
		</form>
	</div>
</body>
</html>