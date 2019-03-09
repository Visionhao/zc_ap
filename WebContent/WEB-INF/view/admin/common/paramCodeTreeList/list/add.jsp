<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>新增参数代码</title>
      <%@include file="import.jsp" %>
      <link href="${pageContext.request.contextPath}/view/admin/this.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
 	 	<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/widget/select/jQuery.FillOptions.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css">
		<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePicker.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePickerJavaAdaptor.js" type="text/javascript"></script>

	<script type="text/javascript">
	var opt = "doSave";
		jQuery(document).ready(function(){
			 jQuery.formValidator.initConfig({
			        formid: "addForm",
			        submitonce: true,
			        onerror: showCustomErrors,
			         onsuccess:function(){
			       	 validate=true;
				       	 if(opt=="doSave"){
				 			var options = {    
				 			     success : function(obj){
				 			    	 if(obj=='yes'){
				 			    		 alert("添加成功");
				 			    		closeWin();
				 			    	 }else if(obj=='no'){
				 			    		 alert("添加失败");
				 			    	 }else if(obj=='1'){
				 			    		alert("添加成功");
				 			    		addPage();
				 			    	 }else if(obj=='0'){
				 			    		alert("添加失败");
				 			    	 }
				 			     },
				 			     type:"post",                     
				 			     resetForm : true
				 			};  
				 			jQuery("#addForm").ajaxSubmit(options);
				 			return false;
				         }
			         }
			    });
			 
			 //代码系统标识
			 jQuery("#rowId").formValidator().inputValidator({
				  min: 1,
	              max:32,
	              type:"size",
	              onerror:"不能为空或长度不对,长度为1~20个字符"
		        }); 
			  //类别编号
			 jQuery("#typeCode").formValidator().inputValidator({
				  min: 1,
	              max:20,
	              type:"size",
	              onerror:"不能为空或长度不对,长度为1~20个字符"
		        }); 
			 //编号
			 jQuery("#codeNum").formValidator().inputValidator({
				  min: 1,
	              max:30,
	              type:"size",
	              onerror:"不能为空或长度不对,长度为1~30个字符"
		        }); 
			//名称
			   jQuery("#userShowName").formValidator().inputValidator({
				   min: 1,
		           max:50,
		           type:"size",
		           onerror:"不能为空或长度不对,长度为1~50个字符"
		        });
			   //简称
			   jQuery("#shortName").formValidator().inputValidator({ 
				   min: 1,
		           max:10,
		           type:"size",
		           onerror:"不能为空或长度不对,长度为1~10个字符"
				});

				 //助记码
			    jQuery("#mnemonicCode").formValidator().inputValidator({ 
			    	min: 1,
		            max:10,
		            type:"size",
		            onerror:"不能为空或长度不对,长度为1~10个字符"
					});
				
			 	//状态
			 	jQuery("#status").formValidator().inputValidator({ 
			    	min: 1,
		            onerror:"请选择状态"
					});
			 	//上级代码编号
			 	jQuery("#parentCodeNum").formValidator().inputValidator({ 
			    	min: 1,
		            max:30,
		            type:"size",
		            onerror:"不能为空或长度不对,长度为1~30个字符"
					});
			 	jQuery("#description").formValidator().inputValidator({
					max : 200,
					type : "size",
					onerror : "长度不对,请输入100个以内的字符"
				});
			 	
   });
	function addPage(){
		var url = "${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-addPage.action?nodePid=<%=request.getAttribute("nodePid") %>&QT_typeCode=<%=request.getAttribute("QT_typeCode") %>";
		window.location.href = url;
		window.opener.location.reload();
	}
	function doSave(){
		opt="doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该编号已被使用，请重新输入"){
			jQuery("#addForm").submit();
		}
	}
	function doSaveToAdd(){
		opt = "doSave";
		var menuText = document.getElementById('txt').innerHTML;
		if(menuText!="该编号已被使用，请重新输入"){
			jQuery("#addForm").attr("action", "${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-saveToAdd.action");;
			jQuery("#addForm").submit();
		}
	}
	function closeWin(){
		window.close();	
		var url = "${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-main.action";
		window.opener.parent.location.href=url;	
	}
	
	function reset(){
		jQuery("#addForm")[0].reset();
	}
	function validate(val) {
    	var menuText = document.getElementById('txt');
    	var id = document.getElementById('rowId');
    	if(id.value!=""){
			$.ajax({  
		            url:'${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-Validate.action',//先走校验的action   
		            //cache:false,        //拒绝缓存   
		            //async:false,        //异步提交   
		            type:"POST",          
		            data:"resId="+val,       
		            dataType:'text',  
		            success:function(obj){
		            	if(obj=="yes"){
		            		menuText.innerHTML = "该编号已被使用，请重新输入";
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
    <form id="addForm" name="addForm"  action="${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-add.action" method="post" > 
        <table class="add-info-table">
        	<tbody>
        		<tr align="center">
        			<th colspan="2">新增参数代码</th>
        		</tr>
        		
        		<tr>
        			<td class="word">代码标识</td>
        			<td ><input id="rowId" name="CommonCode!rowId" onblur="validate(this.value)" type="text" class="inputtext" /> <font id="txt" class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		<tr>
        			<td class="word">编号</td>
        			<td ><input id="codeNum" name="CommonCode!codeNum" type="text" class="inputtext" /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		
        		  <tr>
        			<td class="word">类别编号</td>
        			<td >
        				<input id="typeCode" name="CommonType!typeCode" readonly="readonly" value="<%=request.getAttribute("QT_typeCode") %>" onclick="javasrcipt:openwindow('${pageContext.request.contextPath}/view/paramCodeTreeListTemplate/Do-alertSelect.action','参数类别信息',1000,600)"  type="text" class="inputtext"   /> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>  
        		<tr>
        			<td class="word">名称</td>
        			<td ><input id="userShowName" name="CommonCode!userShowName" class="inputtext"  /> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		
        		<tr>
        			<td class="word">简称</td>
        			<td ><input  id="shortName" name="CommonCode!shortName" class="inputtext" /> <font class="fontredcolor">&nbsp;*</font> </td>
        		</tr> 
        		
        		<tr>
        			<td class="word">助记码</td>
        			<td ><input type="text" id="mnemonicCode" name="CommonCode!mnemonicCode" class="inputtext"/> <font class="fontredcolor">&nbsp;*</font></td>
        		</tr>
        		
        		<tr>
        			<td class="word">标准代码</td>    			
        				<td ><input type="text" id="standardCode" name="CommonCode!standardCode" class="inputtext"/></td>        			
        		</tr>
        		
        		<tr>
        			<td class="word">状态</td>
        				<td>
	        				<select id="status" name="CommonCode!status">
        					<option value="-1">--请选择--</option>
        					<option value="01" selected="selected">启用</option>
        					<option value="02">停用</option>
        				</select> <font class="fontredcolor">&nbsp;*</font> 
        				</td>       			
        		</tr>
        		
        		<tr>
        			<td class="word">上级代码编号</td>
        			<td >
	        			 <input type="text" id="parentCodeNum" name="CommonCode!parentCodeNum" class="inputtext" readonly="readonly" value="<%=request.getAttribute("nodePid") %>"/> <font class="fontredcolor">&nbsp;*</font>
        			</td>
        		</tr>
        		
        		<tr>
        			<td class="word">描述</td>
        			<td >
	        			 <textarea rows="3" cols="3" id="description" name="CommonCode!description" style="width:183px;height:100px;resize: none;"></textarea>
        			</td>
        		</tr>
        		
        	</tbody>
        </table>
          <div class="btnbox">
          <a class="confirmBtn" title="重 置" id="reset-btn" href="###" onclick="javascript:reset()">重&nbsp; 置</a>
          <a class="confirmBtn" title="保 存并新增"  id="save-btn" href="###" onclick="javascript:doSaveToAdd()">保存并新增</a>
          <a class="confirmBtn" title="保 存"  id="save-btn" href="###" onclick="javascript:doSave()">保 &nbsp;存</a>
          </div>   
      </form>
      
    </body>
</html>
