<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>操作键信息列表</title>
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
             location.href = "${pageContext.request.contextPath}/view/admin/privilege/access/Do-list.action?QT_accessId=<%=request.getAttribute("QT_accessId") %>&QT_accessChnName=<%=request.getAttribute("QT_accessChnName") %>&QT_accessEngName=<%=request.getAttribute("QT_accessEngName") %>&QT_actionUrl=<%=request.getAttribute("QT_actionUrl") %>&QT_type=<%=request.getAttribute("QT_type") %>&" + parameterString;
          }
         function onInvokeExportAction(id) {
             var parameterString = $.jmesa.createParameterStringForLimit(id);
             location.href = '${pageContext.request.contextPath}/view/admin/privilege/access/Do-main.action?' + parameterString;
         }
         function setAllCheckboxState(){
         	//被选中后改变颜色
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
            <jmesa:htmlTable captionKey="presidents.caption" width='100%' >		
                <jmesa:htmlRow>	 
					<jmesa:htmlColumn sortable="false"  title="<input type='checkbox' id='all' onclick=\"setAllCheckboxState()\" >" >
            		<input type="checkbox" name="items"  value="${bean.accessId}" onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/> 
            		</jmesa:htmlColumn>
                    <jmesa:htmlColumn property="accessId" title="操作键编号" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accessChnName" title="中文名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accessEngName" title="英文名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="actionUrl" title="动作路径" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="type" title="类型" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accessNo" title="序号" sortable="false" filterable="false" editable="false"/>
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>   
        </form>
    </body>
    
</html>
