<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>已授权用户信息列表</title>
    <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
    <link href="${pageContext.request.contextPath}/resource/tools/jmesa/css/jmesa.css"" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resource/tools/jmesa/css/web.css"" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
    <script type="text/javascript">
         function onInvokeAction(id) { 
         	var parameterString = $.jmesa.createParameterStringForLimit(id);
			location.href = "${pageContext.request.contextPath}/view/admin/privilege/role/Down2-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>&QT_chineseName=<%=request.getAttribute("QT_chineseName") %>&QT_accountCode=<%=request.getAttribute("QT_accountCode") %>&" + parameterString;
         }
         function onInvokeExportAction(id) {
             var parameterString = $.jmesa.createParameterStringForLimit(id);
             location.href = '${pageContext.request.contextPath}/view/admin/privilege/role/Do-list.action?' + parameterString;
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
                toolbar="com.uap.core.web.jmesa.view.QXTToolBar"   >
            <jmesa:htmlTable captionKey="presidents.caption" width='99%' >		
                <jmesa:htmlRow>	 
                    <jmesa:htmlColumn  property="accountCode" title="主账号"  sortable="false"  filterable="false" editable="false"/> 
                    <jmesa:htmlColumn property="chineseName" title="姓名"  sortable="false"   filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="orgId" title="机构编号" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="state" title="账号状态" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="grantDate" title="角色分配时间"  pattern="yyyy-MM-dd" cellEditor="org.jmesa.view.editor.DateCellEditor"  sortable="false" filterable="false" editable="false"/>                     
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>
        </form>
    </body>
</html>
