<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>投诉内容模式</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
<%@ include file="../import.jsp"%>
<script type="text/javascript">
$(function(){
	$("#memus li").click(function(){
		$("#memus li").css({"border-bottom":"1px solid white","background-color":"white"});
		$("#memus li span").css({"color":"gray","font-weight":"bold"});
		$(this).css({"border-bottom":"1px solid white","background-color":"#f1f1f1"});
		$(this).children().css("color","#61B1FC");
	});
});
function auditMain(){
	var url = "${pageContext.request.contextPath}/view/rap/team/Complaintsback/ComplaintsBackAction-main.action";	
    location.href = url;	
}
function contentMain(){
	var url = "${pageContext.request.contextPath}/view/rap/team/Complaintsback/ComplaintsBackAction-contentMain.action";	
    location.href = url;	
}
function reset(){
	$("#QD_month").val('');
	var e=document.getElementsByTagName("input");
    for(var   i=0;i <e.length;i++){
        if(e[i].type== "text"){ 
            e[i].value = '';
        } 
    } 
}
function checkTheForm(){
	document.ComplaintsForm.submit();
}

function uploadFile(){
	 $("#file").click();
}

function upload(){
	if(document.getElementById("file").value!=""){
	 	if($("#file").val().indexOf('.xls')==-1){
	 		alert("文件格式不正确，请选择正确的Excel文件(后缀名.xls)!");
	 		return;
 		}
		document.uploadForm.submit();
	}
}
$(function(){
	if($("#str").val() !=""){
		mp_alter3("提示",$("#str").val(),contentMain);
	}
});
</script>
</head>
<body>
<div class="content_total">
		<div class="head" align="center"><div style="padding-top: 10px;">投诉回溯<span style="float: right;text-align: center;font-size: 12px;margin-top:10px;margin-right:10px;font-family: fantasy;">欢迎您&nbsp;&nbsp;${memberName}</span></div></div>
		
		<div style="padding-left: 0px;margin-top: 0px;padding-top: 0px;margin-left: 0px;">
	        <ul id="memus">
		        <li style="background-color:#f1f1f1;cursor:pointer;"><span style="color:#727272;font-weight:bold;"  class="hidefocus"  hidefocus  onclick="javascript:auditMain()">审核人模式</span></li>
		        <li style="border-bottom:1px solid white;background-color:white;cursor:pointer;" ><span style="color:#61B1FC;font-weight:bold;" class="hidefocus"  hidefocus onclick="javascript:contentMain()">投诉内容模式</span></li>
	        </ul>
		</div>
		<br>
		<input id="str" value="${str}" style="display: none;"/>
		<form style="display: none;" id="uploadForm" name="uploadForm" enctype="multipart/form-data" action="<%=request.getContextPath()%>/view/rap/team/Complaintsback/ComplaintsBackAction-upload.action" method="post">
			<div>
				<input type="file" id="file"  accept=".xls" name="file" onchange="javascript:upload()" />
				<input type="hidden" id="pathName" value="${path}"/>
			</div> 
		</form>
		
		<form name="ComplaintsForm" action="<%=request.getContextPath()%>/view/rap/team/Complaintsback/ComplaintsBackAction-contentList.action" method="post" target="contentFrame">	
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
						      			<c:forEach items="${months}" var="entry" varStatus="sta">
						      				<option value="${entry}">${entry}</option>
						      			</c:forEach>
				      				</select>
				      			</div>
					      	</div>
					     </div>
					     <div class="clear"></div>
						 <div class="search-tool">
		          			<span class="tool">
		          				<div style="float: left;"><a href="javascript:void(0)" onClick="uploadFile()" title="导入" class="icon-import"></a></div>
			          			<div style="float:left;margin-left:5px;"><a href="javascript:void(0)" onClick="javascript:toExportPage('contentFrame','投诉内容模式',document.forms[0].attributes['action'].value,'${pageContext.request.contextPath}')" title="导出" class="icon-export"></a></div>
			          	    </span>
		          			<span class="search-btn"><a href="javascript:checkTheForm()" title="查询" class="icon-search"></a></span>
		       			 </div>
					  </td>
					 </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top" style="overflow: hidden;"><iframe id="contentFrame" name="contentFrame" style="background-color: white;" 
					src="<%=request.getContextPath()%>/view/rap/team/Complaintsback/ComplaintsBackAction-contentList.action?QD_month=${QD_month}"
					width='100%' height='550' frameborder="0"></iframe></td>
			</tr>
		</table>
		</form>
</div>	
</body>
</html>
