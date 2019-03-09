<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>投诉人模式列表页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<%@ include file="../import.jsp"%>
<script type="text/javascript">
var len = ${count};
var size = ${counts};
$(function(){
	$("#memus li").click(function(){
		$("#memus li").css({"border-bottom":"1px solid white","background-color":"white"});
		$("#memus li span").css({"color":"gray","font-weight":"bold"});
		$(this).css({"border-bottom":"1px solid white","background-color":"#f1f1f1"});
		$(this).children().css("color","#61B1FC");
	});
});

//打开投诉详情的页面
function openwin(QD_month,QT_membersId){
	for(var i = 0;i<len;i++){
		for(var j = 0; j<size;j++){
			var QT_membersId1 = $("#membersId_"+i).val();
			var QD_month1 = $("#month_"+i).val();
			if(QD_month == QD_month1 && QT_membersId == QT_membersId1){
				var url = "${pageContext.request.contextPath}/view/rap/team/Complaintsback/ComplaintsBackAction-detailMain.action?QD_month="+QD_month1+"&QT_membersId="+QT_membersId1;	
			    window.open(url, 'newwindow', '');
			}
		}
	}
}

$(function(){
	var count=$(".audit_etail").length;
	var audit_m = "";
	var list_total = "";
	if((count/3) > 3){
		audit_m=parseInt(count)*130+"px";
		list_total = parseInt(count)*120+"px";
		$(".audit_m").css({"height":audit_m});
		$(".list_total").css({"height":list_total});
		var height = $(document.body).outerHeight(true);
		var iframe = parent.document.getElementById("rightFrame");
		iframe.height = height + audit_m+100 +"px";
	}else{
		$(".audit_m").css("height","814px");
		$(".list_total").css("height","900px");
	}
});

</script>
</head>
<body>
<div class="list_total">
		
		<div class="audit_m">
			<c:forEach items="${membersViewList}" var="ent" varStatus="vars">
				<div class="audit_etail">
				   <table class="tab_1">
						<tr class="tab_1">
							<td><img alt="正在加载.." onerror="this.src='<%=request.getContextPath()%>/view/rap/images/member/headpic.gif'" src="<%=request.getContextPath() %>/view/rap/team/member/MemberAction-readPicture.action?id=${ent.membersId }" width="70px" height="70px" style="margin-top:-5px;margin-left:18px;vertical-align: middle;margin-right:10px;"/></td>
							<td>
								<div class="td_div"><span style="font-weight: bold;color: black;">${ent.jobNumber }&nbsp;&nbsp;${ent.chnName }</span></div>
								<div class="td_div"><span><fmt:formatDate value="${ent.createDate }" pattern="yyyy年MM月dd日"  type="date"></fmt:formatDate>加入</span></div>
								<c:forEach items="${complainantSum}" var="entry1" varStatus="varys">
									<c:if test="${entry1.membersId==ent.membersId}">
										<div class="td_div"><span>${entry1.examineNum }<span>/</span><span style="color: blue;">${entry1.passNum }</span>/<span style="color: red;">${entry1.interceptNum}</span>&nbsp;&nbsp;<span style="color: red;">${entry1.complaintNum }<span>/</span>${entry1.complaintRate }<span>%</span></span></span></div>
									</c:if>
								</c:forEach>
							</td>  
						</tr>
					</table>
					
					<table class="tab_2">
						<tr class="tr_2">	
							<td>时间</td>
							<td>审批量</td>
							<td>投诉量</td>
							<td>投诉率</td>
						</tr>
						<c:forEach items="${complainantList}" var="entry" varStatus="str">
							<c:if test="${entry.membersId==ent.membersId }">
								<tr class="tr_2">	
									<input style="display: none;" type="text" id="membersId_${str.index}" name="QT_membersId"  value="${entry.membersId }"/>
									<td><input style="display: none;" type="text" id="month_${str.index}" name="QD_month" value="${entry.month}"/>${entry.month }</td>
									<td>${entry.examineNum }</td>
									<td><span class="td_a" onclick="openwin('${entry.month}','${entry.membersId}')">${entry.complaintNum }</span></td>
									<td>${entry.complaintRate }<span>%</span></td>
								</tr>
							</c:if>	
						</c:forEach>	
					</table>
				</div> 
			</c:forEach> 
			
		</div>
	
</div>	
</body>
</html>
