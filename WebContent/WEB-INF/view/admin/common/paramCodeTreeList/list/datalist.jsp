<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="import.jsp" %>
<head>
      <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
      <link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
      <link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
      <link href="<c:url value="/resource/template/queryList/this.css"/>" rel="stylesheet" type="text/css" >
      <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  <script type="text/javascript">
	  function onInvokeAction(id) { 
	      var parameterString = $.jmesa.createParameterStringForLimit(id);
	      location.href = "${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-alertSelect.action?QT_typeCode=<%=request.getAttribute("typeCode") %>&" + parameterString;
	  }
      function twoClick(id) {
   		var typeCode="";
   		var t = document.getElementById("tableId");
   		var rows = t.getElementsByTagName("tr");
   		var itemsObj = document.getElementsByName("items");
   		for (var i = 0; i < itemsObj.length; i++) {
   			rows[i + 1].style.backgroundColor = "";
   			if (id == itemsObj[i].value) {
   				typeCode = rows[i+1].cells[0].innerHTML;
   			}
   		}
       	window.opener.document.getElementById("typeCode").value=typeCode;
       	window.close();	
      }
      function setAllCheckboxState(){
			var flag = document.getElementById("all").checked;
			var elements = document.getElementsByName("items");
			for (var i = 0; i < elements.length; i++) {
				if (elements[i].type != 'checkbox') {
					continue;
				} else {
					elements[i].checked = flag;
				}
			}
			return ;
	}
	function checkTheForm(){
		document.queryListTemplateForm.submit();
	}
</script>
</head>
<body >
<form name="queryListTemplateForm" action="${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-alertSelect.action" method="post">
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table>
	<tr valign="top" >
		<td valign="top" >
		<table id="searchArea" width="998" >
			<tr>
				<td valign="top">
				<div class="search-condition clearfix">
			      	<div class="search-table" >
			      	<div id="con1"><div class="field">类别编号</div><input name="QT_typeCode" value="${typeCode }" class="txt-input" type="text" id="QT_typeCode" style="width:180px" /></div>
			        </div>
          			<span class="search-btn"><a href="javascript:checkTheForm()" title="查询" class="icon-search"></a></span>
       				 </div>
			  </td>
			 </tr>
			</table>
			</td>
			</tr>
			<tr>
				<td><div style="height: 550px;overflow: auto;width: 99.8%;"><jmesa:tableModel id="tableId" autoFilterAndSort="false"
						items="${object_items}" maxRows="15" exportTypes=""
						maxRowsIncrements="15,30,50" stateAttr="restore" var="bean"
						view="com.uap.core.web.jmesa.view.QXTView"
						toolbar="com.uap.core.web.jmesa.view.QXTToolBar">
						<jmesa:htmlTable captionKey="presidents.caption" width='100%'>
							<jmesa:htmlRow>
			            			<input type="hidden" name="items"  value="${bean.id}" onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/> 
				                    <jmesa:htmlColumn property="typeCode" title="类别编号" sortable="false" filterable="false" editable="false"/>
				                    <jmesa:htmlColumn property="userShowName" title="名称"   filterable="false" editable="false" sortable="false"/> 
				                    <jmesa:htmlColumn property="shortName" title="简称"    filterable="false" editable="false" sortable="false"/>
				                    <jmesa:htmlColumn property="mnemonicCode" title="助记码"  filterable="false" editable="false" sortable="false"/>
				                    <jmesa:htmlColumn property="status" title="状态"  filterable="false" editable="false" sortable="false"/> 
				                    <jmesa:htmlColumn property="type" title="类型"  filterable="false" editable="false" sortable="false"/>
				                    <jmesa:htmlColumn property="createDate" pattern="yyyy-MM-dd" cellEditor="org.jmesa.view.editor.DateCellEditor" title="创建日期"  filterable="false" editable="false" sortable="false"/>
							</jmesa:htmlRow>
						</jmesa:htmlTable>
					</jmesa:tableModel>
				</div></td>
			</tr>
		</table>
		</form> 
</body>
</html>