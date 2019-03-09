<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="tag" uri="/uap-tags" %>
<%@ include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    <title>新增菜单信息</title>
    <link href="<c:url value="/resource/tools/jmesa/css/jmesa.css"/>" rel="stylesheet" type="text/css">
    <link href="<c:url value="/resource/tools/jmesa/css/web.css"/>" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidator.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidatorRegex.js"type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/showErrors.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.core.js"></script>
	<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.widget.js"></script>
	<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePicker.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePickerJavaAdaptor.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/tools/jquery/validator/formcheck.css" />
	<script type="text/javascript">
	jQuery(document).ready(function(){
		jQuery.formValidator.initConfig({
	        formid: "addForm",
	        submitonce: true,
	        onerror: showCustomErrors,
	         onsuccess:function(){
	       	 validate=true;
	 			var options = {    
	 			     success : function(obj){
	 			    	 if(obj=='yes'){
	 			    		 alert("添加成功");
	 			    		closeWin();
	 			    	 }else{
	 			    		 alert("添加失败");
	 			    	 }
	 			     },
	 			     type:"post",                     
	 			     resetForm : true
	 			};  
	 			jQuery("#addForm").ajaxSubmit(options);  
	 			return false;
	         }
	    });
		jQuery("#fusCatalogId").formValidator().inputValidator({
            min: 1,
            max:32,
            type:"size",
            onerror:"不能为空或长度不对,长度为1~32个字符"
         });
		jQuery("#parentCataLogName").formValidator().inputValidator({
            min: 1,
            type:"size",
            onerror:"不能为空,请输入上级目录"
         });
	   jQuery("#chnName").formValidator().inputValidator({
           min: 1,
           max:20,
           type:"size",
           onerror:"不能为空或长度不对,长度为1~10个中文"
        });
	   jQuery("#orgCode").formValidator().inputValidator({
           min: 1,
           max:32,
           type:"size",
           onerror:"不能为空或长度不对,长度为1~32个字符"
        });
	   jQuery("#orgCode").formValidator().inputValidator({
           min: 1,
           max:32,
           type:"size",
           onerror:"不能为空或长度不对,长度为1~32个字符"
        });
	   jQuery("#seqno").formValidator().inputValidator({ 
		     min:1,
	         max:2,
	         type:"size",
	         onerror:"不能为空,长度为1~2位数字"
		}).regexValidator({ 
		   regexp: regexEnum.intege1,
		   onerror:"格式不正确,请输入数字"
		});
	});	 
	function doAdd(){
		var menuText = document.getElementById('menutext').innerHTML;
		if(menuText!="该菜单编号已被使用，请重新输入"){
			jQuery("#addForm").submit();
		}
	}
	function reset(){
		jQuery("#addForm")[0].reset();
	}
	function closeWin(){
		var url = "${pageContext.request.contextPath}/view/admin/privilege/menu/Do-main.action";
		window.parent.location.href=url;
	}
	function validate(val) {
    	var menuText = document.getElementById('menutext');
    	var id = document.getElementById('fusCatalogId');
    	if(id.value!=""){
			$.ajax({  
		            url:'${pageContext.request.contextPath}/view/admin/privilege/menu/Validate/Down-Validate.action',//先走校验的action   
		            type:"POST",          
		            data:"resId="+val,       
		            dataType:'text',  
		            success:function(obj){
		            	if(obj=="yes"){
		            		menuText.innerHTML = "该菜单编号已被使用，请重新输入";
		            	}else{
		            		menuText.innerHTML = "&nbsp;*";
		            	}
		            }
		        }); 
    	}
	};
	</script>	
    </head>
    <body>
    <form id="addForm" name="addForm" action="${pageContext.request.contextPath}/view/admin/privilege/menu/Do-add.action" method="post">
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增目录信息</th>
        		</tr>
        		<tr>
        			<td class="word">菜单编号</td>
        			<td ><input id="fusCatalogId" name="ResCatalog!fusCatalogId" onblur="validate(this.value)" class="inputtext" type="text"  /> <font id="menutext" class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">中文名</td>
        			<td ><input id="chnName" name="ResCatalog!chnName"  class="inputtext"   type="text"  /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">英文名</td>
        			<td ><input  id="engName" name="ResCatalog!engName"  class="inputtext"    type="text"  /> </td>
        		</tr>
        		<tr>
        			<td class="word">图标</td>
        			<td ><input type="text" id="icon" name="ResCatalog!icon"  class="inputtext"  /> </td>
        		</tr>
        		<tr>
        			<td class="word">序列号</td>
        			<td ><input type="text" id="seqno" name="ResCatalog!seqno" class="inputtext" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">是否激活</td>
        			<td >
        				<tag:radio name="ResCatalog!isactive" dictCode="dictionary.privilege.menu.status" /> 
        			</td>
        		</tr>
        		<tr>
        			<td class="word">上级目录</td>
        			 <td ><input id="parentCataLogName" readonly value="<c:out value="${resCatalog.chnName }"></c:out>" class="inputtext" style="background-color: #F5F5F5"/>
        			<input   id="parentCatalogId" name="ResCatalog!parentCatalogId"  class="inputtext" value="<c:out value="${resCatalog.fusCatalogId }"></c:out>"   type="hidden" /> </td>
        		</tr>
        		<tr>
        			<td class="word">目录类型</td>
        			<td >
        				<tag:radio name="ResCatalog!catalogType" dictCode="dictionary.privilege.menu.type" /> 
					</td>
        		</tr>
        		<tr>
        			<td class="word">关联功能</td>
        			<td >
        				<input id="openName" name="openName" readonly="readonly" class="inputtext" type="text" onclick="javasrcipt:openwindow('${pageContext.request.contextPath}/view/admin/privilege/menu/Do-alertSelect.action','功能列表信息',1000,600)" /><input type="hidden" name="ResCatalog!fusId" id="fusId" />
        			</td>
        		</tr>
        	</tbody>
        </table>
        <div class="btnbox"><a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重 置</a><a class="confirmBtn" title="保 存"  id="save-btn" href="###" onclick="javascript:doAdd();">保 存</a></div>
      </form>
    </body>
</html>
