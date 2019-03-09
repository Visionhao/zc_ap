<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@ include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改系统参数</title>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/widget/select/jQuery.FillOptions.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.core.js"></script>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/ui/jquery.ui.widget.js"></script>
<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePicker.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/My97DatePicker46/WdatePickerJavaAdaptor.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/tools/jquery/validator/formcheck.css" />
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery.formValidator.initConfig({
			formid : "editForm",
			submitonce : true,
			onerror : showCustomErrors,
			onsuccess : function() {
				validate = true;
				var options = {
					success : function(obj){
	 			    	 if(obj=="yes"){
	 			    		 alert("修改成功");
	 			    		 closeWin();
	 			    	 }else{
	 			    		 alert("修改失败");
	 			    		 reset();
	 			    	 }
	 			     },
					type : "post",
					resetForm : true
				};
				jQuery("#editForm").ajaxSubmit(options);
				return false;
			}
		});
		 //参数名称
		 jQuery("#paramName").formValidator().inputValidator({
			  min: 1,
             max:60,
             type:"size",
             onerror:"不能为空或长度不对,长度为1~60个字符"
	        });
		//参数值
		   jQuery("#paramValue").formValidator().inputValidator({
			   min: 1,
	           max:60,
	           type:"size",
	           onerror:"不能为空或长度不对,长度为1~60个字符"
	        });
		   //类别
		   jQuery("#paramType").formValidator().inputValidator({ 
			   min: 1,
	           onerror:"请选择类别"
			});

		 //应用系统
		     jQuery("#ofSys").formValidator().inputValidator({ 
		    	min: 1,
	            max:32,
	            type:"size",
	            onerror:"不能为空或长度不对,长度为1~32个字符"
				});
		     jQuery("#description").formValidator().inputValidator({
					max : 200,
					type : "size",
					onerror : "长度不对,请输入100个以内的字符"
				});
	});
	function doEdit() {
		jQuery("#editForm").submit();
	}
	function reset() {
		jQuery("#editForm")[0].reset();
	}
	function closeWin() {
		window.close();
		window.opener.location.reload();
	}
</script>
</head>
<body>
	<form id="editForm" name="editForm"
		action="${pageContext.request.contextPath}/view/admin/common/sysParam/Do-edit.action"
		method="post">
		<table class="add-info-table">
			<tbody>
				<tr align="center">
					<th colspan="2">修改系统参数</th>
				</tr>
				<tr>
					<td class="word">参数编号</td>
					<td>
						<input id="paramId" name="CommonParam!paramId" type="text" class="inputtext" style="background-color: #F5F5F5;"  readonly="readonly" value="<c:out value="${CommonParam.paramId }"></c:out>" /> 
					</td>
				</tr>
				<tr>
					<td class="word">参数名</td>
					<td><input id="paramName" name="CommonParam!paramName" type="text" class="inputtext" value="<c:out value="${CommonParam.paramName }"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
				<tr>
					<td class="word">参数值</td>
					<td><input id="paramValue" name="CommonParam!paramValue" class="inputtext" value="<c:out value="${CommonParam.paramValue }"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>				
				<tr>
        			<td class="word">类别</td>
        			<td >
        				<select id="paramType" name="CommonParam!paramType"  class="inputtext">
        				    <option value="-1">--请选择--</option>
        				    <c:if test="${CommonParam.paramType =='01'}"><option value="01" selected="selected">系统参数</option>
        					<option value="02">业务参数</option>
        					<option value="03">初始化参数</option>
        					</c:if>
        					<c:if test="${CommonParam.paramType =='02'}"><option value="02" selected="selected">业务参数</option>
        					<option value="01">系统参数</option>
        					<option value="03">初始化参数</option>
        					</c:if>
        					<c:if test="${CommonParam.paramType =='03'}"><option value="03" selected="selected">初始化参数</option>
        					<option value="01">系统参数</option>
        					<option value="02">业务参数</option>
        					</c:if>
        				</select> <font class="fontredcolor">&nbsp;*</font>
					</td>
        		</tr> 
				<tr>
					<td class="word">应用系统</td>
					<td><input type="text" id="ofSys" name="CommonParam!ofSys"
						class="inputtext" value="<c:out value="${CommonParam.ofSys}"></c:out>" /> <font
						class="fontredcolor">&nbsp;*</font>
					</td>
				</tr>
				<tr>
					<td class="word">应用模块</td>
					<td><input type="text" id="ofFuc" name="CommonParam!ofFuc"
						class="inputtext" value="<c:out value="${CommonParam.ofFuc}"></c:out>" />
					</td>
				</tr>
				<tr>
					<td class="word">描述</td>
					<td>
						 <textarea rows="3" cols="3" id="description" name="CommonParam!description" style="width:180px;height:150px;resize: none;"><c:out value="${CommonParam.description}"></c:out></textarea>						
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btnbox">
			<a class="confirmBtn" title="重 置" id="reset-btn" href="###"
				onclick="javascript:reset()">重&nbsp;置</a><a class="confirmBtn" title="保存"
				id="save-btn" href="###" onclick="javascript:doEdit();">保&nbsp;存</a>
		</div>
	</form>
</body>
</html>
