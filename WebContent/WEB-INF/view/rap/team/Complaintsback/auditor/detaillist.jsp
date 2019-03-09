<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>投诉内容模式的列表页面</title>
    <%@ include file="../import.jsp"%>
    <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
    <link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
    <link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
    <script type="text/javascript">
            function onInvokeAction(id) { 
            	 var parameterString = $.jmesa.createParameterStringForLimit(id);
                 location.href = "${pageContext.request.contextPath}/view/rap/team/Complaintsback/ComplaintsBackAction-detailList.action?QT_mobile=<%=request.getAttribute("QT_mobile") %>&QT_port=<%=request.getAttribute("QT_port") %>&QT_content=<%=request.getAttribute("QT_content") %>&QD_month=<%=request.getAttribute("QD_months") %>&QT_membersId=<%=request.getAttribute("QT_membersId") %>&" + parameterString;
             }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = '${pageContext.request.contextPath}/view/eop/customer/custApp/main/Do-main.action?' + parameterString;
            }
	 </script>
    </head>
    <body>
       <form style="margin-right: 4px;" name="tableId" action="#">
            <jmesa:tableModel
                id="tableId" autoFilterAndSort="false"
                items="${object_items}"
                maxRows="15"
                exportTypes="" 
                maxRowsIncrements="15,30,50"
                stateAttr="restore"
                var="bean" 
                view="com.uap.core.web.jmesa.view.QXTView" 
                toolbar="com.uap.core.web.jmesa.view.QXTToolBar"  >
            <jmesa:htmlTable captionKey="presidents.caption" width='100%' >		
                <jmesa:htmlRow>	 
                	<input type="hidden" name="items" value="${bean.id}"/>
                    <jmesa:htmlColumn property="complainPhone" title="投诉号码" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="complainPort" title="投诉端口" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="complainContent" title="投诉内容" sortable="false" filterable="false" editable="false">
                      <span title="${bean.complainContent }">
                    	<c:choose>
                    	<c:when test="${fn:length(bean.complainContent)>12}">${fn:substring(bean.complainContent,0,20) }...</c:when>
                    	<c:otherwise>${bean.complainContent }</c:otherwise>
                    	</c:choose>
                     </span> 
                     </jmesa:htmlColumn>
                    <jmesa:htmlColumn property="complainDate" title="投诉时间" sortable="false" filterable="false" editable="false">
                    	<span title="${bean.complainDate }">
                    	<c:choose>
	                    	<c:when test="${fn:length(bean.complainDate)>11}">${fn:substring(bean.complainDate,0,10)}</c:when>
	                    	<c:otherwise>${bean.complainDate }</c:otherwise>
                    	</c:choose>
                    	</span>
                    </jmesa:htmlColumn>
                    <jmesa:htmlColumn property="auditDate" title="审核时间" pattern="yyyy-MM-dd" cellEditor="org.jmesa.view.editor.DateCellEditor" sortable="false" filterable="false" editable="false"/>	
                    <jmesa:htmlColumn property="membersId" title="审核人" sortable="false" filterable="false" editable="false"/>
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>   
        </form> 
    </body>
</html>
