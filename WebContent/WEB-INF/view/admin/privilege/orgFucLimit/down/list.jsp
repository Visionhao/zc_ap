<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>授权信息列表</title>
        <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
      <link href="${pageContext.request.contextPath}/resource/tools/jmesa/css/jmesa.css"" rel="stylesheet" type="text/css">
      <link href="${pageContext.request.contextPath}/resource/tools/jmesa/css/web.css"" rel="stylesheet" type="text/css">
     <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
       <script type="text/javascript">
            function onInvokeAction(id) { 
                var parameterString = $.jmesa.createParameterStringForLimit(id);
               var url =  "${pageContext.request.contextPath}/view/admin/privilege/orgFucLimit/Down-list.action?QA_PARENT_ROW_KEY=<%=request.getAttribute("QA_PARENT_ROW_KEY") %>&QT_fusCatalogId=<%=request.getAttribute("QT_fusCatalogId") %>&QT_chnName=<%=request.getAttribute("QT_chnName") %>&QT_engName=<%=request.getAttribute("QT_engName") %>&"+ parameterString;
               location.href = url;
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = '${pageContext.request.contextPath}/view/admin/privilege/orgFucLimit/Down-list.action?' + parameterString;
            }
            function setAllCheckboxState(){
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
				return ;
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
                toolbar="com.uap.core.web.jmesa.view.QXTToolBar" >
            <jmesa:htmlTable captionKey="presidents.caption" width='99%'>		
                <jmesa:htmlRow>	 
              		<jmesa:htmlColumn sortable="false" >
            		<input type="hidden" name="items"  value="${bean.limitId}" onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/> 
            		</jmesa:htmlColumn>
                    <jmesa:htmlColumn property="fusCatalogId" title="功能编号" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="chnName" title="功能名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="engName" title="英文名称" sortable="false" filterable="false" editable="false"/> 
                    <jmesa:htmlColumn property="moduleName" title="上级模块名称"  sortable="false"   filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="effectDate" title="授权时间"  pattern="yyyy-MM-dd" cellEditor="org.jmesa.view.editor.DateCellEditor"  sortable="false" filterable="false" editable="false"/>  
                    <jmesa:htmlColumn property="expireDate" title="使用期限"  pattern="yyyy-MM-dd" cellEditor="org.jmesa.view.editor.DateCellEditor"   sortable="false" filterable="false" editable="false"/>  
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>
        </form>
    </body>
</html>
