<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>认证日志列表</title>
    <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
    <link href="${pageContext.request.contextPath}/resource/tools/jmesa/css/jmesa.css"" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resource/tools/jmesa/css/web.css"" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
    <script type="text/javascript">
            function onInvokeAction(id) { 
            	var parameterString = $.jmesa.createParameterStringForLimit(id);
            	location.href = "${pageContext.request.contextPath}/view/admin/auth/cerRec/Down-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>&QT_clientIp=<%=request.getAttribute("QT_clientIp")%>&QT_cerType=<%=request.getAttribute("QT_cerType")%>&QT_cerResult=<%=request.getAttribute("QT_cerResult")%>&QD_startcerTime=<%=request.getAttribute("QD_startcerTime")%>&"+ parameterString;
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = '${pageContext.request.contextPath}/view/admin/auth/cerRec/Do-list.action?' + parameterString;
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
                toolbar="com.uap.core.web.jmesa.view.QXTToolBar"  
                >
            <jmesa:htmlTable captionKey="presidents.caption" width='99%'>		
                <jmesa:htmlRow>	 
            		<input type="hidden" name="items"  value="${bean.cerRecId}" onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/>            		
                    <jmesa:htmlColumn property="cerTime" title="认证时间"  pattern="yyyy-MM-dd hh:mm:ss" cellEditor="org.jmesa.view.editor.DateCellEditor" sortable="false" filterable="false" editable="false"/> 
                    <jmesa:htmlColumn property="cerType" title="认证方式"  sortable="false"   filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="cerResult" title="认证结果" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="clientIp" title="客户端IP"  sortable="false"  filterable="false" editable="false"/>                    
                    <jmesa:htmlColumn property="serverIp" title="服务端IP"  sortable="false"  filterable="false" editable="false"/>       
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>
        </form>
    </body>
</html>
