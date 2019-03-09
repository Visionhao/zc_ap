<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户功能授权信息列表</title>
<%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa"%>
<link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
<script type="text/javascript">
	function onInvokeAction(id) { 
		var parameterString = $.jmesa.createParameterStringForLimit(id);
		location.href = "${pageContext.request.contextPath}/view/admin/privilege/userFucLimit/Up-list.action?QT_chineseName=<%=request.getAttribute("QT_chineseName") %>&QT_accountCode=<%=request.getAttribute("QT_accountCode") %>&" + parameterString;
	}
	function onInvokeExportAction(id) {
		var parameterString = $.jmesa.createParameterStringForLimit(id);
		location.href = '${pageContext.request.contextPath}/view/admin/privilege/userFucLimit/Up-list.action?'
				+ parameterString;
	}
	function twoClick(id) {
		var t = document.getElementById("tableId");
		var rows = t.getElementsByTagName("tr");
		var itemsObj = document.getElementsByName("items");
		for (var i = 0; i < itemsObj.length; i++) {
			if(!itemsObj[i].checked){
				rows[i + 1].style.backgroundColor = "";
				if (id == itemsObj[i].value) {
					rows[i + 1].style.backgroundColor = "#80bdff";
					orgCode = rows[i+1].cells[2].innerHTML;
				}
			}
		}
		window.parent.parent.parent.mainDown.location.href = "${pageContext.request.contextPath}/view/admin/privilege/userFucLimit/Main-downMain.action?QA_PARENT_ROW_KEY="
					+ id;
	}
	function setAllCheckboxState() {
		var flag = document.getElementById("all").checked;
		var elements = document.getElementsByName("items");
		for (var i = 0; i < elements.length; i++) {
			if (elements[i].type != 'checkbox') {
				continue;
			} else {
				elements[i].checked = flag;
				elements[i].parentNode.parentNode.style.backgroundColor=flag?'#80bdff':'#ffffff';
			}
		}
		return;
	}
	function selectedFirst() {
		var t = document.getElementById("tableId");
		var rows = t.getElementsByTagName("tr");
		var itemsObj = document.getElementsByName("items");
		rows[1].style.backgroundColor = "#80bdff";
		var id = itemsObj[0].value;
		window.parent.parent.parent.mainDown.location.href = "${pageContext.request.contextPath}/view/admin/privilege/userFucLimit/Main-downMain.action?QA_PARENT_ROW_KEY="
				+ id;
	}
</script>
</head>
<body onload="selectedFirst()">
	<form name="tableId" action="${pageContext.request.contextPath}/view/admin/privilege/userFucLimit/Up-list.action">
		<jmesa:tableModel id="tableId" autoFilterAndSort="false"
			items="${object_items}" maxRows="15" exportTypes=""
			maxRowsIncrements="15,30,50" stateAttr="restore" var="bean"
			view="com.uap.core.web.jmesa.view.QXTView"
			toolbar="com.uap.core.web.jmesa.view.QXTToolBar">
			<jmesa:htmlTable captionKey="presidents.caption" width='100%'>
				<jmesa:htmlRow >
					<jmesa:htmlColumn sortable="false"
						title="<input type='checkbox' id='all' onclick=\"setAllCheckboxState()\" >" >
            			<input type="checkbox" name="items" value="${bean.systemUserId}"  onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'" />
					</jmesa:htmlColumn>
					<jmesa:htmlColumn property="chineseName" title="姓名" sortable="false" filterable="false" editable="false" />
					<jmesa:htmlColumn property="accountCode" title="主账号" sortable="false" filterable="false"	editable="false" />
					<jmesa:htmlColumn property="orgChnName" title="机构名称" sortable="false"  filterable="false" editable="false" />
					<jmesa:htmlColumn property="type" title="账户类型" sortable="false" filterable="false"	editable="false" />
					<jmesa:htmlColumn property="state" title="账户状态" sortable="false" filterable="false"	editable="false" />
					<jmesa:htmlColumn property="created" title="开通时间" pattern="yyyy-MM-dd" cellEditor="org.jmesa.view.editor.DateCellEditor" sortable="false" filterable="false" editable="false" />
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel>
	</form>
</body>
</html>
