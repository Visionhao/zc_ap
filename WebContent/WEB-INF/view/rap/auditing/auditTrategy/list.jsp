<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>审核策略配置</title>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<%@ include file="import.jsp"%>
<script type="text/javascript">
		var time= /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?$/;
		//判断初始化页面是否选中自定义按钮
		$(function(){
			if($("#warnTime3").attr("checked")=="checked"){
				$("#pre_Time").attr("readonly",false);
				$("#pre_Time").removeAttr("disabled");
			}
			if($("#lastAuditTime3").attr("checked")=="checked"){
				$("#latest_Time").attr("readonly",false);
				$("#latest_Time").removeAttr("disabled");
			}
		});

		//修改预警时间中自定义的方法
		$(function(){
			$("input:radio[id='warnTime3']").click(function(){
				$("#pre_Time").attr("readonly",false);
				$("#pre_Time").removeAttr("disabled");
				$("#pre_Time").focus();
				var params = $("#AuditTrategyForm").serialize();
				$.post("${pageContext.request.contextPath}/view/rap/auditing/auditTrategy/AuditTrategyAction-update.action",params,function(result){ });
			});
		});
		
		function changeTime1(){
			var id = $("#id1").val();
			var value = $("#pre_Time").val();
			if(value==""){
				mp_alter("提示","输入的预警时间不能为空！");
			    return;
			}else if(!time.test(value) || value.indexOf(".")!=-1){
				mp_alter("提示","输入的预警时间不是有效的整数!");
			    return;
			}else{
			 $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTrategy/AuditTrategyAction-updateAudit.action",{"id":id,"value":value},function(result){ });
			   	$("#setPrompt").show();
				$("#setPrompt").fadeOut(2000); 
			}
		}
		//修改最晚相应时间中的自定义的方法
		$(function(){
			$("input:radio[id='lastAuditTime3']").click(function(){
				$("#latest_Time").attr("readonly",false);
				$("#latest_Time").removeAttr("disabled");
				$("#latest_Time").focus();
				var params = $("#AuditTrategyForm").serialize();
				$.post("${pageContext.request.contextPath}/view/rap/auditing/auditTrategy/AuditTrategyAction-update.action",params,function(result){
				}); 
			});
		});
		
		function changeTime2(){
			var id = $("#id2").val();
			var value = $("#latest_Time").val();
			if(value==""){
				mp_alter("提示","输入的最晚响应时间不能为空！");
			    return;
			}else if(!time.test(value) || value.indexOf(".")!=-1){
				mp_alter("提示","输入的最晚响应时间不是有效的整数！");
			    return;
			}else{
			 $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTrategy/AuditTrategyAction-updateAudit.action",{"id":id,"value":value},function(result){ });
			   	$("#setPrompt").show();
				$("#setPrompt").fadeOut(2000); 
			}
		}
		
		$(function(){	
			$(".div_sty input[class=select]").click(function(){ 
				$("#pre_Time").attr("readonly",true);
				$("#pre_Time").attr("disabled",true);
				$("#latest_Time").attr("readonly",true);
				$("#latest_Time").attr("disabled",true);
				 var params = $("#AuditTrategyForm").serialize();
				 $.post("${pageContext.request.contextPath}/view/rap/auditing/auditTrategy/AuditTrategyAction-update.action",params,function(result){ });
				  	$("#setPrompt").show();
					$("#setPrompt").fadeOut(2000);
			}); 
		}); 
