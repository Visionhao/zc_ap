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
	$("#edit").bind("click", edit);
	$("#add").bind("click", add);
	$("#del").bind("click", del);
});
var zNodes="";
var setting = {
	view: {
		showIcon: false
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	async: {
		enable: true,
		url:"${pageContext.request.contextPath}/view/admin/privilege/menu/Do-currentTree_async.action",
		autoParam:["id=parentTreeNode"]
	}
};
function initZtree(){
    $.ajax({               
        type: "POST",               
        dataType: "json",               
        url: '${pageContext.request.contextPath}/view/admin/privilege/menu/Do-currentTree_async.action?parentTreeNode=0000',   
        success: function(data) {   
            zNodes=data;
            $.fn.zTree.init($("#tree"), setting, zNodes);
            open1();
        }   
    });
}
function  open1(){
	var zTree = $.fn.zTree.getZTreeObj("tree");
	var node = zTree.getNodesByFilter(function (node) { return node.level == 0}, true);
	if (node != null) {
		zTree.selectNode(node);
		zTree.expandNode(node, true, false, false);
	}
}
function edit(e) {
	var zTree = $.fn.zTree.getZTreeObj("tree");
	var id = "";
	var nodes = zTree.getSelectedNodes();
	if (nodes.length == 0) {
		alert("请先选择一个节点");
		return;
	}else{
		 for(var i=0;i<nodes.length;i++){
			id = nodes[i].id;
		 }
	}
	var url = "${pageContext.request.contextPath}/view/admin/privilege/menu/Do-editPage.action?UAP_TREE_ID="+id;
	window.parent.right.location.href=url;
};
function confirm_sure(id){
	$.ajax({  
        url:'${pageContext.request.contextPath}/view/admin/privilege/menu/Do-delete.action',//先走校验的action   
        type:"POST",          
        data:"id="+id,       
        dataType:'text',  
        success:function(obj){
        	if(obj=="yes"){
        		alert("删除成功");
        		refresh();
        	}else{
        		alert("删除失败");
        	}
        }
    });
}
function del(e) {
	var zTree = $.fn.zTree.getZTreeObj("tree");
	var id = "";
	var nodes = zTree.getSelectedNodes();
	if (nodes.length == 0) {
		alert("请先选择一个节点");
		return;
	}else{
		 for(var i=0;i<nodes.length;i++){
			id = nodes[i].id;
		 }
	}
    if(window.confirm('是否删除该信息？')){
		confirm_sure(id);
		return true;
	}else{
		return false;
	}
};
function add(e) {
	var zTree = $.fn.zTree.getZTreeObj("tree");
	var id = "";
	var nodes = zTree.getSelectedNodes();
	if (nodes.length == 0) {
		alert("请先选择一个节点");
		return;
	}else{
		 for(var i=0;i<nodes.length;i++){
			id = nodes[i].id;
		 }
	}
	var url = "${pageContext.request.contextPath}/view/admin/privilege/menu/Do-addPage.action?parentId="+id;
	window.parent.right.location.href=url;
};
function showIconForTree(treeId, treeNode) {
	return !treeNode.isParent;
};
function refresh(){
	var url = "${pageContext.request.contextPath}/view/admin/privilege/menu/Do-main.action";
	window.parent.location.href=url;
}
</script>
</head>
<body>
		<div style="width: 130px;padding-left: 10px;" class=treeFormTool>
			<span class="tool"> 
			<a href="#" id="add" title="新增" class="icon-new"></a>
			<a id="edit" href="#" title="修改" class="icon-edit"></a> 
			<a href="#" title="刷新" class="icon-refresh" onclick='refresh()' ></a>
			<a href="#" id="del" title="删除"class="icon-delete"></a>
			</span>
		</div>
	<p style="border-bottom: 0.5px solid #BCBCBC;padding-top: 10px;">
		<div style="padding-top: 5px;" >
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>