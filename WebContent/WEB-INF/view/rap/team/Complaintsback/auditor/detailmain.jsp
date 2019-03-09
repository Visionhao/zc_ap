<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>投诉人模式详细列表主页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<%@ include file="../import.jsp"%>
<script type="text/javascript">
//清空查询条件
function reset(){
	$("#QD_month").val('');
	var e=document.getElementsByTagName("input");
    for(var   i=0;i <e.length;i++){
        if(e[i].type== "text"){ 
            e[i].value = '';
        } 
    } 
}
//提交表单按照成员信息查询
function checkTheForm(){
	var Request = new Object();
	Request = GetRequest();
	var QT_membersId = Request['QT_membersId'];
	$("#QT_membersId").val(QT_membersId);
	document.ComplaintDetailForm.submit();
}

//获取父页面url传过来的参数
function GetRequest(){
	var url = location.search; //获取url中"?"符后的字串
	   var theRequest = new Object();
	   if (url.indexOf("?") != -1) {
	      var str = url.substr(1);
	      strs = str.split("&");
	      for(var i = 0; i < strs.length; i ++) {
	         theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
	      }
	   }
	   return theRequest;
}

//初始化页面传参
 $(function(){
	var Request = new Object();
	Request = GetRequest();
	var QT_membersId = Request['QT_membersId'];
	var QD_month = Request['QD_month'];

	var months = document.getElementById('QD_month');
	for(var i=0;i<months.options.length;i++){
		if(months.options[i].innerHTML == QD_month){
			months.options[i].selected = true;
			$("#QT_membersId").val(QT_membersId);
			break;
		}
	}

});   
</script>
</head>
<body>
<div class="content_total">
		<div class="head" align="center"><div style="padding-top: 10px;">投诉详情<span style="float: right;text-align: center;font-size: 12px;margin-top:10px;margin-right:10px;font-family: fantasy;">欢迎您&nbsp;&nbsp;${memberName}</span></div></div>
		<br>
		<div>
			<c:forEach items="${membersList}" var="entrys" varStatus="varStr">
				<c:if test="${entrys.membersId == QT_membersId}">
					<span style="margin-left: 20px;font-weight: bold;color: black;">${entrys.jobNumber }&nbsp;&nbsp;${entrys.chnName}</span>
					<span style="margin-left: 80px;"><fmt:formatDate value="${entrys.createDate }" pattern="yyyy年MM月dd日"  type="date"></fmt:formatDate>加入</span>
					<c:forEach items="${detailSum}" var="ent" varStatus="var1">
						<c:if test="${ent.membersId == entrys.membersId }">
							<span style="margin-left: 100px;"><span>审核量:</span><span>${ent.examineNum }</span></span>
							<span style="color: blue;margin-left: 10px;"><span>放行量：</span><span>${ent.passNum }</span></span>
							<span style="color:red;margin-left: 10px;"><span>拦截量：</span><span>${ent.interceptNum }</span>&nbsp;&nbsp;<span>总投诉量：</span><span>${ent.complaintNum }</span>&nbsp;&nbsp;<span>投诉率：</span><span>${ent.complaintRate }</span>%</span>
						</c:if>
					</c:forEach>	
				</c:if>	
			</c:forEach>	
		</div>	
		<br>
		<form id="ComplaintDetailForm" name="ComplaintDetailForm" action="<%=request.getContextPath()%>/view/rap/team/Complaintsback/ComplaintsBackAction-detailList.action" method="post" target="auditFrame">	
		<input type=hidden name="highLightRow" id="highLightRow" value="faBalance">
		<table class="main-table" width="100%" style="float: left;">
			<tr valign="top" >
				<td valign="top" >
				<table id="searchArea" width="100%" >
					<tr>
						<td valign="top">
						<div class="search-condition clearfix">
					      	<div class="search-table">
						      	<div id="con1"><div class="field">投诉号码</div><input name="QT_mobile" class="txt-input" type="text" id="QT_mobile" style="width:180px"/></div>
						      	<div id="con2"><div class="field">投诉端口</div><input name="QT_port" class="txt-input" type="text" id="QT_port" style="width:180px"/></div>
						      	<div id="con3"><div class="field">投诉内容</div><input name="QT_content" class="txt-input" type="text" id="QT_content" style="width:180px"/></div>
							    <div class="btn-s">
							       	<a href="javascript:void(0)" title="清空" class="clear-icon" onClick="javascript:reset()">&nbsp;</a>
							    </div>
							   
					      		<div id="con4"><div class="field">投诉月份</div>
				      				<select id="QD_month" name="QD_month">
						      			<c:forEach items="${QD_months}" var="entry" varStatus="sta">
						      				<option value="${entry}">${entry}</option>
						      			</c:forEach>
				      				</select>
				      			</div>
						      	<div id="con5" style="display: none;"><div class="field">成员标识</div><input name="QT_membersId" class="txt-input" type="hidden" id="QT_membersId"  style="width:180px"/></div>
					      	</div>
					     </div>
					     <div class="clear"></div>
						 <div class="search-tool">
		          			<span class="tool">
			          			<a href="javascript:void(0)" onClick="javascript:toExportPage('auditFrame','投诉人模式',document.forms[0].attributes['action'].value,'${pageContext.request.contextPath}')" title="导出" class="icon-export"></a>
			          	    </span>
		          			<span class="search-btn"><a href="javascript:checkTheForm()" title="查询" class="icon-search"></a></span>
		       			 </div>
					  </td>
					 </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top" style="overflow: hidden;"><iframe id="auditFrame" name="auditFrame" style="background-color: white;"
					src="<%=request.getContextPath()%>/view/rap/team/Complaintsback/ComplaintsBackAction-detailList.action?QD_month=${QD_month }&QT_membersId=${QT_membersId}";
					width='100%' height='550' frameborder="0"></iframe></td>
			</tr>
		</table>
		</form>
</div>	
</body>
</html>
