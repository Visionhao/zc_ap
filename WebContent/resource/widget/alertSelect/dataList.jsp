<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <%@ taglib uri="/WEB-INF/tld/jmesa.tld" prefix="jmesa" %>
      <link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
      <link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
      <link href="<c:url value="/resource/template/queryList/this.css"/>" rel="stylesheet" type="text/css" >
           <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jquery.jmesa.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resource/tools/jmesa/js/jmesa.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  <script type="text/javascript">
            function onInvokeAction(id) { 
                $.jmesa.setExportToLimit(id, '');
                $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
            }
            
            
            function twoClick(id) {
        		var orgCode="";
        		var orgName="";
        		var t = document.getElementById("tableId");
        		var rows = t.getElementsByTagName("tr");
        		var itemsObj = document.getElementsByName("items");
        		for (var i = 0; i < itemsObj.length; i++) {
        			rows[i + 1].style.backgroundColor = "";
        			if (id == itemsObj[i].value) {
        				
        				orgCode = rows[i+1].cells[2].innerHTML;//企业ID
        				orgName = rows[i+1].cells[3].innerHTML;//企业名称
        			}
        		}
            	window.opener.document.getElementById("openId").value=orgCode;
            	window.opener.document.getElementById("openName").value=orgName;
            	window.close();	
            }
            function openwindow(url,name,iWidth,iHeight)  
            {  
                var url;                             //转向网页的地址;  
                var name;                            //网页名称，可为空;  
                var iWidth;                          //弹出窗口的宽度;  
                var iHeight;                         //弹出窗口的高度;  
                //获得窗口的垂直位置  
                var iTop = (window.screen.availHeight-30-iHeight)/2;         
                //获得窗口的水平位置  
                var iLeft = (window.screen.availWidth-10-iWidth)/2;            
                window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no');  
            }  
            
            function setAllCheckboxState(){
				var flag = document.getElementById("all").checked;
				var elements = document.getElementsByName("items");
				for (var i = 0; i < elements.length; i++) {
					if (elements[i].type != 'checkbox') {
						continue;
					} else {
						elements[i].checked = flag;
					}
				}
				return ;
			}
            
			function checkTheForm(){
				document.queryListTemplateForm.submit();
			}
</script>
</head>
<body >
<form name="queryListTemplateForm" action="<%=request.getContextPath()%>/view/widget/alert-alertSelect.action" method="post">

		
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table>
	<tr valign="top" >
		<td valign="top" >
		<table id="searchArea" width="998" >
			
			<tr>
				<td valign="top">
				<div class="search-condition clearfix">
			      	<div class="search-table" >
			      	<div id="con1"><div class="field">企业ID</div><input name="QT_orgCode" class="txt-input" type="text" id="QT_orgCode" style="width:180px" /></div>
			        </div>
			          
          			<span class="search-btn"><a href="javascript:checkTheForm()" title="查询" class="icon-search"></a></span>
       				 </div>
			  </td>
			 </tr>
			</table>
			</td>
			</tr>
			<tr>
				<td>
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
               width='100%'
                >		
                <jmesa:htmlRow>	 
                
					<jmesa:htmlColumn sortable="false"  title="<input type='checkbox' id='all' onclick=\"setAllCheckboxState()\" >" >
            			<input type="checkbox" name="items"  value="${bean.id}"/> 
            		</jmesa:htmlColumn>
                    <jmesa:htmlColumn property="orgAreaName" title="区域" sortable="true" filterable="false" editable="false"/>
                    <jmesa:htmlColumn  property="orgCode" title="企业ID"   filterable="false" editable="false"/> 
                    <jmesa:htmlColumn property="orgName" title="企业名"    filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="orgCreateDate" pattern="yyyy年MM月dd日" cellEditor="org.jmesa.view.editor.DateCellEditor" title="创建日期"  filterable="false" editable="false"/>
                    <jmesa:htmlColumn property="orgStatus" title="状态" sortable="true" filterable="false" editable="false"/>
                    
               </jmesa:htmlRow>
            </jmesa:htmlTable> 
            </jmesa:tableModel>
				</td>
			</tr>
		</table>
		</form> 
</body>
</html>