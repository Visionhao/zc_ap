<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../import.jsp"%>
<title>查询条件</title>
<link type="text/css" href="${pageContext.request.contextPath}/resource/tools/common/navigation.css"  rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resource/tools/common/navigation.js"></script>
<script type="text/javascript">
	function condition() {
		document.getElementById("div1").style.display="block";
		document.getElementById("QT_formId").value="请输入表单编号";
	}
	function hidd() {
		document.getElementById("div1").style.display="none";
		document.searchForm.reset();
	}
	function checkTheForm() {
		if(document.getElementById("QT_formId").value=="请输入表单编号"){
			document.getElementById("QT_formId").value="";
		}
		document.upListTemplateForm.submit();
	}
	function clickSearchForm() {
		document.getElementById("div1").style.display="none";
		document.searchForm.submit();
	}
	function mp_confirm(title, content, height, ids) {
		mp_confirm_base(title, content);
		$("#dialog-confirm").dialog({
			resizable : false,
			height : height,
			modal : true,
			buttons : {
				'确定' : function() {
					$(this).dialog('close');
					del(ids);
				},
				'取消' : function() {
					$(this).dialog('close');
				}
			}
		});
	}
	function reset() {
		var e = document.getElementsByTagName("input");
		for (var i = 0; i < e.length; i++) {
			if (e[i].type == "text") {
				e[i].value = '';
			}
		}
	}
	function getIfrmaeCheckValue(objThis, iframeName, checkName, opt) {
		var skip = 0;
		var modifyUrl = "${pageContext.request.contextPath}/view/admin/privilege/form/Up-editPage.action?id=";
		var ids = "";
		var iframeObject = window.frames[iframeName];
		var itemsObj = iframeObject.document.getElementsByName(checkName);
		for (var i = 0; i < itemsObj.length; i++) {
			if (itemsObj[i].checked == true) {
				if ((opt == 'edit' || opt=='show') && skip > 0) {
					mp_alter("提示", "每次只能操作一条记录");
					return;
				} else {
					ids += itemsObj[i].value + ",";
				}
				skip++;
			}
		}
		if (ids == "") {
			mp_alter("提示", "请选择一条记录");
			return;
		}
		ids = ids.substring(0, ids.length - 1);
		var comp = modifyUrl + ids;
		if (opt == 'delete') {
			mp_confirm('确认提示', '是否删除该信息?', 180, ids);
		}
		if (opt == 'edit') {
			openwindow(comp, '修改表单信息', 600, 550);
		}
		if(opt == 'show'){
			 var url = "${pageContext.request.contextPath}/view/admin/privilege/form/Up-show.action?id="+ ids;
        	 openwindow(url,'查看表单信息',600,550); 
		}
	}
	function del(ids){
		$.ajax({  
            url:'${pageContext.request.contextPath}/view/admin/privilege/form/Up-delete.action',//先走校验的action   
            type:"POST",          
            data:"id="+ids,       
            dataType:'text',  
            success:function(obj){
            	if(obj=="yes"){
            		alert("删除成功");
            		ref();
            	}else{
            		alert("删除失败");
            	}
            }
        });
	}
	$(function() {
		$("#add-info")
				.click(
						function() {
							openwindow(
									'${pageContext.request.contextPath}/view/admin/privilege/form/Up-addPage.action',
									'新增表单信息', 600, 550);
						});
	});
	function ref(){
		var url="${pageContext.request.contextPath}/view/admin/privilege/form/Up-main.action";
		window.location.href=url;
	}
</script>
</head>
<body>
<form name="upListTemplateForm" action="<%=request.getContextPath()%>/view/admin/privilege/form/Up-list.action" method="post" target="upListFrame">	
<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
<table class="dataTable">
	<tr valign="top" >
		<td valign="top" >
     				<div class="tool-btn">
                		<a href="#"  id="add-info"  title="新增"  class="icon-new"></a>
	          			<a href="#" title="修改" onclick="getIfrmaeCheckValue(this,'upListFrame','items','edit')"  class="icon-edit"></a>
	          			<a href="#" title="查看" onClick="getIfrmaeCheckValue(this,'upListFrame','items','show')"  class="icon-show"></a>
	          			<a href="#" title="刷新"  class="icon-refresh" onclick="ref()"></a>
             			<a href="#" title="删除" onClick="getIfrmaeCheckValue(this,'upListFrame','items','delete')" class="icon-delete"></a>	
             		</div>
             		<div class="search">
               			 <input type="text" maxlength="32" class="search-text" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" id="QT_formId" name="QT_formId"  value="请输入表单编号" /> 
               			 <a  class="h-search"  href="###" title="更多查询" onclick="condition()" >更多查询</a>
            		 </div>
			  </td>
			<tr>
				<td valign="top"><iframe id="upListFrame" name="upListFrame"
					src="<%=request.getContextPath()%>/view/admin/privilege/form/Up-list.action"
					width='100%' height='400' frameborder="0"></iframe></td>
			</tr>
		</table>
		</form>
	<div id="div1" class="div1">
		<div  class="title">更多查询
			<a href="#" onclick="javascrtip:hidd()"><span id="span2" style="background-color:#02a4e8; cursor: pointer"><img src="${pageContext.request.contextPath}/resource/images/standard/cancel.png" style="float: right;"></span></a>
		</div>
		<hr/>
		<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
		<form id="searchForm" name="searchForm" action="<%=request.getContextPath()%>/view/admin/privilege/form/Up-list.action" method="post" target="upListFrame">
			<div class="content">
				<table class="more-search-table">
					<tr>
						<tr>
						<td class="word">表单名称</td>
						<td><input type="text" name="QT_formName" id="QT_formName" style="width:180px" /></td>
						<td class="word">功能名称</td>
						<td><input type="text" id="QT_functionName" name="QT_functionName" style="width:180px" /></td>
					</tr>
				</table>
			</div>
			<hr/>
			<div class="foot">
				<div class="btnbox_query"><a class="confirmBtn" title="查询"  id="save-btn" href="###" onclick="javascript:clickSearchForm();">查 询</a></div>
			</div>
		</form>
	</div>
</body>
</html>