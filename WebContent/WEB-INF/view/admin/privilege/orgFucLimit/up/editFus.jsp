<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../import.jsp"%>
<link href="<%=request.getContextPath() %>/resource/widget/tree/css/zTreeStyle.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.0.min.js"></script>
<script src="<%=request.getContextPath() %>/resource/widget/tree/jquery.ztree.core-3.5.js"></script>
<script src="<%=request.getContextPath() %>/resource/widget/tree/jquery.ztree.excheck-3.5.js"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidator.js" type="text/javascript" ></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidatorRegex.js"type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/showErrors.js" type="text/javascript" ></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	initZtree();
});
var zNodes="";
var setting = {
		check: {
			enable: true
		},
	view: {
		showIcon: false
	},
	data: {
		simpleData: {
			enable: true
		},
		key: {
			url:'#'
		}
	}
};
function initZtree(){
    $.ajax({               
        type: "POST",               
        dataType: "json",               
        url: '${pageContext.request.contextPath}/view/admin/privilege/menu/Do-currentTree.action?parentTreeNode=0000',   
        success: function(data) {   
            zNodes=data;
            $.fn.zTree.init($("#tree"), setting, zNodes);
            onCheckNode();
        }   
    });  
}
function onCheckNode(){
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	//treeObj.expandAll(true);
	var treeIds = "<%=request.getAttribute("treeIds") %>";
	var str= new Array(); 
	str = treeIds.split(",");
	for(var i = 0;i<str.length;i++){
		var node = treeObj.getNodeByParam("id", str[i], null);
		if(node !=null){
			treeObj.checkNode(node,true,true);
		}
	}
    var node = treeObj.getNodesByFilter(function (node) { return node.level == 0 }, true);
	if (node != null) {
		treeObj.selectNode(node);
		treeObj.expandNode(node, true, false, true);
	}
}
jQuery(document).ready(function(){
	jQuery.formValidator.initConfig({
        formid: "editForm",
        submitonce: true,
        onerror: showCustomErrors,
         onsuccess:function(){
       	 validate=true;
 			var options = {    
 			     success : closeWin,
 			     type:"post",                     
 			     resetForm : true
 			};  
 			jQuery("#editForm").ajaxSubmit(options);  
 			return false;
         }
    });
});
function doEdit(){
	var treeObj=$.fn.zTree.getZTreeObj("tree");
    var nodes=treeObj.getCheckedNodes(true);
    var v="";
    for(var i=0;i<nodes.length;i++){
        v+=nodes[i].id + ",";
    }
    document.getElementById("ids").value=v;
	jQuery("#editForm").submit();
}
function reset(){
	jQuery("#editForm")[0].reset();
}
function closeWin(){
	window.close();
	window.opener.location.reload();
}
</script>
</head>
<body>
	<form id="editForm" name="editForm" action="<%=request.getContextPath()%>/view/admin/privilege/orgFucLimit/Up-editFus.action">
	<input type="hidden"  id="ids" name="ids" />
	<input type="hidden"  id="ORG_ACCOUNT_ID" name="ORG_ACCOUNT_ID"  value="<%=request.getAttribute("QA_PARENT_ROW_KEY") %>"/>
	<center>
		<div style="width: 200px;margin-top: 20px;" >
				<table>
					<tr align="center"><ul id="tree" class="ztree"></ul></tr>
				</table>
		</div>
	</center>
		<div align="center" >有效时间:<input id="expireDate" value="<fmt:formatDate value="${expDate}" pattern="yyyy-MM-dd"  type="date"></fmt:formatDate>" name="expireDate" type="text" class="Wdate" onclick="WdatePicker({minDate:'{%y+1}-%M-%d'})"/>
		</div>
		<div align="center"  class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a><a class="confirmBtn" title="保存"  id="save-btn" href="###" onclick="javascript:doEdit();">保 存</a></div>
	</form>
</body>
</html>