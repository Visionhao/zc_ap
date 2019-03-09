<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>功能信息列表</title>
    <%@ include file="import.jsp"%>
    <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
    <link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
    <link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
    <script type="text/javascript">
            function onInvokeAction(id) { 
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = "${pageContext.request.contextPath}/view/admin/privilege/fuct/Do-list.action?QT_isactive=<%=request.getAttribute("QT_isactive") %>&QT_engName=<%=request.getAttribute("QT_engName") %>&QT_engName=<%=request.getAttribute("QT_engName") %>&QT_chnName=<%=request.getAttribute("QT_chnName") %>&QT_engName=<%=request.getAttribute("QT_engName") %>&QT_fusId=<%=request.getAttribute("QT_fusId") %>&QT_type=<%=request.getAttribute("QT_type") %>&QT_url=<%=request.getAttribute("QT_url") %>&QT_jumpType=<%=request.getAttribute("QT_jumpType") %>&QT_mappingForward=<%=request.getAttribute("QT_mappingForward") %>&" + parameterString;
                
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = '${pageContext.request.contextPath}/view/admin/privilege/fuct/Do-main.action?' + parameterString;
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
            <jmesa:htmlTable 
                captionKey="presidents.caption" width='100%'>		
                <jmesa:htmlRow>	 
					<jmesa:htmlColumn sortable="false"  title="<input type='checkbox' id='all' onclick=\"setAllCheckboxState()\" >" >
            		<input type="checkbox" name="items"  value="${bean.id}"  onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/> 
            		</jmesa:htmlColumn>
                    <jmesa:htmlColumn property="fusId" title="资源编号" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="chnName" title="中文名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="engName" title="英文名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="type" title="资源类型" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="url" title="资源地址" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="isactive" title="状态" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="jumpType" title="跳转类型" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="mappingForward" title="映射路径" sortable="false" filterable="false" editable="false"/>
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>     
        </form>
    </body> 
</html>