<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>认证日志列表</title>
<%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa"%>
<link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
<script type="text/javascript">
	function onInvokeAction(id) {
		var parameterString = $.jmesa.createParameterStringForLimit(id);
		location.href = '${pageContext.request.contextPath}/view/admin/auth/cerRec/Up-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY")%>&QD_startDate=<%=request.getAttribute("QD_startDate")%>&QT_accountType=<%=request.getAttribute("QT_accountType")%>&QT_accountState=<%=request.getAttribute("QT_accountState")%>&QT_systemUserId=<%=request.getAttribute("QT_systemUserId")%>&QT_chineseName=<%=request.getAttribute("QT_chineseName")%>&'
				+ parameterString;
	}
	function onInvokeExportAction(id) {
		var parameterString = $.jmesa.createParameterStringForLimit(id);
		location.href = '${pageContext.request.contextPath}/view/admin/auth/cerRec/Up-list.action?'
				+ parameterString;
	}
	function twoClick(id) {
		window.parent.parent.parent.mainDown.location.href = "${pageContext.request.contextPath}/view/admin/auth/cerRec/Main-downMain.action?QA_PARENT_ROW_KEY="+ id;			
	}
	function selectedAll() {
		var t = document.getElementById("tableId");
		var rows = t.getElementsByTagName("tr");
		var itemsObj = document.getElementsByName("items");
		rows[1].style.backgroundColor = "#80bdff";
		var id=itemsObj[0].value;
		window.parent.parent.parent.mainDown.location.href = "${pageContext.request.contextPath}/view/admin/auth/cerRec/Main-downMain.action?QA_PARENT_ROW_KEY="+ id;
	}
</script>
</head>
<body onload="selectedAll()">
	<form name="tableId" action="#">
		<jmesa:tableModel id="tableId" autoFilterAndSort="false"
			items="${object_items}" maxRows="15" exportTypes=""
			maxRowsIncrements="15,30,50" stateAttr="restore" var="bean"
			view="com.uap.core.web.jmesa.view.QXTView"
			toolbar="com.uap.core.web.jmesa.view.QXTToolBar">
			<jmesa:htmlTable captionKey="presidents.caption" width='100%'>
				<jmesa:htmlRow>				
            		<input type="hidden" name="items" value="${bean.systemUserId}" onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/>
					<jmesa:htmlColumn property="chineseName" title="姓名" sortable="false" filterable="false" editable="false" />
					<jmesa:htmlColumn property="accountCode" title="主帐号" sortable="false" filterable="false" editable="false" />
					<jmesa:htmlColumn property="accountState" title="状态" filterable="false"	editable="false" sortable="false"/>
					<jmesa:htmlColumn property="accountType" title="类型"	filterable="false" editable="false" sortable="false"/>
					<jmesa:htmlColumn property="cerNum" title="认证次数"		filterable="false" editable="false" sortable="false"/>
					<jmesa:htmlColumn property="cerPassNum" title="通过次数"		filterable="false" editable="false" sortable="false"/>
					<jmesa:htmlColumn property="firstCerTime" pattern="yyyy-MM-dd"	cellEditor="org.jmesa.view.editor.DateCellEditor" title="首次认证时间"	filterable="false" editable="false" sortable="false"/>
					<jmesa:htmlColumn property="lastCerTime" pattern="yyyy-MM-dd"	cellEditor="org.jmesa.view.editor.DateCellEditor" title="末次认证时间"	filterable="false" editable="false" sortable="false"/>
					<jmesa:htmlColumn property="createOrgName" title="开户机构" sortable="false"	filterable="false" editable="false" />
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel>
	</form>
</body>
</html>
