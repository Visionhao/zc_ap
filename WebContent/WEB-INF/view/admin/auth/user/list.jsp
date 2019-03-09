<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户管理信息列表</title>
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
	           location.href = "${pageContext.request.contextPath}/view/admin/auth/user/Do-list.action?QT_accountCode=<%=request.getAttribute("QT_accountCode") %>&QT_accountSubcode1=<%=request.getAttribute("QT_accountSubcode1") %>&QT_accountSubcode2=<%=request.getAttribute("QT_accountSubcode2") %>&QT_chineseName=<%=request.getAttribute("QT_chineseName") %>&QT_type=<%=request.getAttribute("QT_type") %>&QT_state=<%=request.getAttribute("QT_state") %>&QD_created=<%=request.getAttribute("QD_created") %>&QD_endcreated=<%=request.getAttribute("QD_endcreated") %>&" + parameterString;
	       }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = '${pageContext.request.contextPath}/view/admin/auth/user/Do-main.action?' + parameterString;
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
                toolbar="com.uap.core.web.jmesa.view.QXTToolBar"  
                >
            <jmesa:htmlTable 
                captionKey="presidents.caption"
               width='100%'>		
                <jmesa:htmlRow>	 
					<jmesa:htmlColumn sortable="false"  title="<input type='checkbox' id='all' onclick=\"setAllCheckboxState()\" >" >
            		<input type="checkbox" name="items"  value="${bean.id}" onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/> 
            		</jmesa:htmlColumn>
                    <jmesa:htmlColumn property="accountCode" title="主帐号" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accountSubcode1" title="辅帐号1" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accountSubcode2" title="辅帐号2" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="orgChnName" title="机构名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="chineseName" title="姓名" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="type" title="帐号类型" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="state" title="帐号状态" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="created" pattern="yyyy-MM-dd" cellEditor="org.jmesa.view.editor.DateCellEditor" title="开通时间"  filterable="false" editable="false"/>
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>
        </form>
    </body>
</html>
