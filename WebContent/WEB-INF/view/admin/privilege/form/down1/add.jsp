<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>操作键授权</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="<c:url value="/view/admin/this.css"/>" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>

<script language="javascript">
//第一步
$(document).ready(function(){//控制div显示隐藏
	
	 $("#listdiv").css("display","block"); 
	  $(".tree_right").find("li").each(function(){
	   var str02=$(this).text(); 
	  if(str02.substring(str02.length-1)==";"){//当onfocus时候坚持右侧显示的li里值是否有";"
         $(this).text(str02.replace(";",""));//若有";"，则用空白替代掉
	     }
	     });
//第二步//控制ul列表显示隐藏
     $(".tree ul:first").show();//选择缺省状态下，tree下的第一个ul里所有元素都显示
	    $('.tree').find('b').click(function(){
		   var li_ul = $(this).next();//控制列表隐藏显示
		   var img_icon=$(this).find('img');//控制片加减图片轮换
			 if (li_ul.is(':visible')) {
			 	 li_ul.hide();
				} else {
				 li_ul.show();
			   }
	});
//第三步
	 	  $(".mepig li").click(function(){//往右侧增加li，及点击li自动删除
		    var abc=$(this);
	     if(abc.attr("class")=="a0"){
		$("#num").text($(".tree_right li").length+1);//添加动态显示添加数目
		 abc.attr("class","a1").clone().appendTo(".tree_right").click(function(){
		 $(this).remove();
		 abc.attr("class","a0");
		 $("#num").text($(".tree_right li").length);//删除动态显示添加数目
		    }); 
         }
	   });
//第四步

$("#save-btn").click(function(){//确定提交按钮触发事件
	var str01 ="";
	    $("#input_name").val($(".tree_right").find("li").each(function(){ 
			str01 += $(this).attr("id")+",";//设置右侧每个li里的字符串为变量
			}).text());
		
	   	 	if(str01==""){
	    		alert("请选择授权信息");
	    		return ;
	    	}
		 document.getElementById("ids").value=str01;
		 jQuery("#editForm").submit();
		
		 
		 
		});
		

	jQuery.formValidator.initConfig({
	    formid: "editForm",
	    submitonce: true,
	    onerror: showCustomErrors,
	     onsuccess:function(){
	   	 validate=true;
	 			var options = {    
	 			     success : function(obj){
	 			    	 if(obj=='yes'){
	 			    		 alert("保存成功");
	 			    		 closeWin();
	 			    	 }else{
	 			    		 alert("保存失败");
	 			    	 }
	 			     },
	 			     type:"post"
	 			};  
	 			jQuery("#editForm").ajaxSubmit(options);
	 			return false;
	         
	     }
	});
});

function closeWin(){
	window.close();	
    window.opener.location.reload();
	
}

function query(){
	var query = document.getElementById("searchText").value;
	var tablist = document.getElementById('boxlist').getElementsByTagName("li");
		 
	if(query==""){
		 for(var i = 0;i<tablist.length;i++){
			 tablist.item(i).style="display:block";  
		 }
	}
	 for(var i = 0;i<tablist.length;i++){
		 if(tablist.item(i).className=="a0" ){
			 tablist.item(i).style="display:none"; 
			 if(tablist.item(i).innerHTML.indexOf(query)>=0){
				tablist.item(i).style="display:block";  
			 }
		 }
	 }
}
</script>
</head>
<body>
	<form id="editForm" name="editForm" method="post" action="${pageContext.request.contextPath}/view/admin/privilege/form/Down1-add.action">
	<input type="hidden" id="ids" name="ids" />
	<input type="hidden" id="formId" name="formId" value="<%=request.getParameter("formId") %>" />
		<div id="listdiv" class="listdiv">
			<div>
				<input id="searchText" name="searchText" type="text"
					class="div_input" onBlur="javasctipt:query()" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>已选择</b>
			</div>
			<div id="boxlist" class="boxlist">
				<ul id="s" class="tree">
					<c:forEach items="${selectitemList}" var="selectItem"
						varStatus="vs">
						<li><b>${selectItem.className }</b>
							<ul class="mepig">
								<c:forEach items="${selectItem.items}" var="it">
									<li id="${it.itemId }" class="a0">${it.itemName }</li>
								</c:forEach>
							</ul></li>
					</c:forEach>
				</ul>
			</div>
			<div class="boxlist">
				<ul class="tree_right">
				</ul>
			</div>
			<div class="btnleftright">				
				<a class="confirmBtn" title="保存"  id="save-btn" href="###" >保 存</a></div>
			</div>
	</form>
</body>
</html>
