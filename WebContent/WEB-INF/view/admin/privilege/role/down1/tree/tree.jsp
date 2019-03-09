<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="import.jsp"%>
<link
	href="<%=request.getContextPath() %>/resource/widget/tree/css/zTreeStyle.css"
	rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.0.min.js"></script>
<script src="<%=request.getContextPath() %>/resource/widget/tree/jquery.ztree.core-3.5.js"></script>
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
	async: {
		enable: true,
		url:"${pageContext.request.contextPath}/view/admin/privilege/role/Down1-currentTree.action?QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>",
		autoParam:["id=parentTreeNode"]
	}
};
function initZtree(){
    $.ajax({               
        type: "POST",               
        dataType: "json",               
        url: '${pageContext.request.contextPath}/view/admin/privilege/role/Down1-currentTree.action?parentTreeNode=0000&QA_PARENT_ROW_KEY=<%= request.getAttribute("QA_PARENT_ROW_KEY")  %>',   
        success: function(data) {   
            zNodes=data;
            $.fn.zTree.init($("#tree"), setting, zNodes);
            open1();
        }   
    });  
}
function  open1(){
	var zTree = $.fn.zTree.getZTreeObj("tree");
	var node = zTree.getNodesByFilter(function (node) { return node.level == 0 }, true);
	if (node != null) {
		zTree.selectNode(node);
		zTree.expandNode(node, true, true, true);
	}
}



</script>
</head>
<body>
		<div >
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>