</script>
</head>
<body class="body">
   <form action="javascript:void(0)" id="AuditTrategyForm">
   		<input name="auditTrategy.auditTrategyId"  value="<c:out value="${AuditTrategy.auditTrategyId}"></c:out>" type="hidden"/>
   		<div id="setPrompt">设置成功</div> 
   		<div class="div_style1">
		    <div class="div_class">预警时间</div>
		   		<div class="div_sty">
		   			<table>
		   				<tr>
		   					<td class="lab_sty"><input class="select" id="warnTime1" type="radio" name="auditTrategy.warnTime" ${ AuditTrategy.warnTime=='1000'?'checked':''} value="1000"/><label for="warnTime1">5分钟</label></td>
		   					<td class="lab_sty"><input class="select" id="warnTime2" type="radio" name="auditTrategy.warnTime" ${ AuditTrategy.warnTime=='1001'?'checked':''} value="1001"/><label for="warnTime2">10分钟</label></td>
		   				</tr>
		   				<tr>
		   					<td class="lab_sty"><input id="warnTime3" type="radio" name="auditTrategy.warnTime" ${ AuditTrategy.warnTime=='1010'?'checked':''} value="1010"/><label for="warnTime3">自定义：预警时间<c:forEach items="${commonParam}" var="entry" varStatus="sta"><c:if test="${entry.paramId=='1010'}"><input id="id1" style="display: none;" type="text" value="${entry.paramId }"/><input type="text" id="pre_Time" name="commonParam!paramValue" style="width: 40px;" value="${entry.paramValue}" onblur="changeTime1()" readonly="readonly" disabled="disabled"/></c:if></c:forEach>分钟</label></td>
		   					<td class="lab_sty"><input class="select" id="warnTime4" type="radio" name="auditTrategy.warnTime" ${ AuditTrategy.warnTime=='1002'?'checked':''} value="1002"/><label for="warnTime4">不设置</label></td>
		   				</tr>
		   			</table>
		   		</div>
		</div> 
		<div class="div_style">
			 <div class="div_class">预警后优先审核</div>
		   		<div class="div_sty">
		   			<table>
		   				<tr>
		   					<td class="lab_sty"><input class="select" id="havePriority1" type="radio" name="auditTrategy.havePriority" ${ AuditTrategy.havePriority=='1003'?'checked':''} value="1003"/><label for="havePriority1">是</label></td>
		   					<td class="lab_sty"><input class="select" id="havePriority2" type="radio" name="auditTrategy.havePriority" ${ AuditTrategy.havePriority=='1004'?'checked':''} value="1004"/><label for="havePriority2">否</label></td>
		   				</tr>
		   			</table>
		   		</div>
		</div>
		
		<div class="div_style1">
			 <div class="div_class">最晚响应时间</div>
		   		<div class="div_sty">
		   			<table>
		   				<tr>
		   					<td class="lab_sty"><input class="select" id="lastAuditTime1" type="radio" name="auditTrategy.lastAuditTime" ${ AuditTrategy.lastAuditTime=='1005'?'checked':''} value="1005"/><label for="lastAuditTime1">10分钟</label></td>
		   					<td class="lab_sty"><input class="select" id="lastAuditTime2" type="radio" name="auditTrategy.lastAuditTime" ${ AuditTrategy.lastAuditTime=='1006'?'checked':''} value="1006"/><label for="lastAuditTime2">20分钟</label></td>
		   				</tr>
		   				<tr>
		   					<td class="lab_sty"><input id="lastAuditTime3" type="radio" name="auditTrategy.lastAuditTime" ${ AuditTrategy.lastAuditTime=='1011'?'checked':''} value="1011"/><label for="lastAuditTime3">自定义：最晚<c:forEach items="${commonParam}" var="entrys" varStatus="var"><c:if test="${entrys.paramId=='1011'}"><input id="id2" type="text" style="display: none;" value="${entrys.paramId }"/><input type="text" id="latest_Time" style="width: 40px;" onblur="changeTime2()" name="commonParam!paramValue" value="${entrys.paramValue}" readonly="readonly" disabled="disabled"/></c:if></c:forEach>分钟响应</label></td>
		   					<td class="lab_sty"><input class="select" id="lastAuditTime4" type="radio" name="auditTrategy.lastAuditTime" ${ AuditTrategy.lastAuditTime=='1007'?'checked':''} value="1007"/><label for="lastAuditTime4">不设置</label></td>
		   				</tr>
		   			</table>
		   		</div>
		</div>
		<div class="div_style">
			 <div class="div_class">自动审核</div>
		   		<div class="div_sty">
		   			<table>
		   				<tr>
		   					<td class="lab_sty"><input class="select" id="overtimeWay1" type="radio" name="auditTrategy.overtimeWay" ${ AuditTrategy.overtimeWay=='1008'?'checked':''} value="1008"/><label for="overtimeWay1">是(超过最晚相应时间自动审核)</label></td>
		   					<td class="lab_sty"><input class="select" id="overtimeWay2" type="radio" name="auditTrategy.overtimeWay" ${ AuditTrategy.overtimeWay=='1009'?'checked':''} value="1009"/><label for="overtimeWay2">否(超过最晚相应时间不自动审核)</label></td>
		   				</tr>
		   			</table>
		   		</div>
		</div>
   </form>
</body>
</html>
