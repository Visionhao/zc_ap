<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>正在为您导出-->${title }</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/view/report/css/this.css">
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.3.js"></script>
		<script src="${pageContext.request.contextPath}/resource/jquerymsgbox/js/jquery-ui.js"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidator.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/formValidatorRegex.js" type="text/javascript"></script>
 	 	<script src="${pageContext.request.contextPath}/resource/tools/jquery/validator/showErrors.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery.form.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/tools/jquery/validator/formcheck.css">
		<script src="${pageContext.request.contextPath}/view/report/this.js"></script>
</head>
<body>
	<div id="prog" class="prog">
		<div class="prog_st"><b id="prog_title"></b>
			<a href="#" onclick="javascrtip:closeWin()"><span id="span2" style="background-color:#02a4e8; cursor: pointer"><img src="${pageContext.request.contextPath}/resource/images/standard/cancel.png" style="float: right;"></span></a>
			<div class="file_exp">
				<span><b id="counts"></b></span><br/>
				<textarea id="text" style="width: 250px;resize: none;height: 65px;border:none;;font-size: 12px;"></textarea>
			</div>
			<div id="take" class="take"><div id="countImg" class="countImg"><img src='${pageContext.request.contextPath}/view/report/images/loading.gif'/></div> <b id="count"></b></div>
			<div id="progressbar">
				<div class="progress-label"></div>
			</div>
			<div id="op" class="op">
				<a href="#" onclick="javascript:closeWin()">我知道了</a>
				<a style="width: 50px;" href="#" onclick="javascript:openFile()">打 开</a>
			</div>
			<div id="op1" class="op1">
				<a href="#" onclick="javascript:closeWin()">我知道了</a>
				<a style="width: 50px;" href="#" onclick="javascript:closeTips()">重新导出</a>
			</div>
		</div>
	</div>
	<form name="exportForm" id="exportForm" action="<%=request.getContextPath()%>/view/admin/component/report/controller/Do-export.action">
	<div class="main">
		<div class="prompt" >正在为您导出-->${title }</div>
		<div class="content">
			<div class="content_elect">
				<div class="term">
					<div class="scope">当前选择的是<span id="scop" class="ty">&nbsp;页面&nbsp;</span>数据范围</div>
					<div class="hid">
							<input type="radio" id="part" name="QT_query" checked="checked" value="${url }"/><label>页面数据</label>
							<input type="radio" id="all" name="QT_query" value="${queryName }"/><label>全部数据</label></div>
					<div class="Type">
						<div id="dat" class="dat">
						</div>
						<div class="dat_bot">
							<a id="a2" onclick="animate()" href="#" class="animate_2"></a>
							<a id="a1" class="animate_1"></a>
							<a id="a3" onclick="animate1()" href="#" class="animate_3"></a>
						</div>
					</div>
				</div>
				<div class="data_con">
					<div class="scope">当前选择的是<span id="ty" class="ty">&nbsp;xls&nbsp;</span>格式</div>
					<div class="Type">
						<div class="icon">
							<div class="type_style" style="margin-left: 15px;">
								<a title="excel" id="xls" href="#" onclick="checkedType('xls')" class="icon-xls"></a>
							</div>
							<div class="type_style">
								<a title="pdf" id="pdf" href="#" onclick="checkedType('pdf')" class="icon-pdf"></a>
							</div>
							<div class="type_style">
								<a title="txt" id="txt" href="#" onclick="checkedType('txt')" class="icon-txt"></a>
							</div>
						</div>
						<div class="hid">
							<input type="radio" id="excel" name="expType" checked="checked" value="xls"/><label>XLS</label>
							<input type="radio" id="PDF" name="expType" value="pdf"/><label>PDF</label>
							<input type="radio" id="TXT" name="expType" value="txt"/><label>TXT</label>
						</div>
					</div>
				</div>
			</div>
			<div class="address">
				<div class="file_addr">
					<span>导出文件路径:
						<input type="text" id="filePath" readonly name="filePath" value="C:\"/>
					</span>
				</div>
				<div class="addr_edit"><a class="addr_editBot"  onclick="javascript:doEditPath('${pageContext.request.contextPath}');" title="选择" href="#">...</a></div>
				<div class="fileName"><span class="file_til">文件名:<input type="hidden" id="tableName" name="tableName" value="${fileName }"/></span><span  class="file_name">${fileName }.</span><span id="typ" class="file_name">xls</span></div>
			</div>
			<div class="data">
				<div class="left">
					<div class="num"><span>&nbsp;&nbsp;共 <b>${num }</b> 列</span></div>
					<div class="files_title"><div class="index">序号</div><div class="th">字段名</div></div>
					<div class="data_table" id="data_table">
						<c:forEach items="${items }" var="entry" varStatus="sta">
							<c:set var="index" value="${sta.index+1}" />  
				              <c:choose>  
				                   <c:when test="${(index%2)==0}">  
				                      <div class="row_data2" onclick="javascript:check(this,${index})">
										<div class="index_">${index}</div>
										<div class="th_">${entry.key }<span class="hid"><input type="checkbox" name="${entry.value }" value="${entry.key }"/></span></div>
									  </div>
				                   </c:when>  
				                   <c:otherwise>  
				                      <div class="row_data" onclick="javascript:check(this,${index})">
										<div class="index_">${index}</div>
										<div class="th_">${entry.key }<span class="hid"><input type="checkbox" name="${entry.value }" value="${entry.key }"/></span></div>
									  </div> 
				                   </c:otherwise>  
				              </c:choose> 
						</c:forEach>
					</div>
				</div>
				<div class="shift">
					<div class="shift_">
						<a class="allBot" onclick="javascript:allToRight()" title="全部" href="#"></a>
						<br/><br/><br/>
						<a class="shifBot" onclick="javascript:ToRight()" title="移动" href="#"></a>
					</div>
				</div>
				<div class="right" id="right">
					<div class="num">
						<span>&nbsp;&nbsp;已选 <b id="num">${length }</b> 列</span>
						<div class="oper">
							<a class="icon-up" onclick="javascript:upShitf()" title="上移" href="#">
							</a>&nbsp;<a class="icon-down" onclick="javascript:downShitf()" title="下移" href="#">
							</a>&nbsp;<a class="icon-del" onclick="javascript:del()" title="移除" href="#"></a>
						</div>
					</div>
					<div class="files_title"><div class="index">序号</div><div class="th">字段名</div></div>
					<input type="hidden" id="chnName" name="chnName" value="" />
					<input type="hidden" id="engName" name="engName" value="" />
					<div class="data_table" id="data_table2">
						<c:forEach items="${nameList }" var="entry" varStatus="sta">
							<c:set var="index" value="${sta.index+1}" />  
				              <c:choose>  
				                   <c:when test="${(index%2)==0}">  
				                      <div class="row_data2" onclick="javascript:check2(this,${index})">
										<div class="index_">${index}</div>
										<div class="th_">${entry }<span class="hid"><input type="checkbox" checked value="${entry }"/></span></div>
									  </div>
				                   </c:when>  
				                   <c:otherwise>  
				                      <div class="row_data" onclick="javascript:check2(this,${index})">
										<div class="index_">${index}</div>
										<div class="th_">${entry }<span class="hid"><input type="checkbox" checked value="${entry }"/></span></div>
									  </div> 
				                   </c:otherwise>  
				              </c:choose> 
						</c:forEach>
						<div class="hid"></div>
					</div>
				</div>
			</div>
		</div>
		<div id="bottom" class="bottom">
				<p class="line">
				<div class="a_bott_div">
					<a class="icon-preview" onclick="javascript:doPreview()" title="预览" href="#"></a><a class="icon-regain" onclick="javascript:doRegain()" title="恢复" href="#"></a><a class="icon-export" onclick="javascript:doExport()" title="导出" href="#"></a>
				</div>
				<p class="line">
		</div>
	</div>
</form>
</body>
</html>