<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
    

    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All List widget<</title>
           <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
        
        
      <link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
      <link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
      
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery-1.3.min.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.bgiframe.pack.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.validate.min.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
      
    </head>
   
    
    
    <body>
        <form name="tableId" action="${pageContext.request.contextPath}/view/widget/listItems-allList.action">
            <jmesa:tableModel
                id="tableId" autoFilterAndSort="false"
                items="${object_items}"
                maxRows='${totalRows}'
                maxRowsIncrements='15,30,${totalRows}'
                exportTypes="" 
                stateAttr="restore"
                var="bean" 
                view="com.uap.core.web.jmesa.view.AllItemsView"
                toolbar="com.uap.core.web.jmesa.view.AllItemsToolBar"
                >
            <jmesa:htmlTable 
                captionKey="org.allList"
                 width="100%"
                >		
                <jmesa:htmlRow>	 
                    <jmesa:htmlColumn property="id" title="机构ID" sortable="false" filterable="false"/>
                    <jmesa:htmlColumn property="orgCode" title="机构编号" sortable="false" filterable="false"/>
                    <jmesa:htmlColumn property="orgName" title="机构名称"   sortable="false" filterable="false"/>
                    <jmesa:htmlColumn property="orgShortName" title="机构简称"   sortable="false" filterable="false"/>
                    <jmesa:htmlColumn property="orgArea" title="地区"   sortable="false" filterable="false"/>
                    <jmesa:htmlColumn property="orgType" title="机构类型"   sortable="false" filterable="false"/>
                    <jmesa:htmlColumn property="orgContacts" title="联系人"   sortable="false" filterable="false"/>
                    <jmesa:htmlColumn property="orgContactsTelephone" title="联系电话"  sortable="false"  filterable="false"/>
                    <jmesa:htmlColumn property="createDate" pattern="yyyy年MM月dd日" cellEditor="org.jmesa.view.editor.DateCellEditor" title="创建日期"  sortable="false" filterable="false"/>
                </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>
            
        </form>
        
        
       <script type="text/javascript">
            function onInvokeAction(id) { 
                $.jmesa.setExportToLimit(id, '');
                $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
            }
            
            function onInvokeExportAction(id) {
            alert('bb');
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = '${pageContext.request.contextPath}/view/queryListTemplate/listItems-allList.action?' + parameterString;
            }
        </script>
        
        
    </body>
    
</html>
