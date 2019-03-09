<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>表单信息列表</title>
      <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
      <link href="${pageContext.request.contextPath}/resource/tools/jmesa/css/jmesa.css"" rel="stylesheet" type="text/css">
      <link href="${pageContext.request.contextPath}/resource/tools/jmesa/css/web.css"" rel="stylesheet" type="text/css">
      <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
      <script type="text/javascript">
            function onInvokeAction(id) { 
            	var parameterString = $.jmesa.createParameterStringForLimit(id);
            	location.href = "${pageContext.request.contextPath}/view/admin/privilege/form/Down1-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>&QT_accessId=<%=request.getAttribute("QT_accessId") %>&accessChnName=<%=request.getAttribute("accessChnName") %>&accessEngName=<%=request.getAttribute("accessEngName") %>&" + parameterString;
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = '${pageContext.request.contextPath}/view/admin/privilege/form/Down1-list.action?' + parameterString;
            }
	</script>      
    </head>
    <body>
        <form name="tableId" action="#">
            <jmesa:tableModel
                id="tableId" autoFilterAndSort="false"
                items="${object_items}"
                maxRows="15"
                exportTypes="" 
                maxRowsIncrements="15,30,50"
                stateAttr="restore"
                var="bean" 
                view="com.uap.core.web.jmesa.view.QXTView" 
                toolbar="com.uap.core.web.jmesa.view.QXTToolBar">
            <jmesa:htmlTable captionKey="presidents.caption" width='99%'>		
                <jmesa:htmlRow>	 
					<jmesa:htmlColumn sortable="false"  >
            		<input type="hidden" name="items"  value="${bean.accessId}" onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/> 
            		</jmesa:htmlColumn>
                    <jmesa:htmlColumn property="accessId" title="操作键编号" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accessChnName" title="中文名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accessEngName" title="英文名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="formId" title="所属表单" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="actionUrl" title="动作路径" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="type" title="类型" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accessNo" title="序号" sortable="false" filterable="false" editable="false"/>
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>  
        </form>
    </body>
</html>
