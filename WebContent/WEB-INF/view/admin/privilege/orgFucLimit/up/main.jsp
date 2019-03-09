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
		document.getElementById("QT_orgId").value="请输入机构编号";
	}
	function hidd() {
		document.getElementById("div1").style.display="none";
		document.searchForm.reset();
	}
	function checkTheForm() {
		if(document.getElementById("QT_orgId").value=="请输入机构编号"){
			document.getElementById("QT_orgId").value="";
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
	function getIfrmaeCheckValue(objThis, iframeName, checkName, opt) {
		var skip = 0;
		var modifyUrl = "${pageContext.request.contextPath}/view/admin/privilege/orgFucLimit/Up-editPage.action?id=";
		var modifyUrl1 = "${pageContext.request.contextPath}/view/admin/privilege/orgFucLimit/Up-editFusPage.action?id=";
		var ids = "";
		var iframeObject = window.frames[iframeName];
		var itemsObj = iframeObject.document.getElementsByName(checkName);
		for (var i = 0; i < itemsObj.length; i++) {
			if (itemsObj[i].checked == true) {
				if ((opt == 'edit' ||opt=='editFus'|| opt=='show') && skip > 0) {
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
		var comp1 = modifyUrl1 + ids;
		
		if (opt == 'edit') {
			openwindow(comp, '账号授权', 500, 500);
		}
		if (opt == 'editFus') {
			openwindow(comp1, '功能授权', 500, 500);
		}
	}
	function ref(){
		var url="${pageContext.request.contextPath}/view/admin/privilege/orgFucLimit/Up-main.action";
		window.location.href=url;
	}
</script>
</head>
<body>
<form name="upListTemplateForm" action="<%=request.getContextPath()%>/view/admin/privilege/orgFucLimit/Up-list.action" method="post" target="upListFrame">
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table class="dataTable">
	<tr valign="top" >
		<td valign="top" >
     				<div class="tool-btn">
                		<a href="#"  id="add-info"  title="功能授权" onclick="getIfrmaeCheckValue(this,'upListFrame','items','editFus')" class="icon-grantfuc"></a>
	          			<a href="#" title="账号授权" onclick="getIfrmaeCheckValue(this,'upListFrame','items','edit')"  class="icon-grantacc"></a>
	          			<a href="#" title="刷新"  class="icon-refresh" onclick="ref()"></a>
             		</div>
             		<div class="search">
               			 <input type="text" maxlength="32" class="search-text" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" id="QT_orgId" name="QT_orgId"  value="请输入机构编号" /> 
               			 <a  class="h-search"  href="###" title="更多查询" onclick="condition()" >更多查询</a>
            		 </div>
			  </td>
			<tr>
				<td valign="top"><iframe id="upListFrame" name="upListFrame"
					src="<%=request.getContextPath()%>/view/admin/privilege/orgFucLimit/Up-list.action"
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
		<form id="searchForm" name="searchForm" action="<%=request.getContextPath()%>/view/admin/privilege/orgFucLimit/Up-list.action" method="post" target="upListFrame">
			<div class="content">
				<table class="more-search-table">
					<tr>
						<td class="word">机构名称</td>
						<td><input type="text" name="QT_orgChnName" id="QT_orgChnName" style="width:180px" /></td>
						<td class="word">机构账户名</td>
						<td><input type="text" id="QT_accountCode" name="QT_accountCode" style="width:180px" /></td>
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