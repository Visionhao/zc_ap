<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>机构账户信息列表</title>
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
	   		location.href = "${pageContext.request.contextPath}/view/admin/auth/orgAccount/Do-list.action?QT_orgId=<%=request.getAttribute("QT_orgId")%>&QT_orgChnName=<%=request.getAttribute("QT_orgChnName")%>&QT_accountCode=<%=request.getAttribute("QT_accountCode")%>&QT_principal=<%=request.getAttribute("QT_principal")%>&QT_state=<%=request.getAttribute("QT_state")%>&QD_openAccountDate=<%=request.getAttribute("QD_openAccountDate")%>&QD_endAccountDate=<%=request.getAttribute("QD_endAccountDate")%>&"
	   				+ parameterString;
	   	    }
            
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = '${pageContext.request.contextPath}/view/admin/auth/orgAccount/Do-main.action?' + parameterString;
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
            <jmesa:htmlTable captionKey="presidents.caption" width='100%'>		
                <jmesa:htmlRow>	 
					<jmesa:htmlColumn sortable="false"  title="<input type='checkbox' id='all' onclick=\"setAllCheckboxState()\" >" >
            		<input type="checkbox" name="items"  value="${bean.id}" onclick="this.parentNode.parentNode.style.backgroundColor=this.checked?'#80bdff':'#ffffff'"/> 
            		</jmesa:htmlColumn>
                    <jmesa:htmlColumn property="orgId" title="机构编号" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="orgChnName" title="机构名称" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="accountCode" title="机构帐户名" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="principal" title="联系人" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="grantAccountNum" title="授权账号数量" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="useAccountNum" title="已用账号数量" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="state" title="账户状态" sortable="false" filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="openAccountDate" pattern="yyyy-MM-dd" cellEditor="org.jmesa.view.editor.DateCellEditor" title="开户日期"  sortable="false" filterable="false" editable="false"/>
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>       
        </form> 
    </body>
</html>
