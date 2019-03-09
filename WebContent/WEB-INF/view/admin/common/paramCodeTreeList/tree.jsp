<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="<%=request.getContextPath() %>/resource/widget/tree/css/zTreeStyle.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.0.min.js"></script>
<script src="<%=request.getContextPath() %>/resource/widget/tree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initZtree();
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
	}
};

function initZtree(){
    $.ajax({               
        type: "POST",               
       dataType: "json",               
        url: getURL(),   
        success: function(data) {   
            zNodes=data;
            $.fn.zTree.init($("#tree"), setting, zNodes);
            open1();
       }   
    });  
}
function getURL(){
	var url = "${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-currentTree.action?treeName=参数代码";
    url = encodeURI(url);
    url = encodeURI(url);
	return url ;
}
function showIconForTree(treeId, treeNode) {
	return !treeNode.isParent;
};
</script>
</head>
<body>
	<div >
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>