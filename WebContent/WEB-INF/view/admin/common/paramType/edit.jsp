<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="tag" uri="/uap-tags"%>
<%@ include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改参数类别</title>
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
		//类型
		   jQuery("#type").formValidator().inputValidator({
			   min: 1,
	           onerror:"请选择类型"
	        });
		   //显示名称
		   jQuery("#userShowName").formValidator().inputValidator({ 
			   min: 1,
	           max:50,
	           type:"size",
	           onerror:"不能为空或长度不对,长度为1~50个字符"
			});

		 //简称
		     jQuery("#shortName").formValidator().inputValidator({ 
		    	min: 1,
	            max:32,
	            type:"size",
	            onerror:"不能为空或长度不对,长度为1~32个字符"
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
		action="${pageContext.request.contextPath}/view/admin/common/paramType/Do-edit.action"
		method="post">
		<table class="add-info-table">
			<tbody>
				<tr align="center">
					<th colspan="2">修改参数类别</th>
				</tr>
				<tr>
					<td class="word">类别编号</td>
					<td><input id="typeCode" name="CommonType!typeCode" type="text" class="inputtext" readonly="readonly" style="background-color: #F5F5F5;" value="<c:out value="${CommonType.typeCode }"></c:out>" /></td>
				</tr>
				<tr>
					<td class="word">名称</td>
					<td><input id="userShowName" name="CommonType!userShowName" type="text" class="inputtext" value="<c:out value="${CommonType.userShowName }"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
				<tr>
					<td class="word">简称</td>
					<td><input id="shortName" name="CommonType!shortName" class="inputtext" value="<c:out value="${CommonType.shortName }"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
				<tr>
					<td class="word">助记码</td>
					<td><input id="mnemonicCode" name="CommonType!mnemonicCode" class="inputtext" value="<c:out value="${CommonType.mnemonicCode }"></c:out>" /> <font class="fontredcolor">&nbsp;*</font></td>
				</tr>
				<tr>
        			<td class="word">标准代码</td>
        			<td ><input id="standardCode" name="CommonType!standardCode" class="inputtext" value="<c:out value="${CommonType.standardCode }"></c:out>" /></td>
        		</tr>
				<tr>
					<td class="word">状态</td>
					<td>
						<select id="status" name="CommonType!status" class="inputtext">
							<option value="-1">--请选择--</option>
							<c:if test="${CommonType.status=='01'}"><option value="01" selected="selected">启用</option>
								<option value="02">停用</option>	
							</c:if>
							<c:if test="${CommonType.status=='02'}"><option value="02" selected="selected">停用</option>
								<option value="01">启用</option>	
							</c:if>
						</select> <font class="fontredcolor">&nbsp;*</font>
					</td>
				</tr>
				<tr>
					<td class="word">类型</td>
					<td>
						<select id="type" name="CommonType!type"  class="inputtext">
        				    <option value="-1">--请选择--</option>
        				    <c:if test="${CommonType.type =='01'}"><option value="01" selected="selected">系统参数</option>
        					<option value="02">业务参数</option>
        					<option value="03">初始化参数</option>
        					</c:if>
        					<c:if test="${CommonType.type =='02'}"><option value="02" selected="selected">业务参数</option>
        					<option value="01">系统参数</option>
        					<option value="03">初始化参数</option>
        					</c:if>
        					<c:if test="${CommonType.type =='03'}"><option value="03" selected="selected">初始化参数</option>
        					<option value="01">系统参数</option>
        					<option value="02">业务参数</option>
        					</c:if>
        				</select> <font class="fontredcolor">&nbsp;*</font>
					</td>
				</tr>
				<tr>
					<td class="word">描述</td>
					<td>
						 <textarea rows="3" cols="3" id="description" name="CommonType!description" style="width:180px;height:150px;resize: none;"><c:out value="${CommonType.description}"></c:out></textarea>			
					</td>
				</tr>

			</tbody>
		</table>
		<div class="btnbox">
			<a class="confirmBtn" title="重 置" id="reset-btn" href="###"
				onclick="javascript:reset()">重 &nbsp;置</a><a class="confirmBtn" title="保存"
				id="save-btn" href="###" onclick="javascript:doEdit();">保&nbsp;存</a>
		</div>
	</form>
</body>
</html>
