/**
 * Company:     北京众成联信信息技术有限公司
 * 工具描述 :      文件导出工具
 * @since:      2014-11-27
 * @author      侯烽泰
 * @serial:     2014-11-27 
 */





/**
 * 进行导出功能操作方法。
 * 
 **/
jQuery(document).ready(function(){
			document.getElementById("prog").style.height = document.body.offsetWidth +"px";
			 jQuery.formValidator.initConfig({
			        formid: "exportForm",
			        submitonce: true,
			        onerror: showCustomErrors,
			         onsuccess:function(){
			       	 validate=true;
				 			var options = {
				 					beforeSend: function() {
				 						$(".prog").show();
				 						document.getElementById("prog_title").innerHTML = "正准备导出数据";
				 			        },
				 			     success : function(data){
				 			    	
				 			    	document.getElementById("counts").innerHTML = data;
				 			    	document.getElementById("count").innerHTML = data;
				 			    	document.getElementById("countImg").style.display="none";
				 					if(data.indexOf("共导出")!= -1){	
				 						document.getElementById("prog_title").innerHTML = "导出操作完成";
				 						$("#op").show();
				 						$("#op1").hide();
				 					}else{
				 						document.getElementById("prog_title").innerHTML = "导出操作中止";
				 						$("#op1").show();
				 						document.getElementById("chnName").value="";
				 						document.getElementById("engName").value="";
				 						$("#op").hide();
				 					}
				 			     },
				 			     error:function(data){
				 			     document.getElementById("countImg").style.display="none";
				 			    	 alert(data);
				 			     },
				 			     type:"post",
				 			     dataType : "text",
				 			     resetForm : false
				 			};  
				 			jQuery("#exportForm").ajaxSubmit(options);
				 			return false;
			         }
			    });
		
				jQuery("#filePath").formValidator().inputValidator({
			           min: 1,
			           type:"size",
			           onerror:"请选择导出文件路径"
			        });    
  			});
			function doExport(){
				$("#data_table2 input[type=checkbox]").attr("checked",true);
				var inputs = $("#data_table2 input[type=checkbox]");
				var name = "";
				var chnName = document.getElementById("chnName");
				var engName = document.getElementById("engName");
				for(var i = 0;i < inputs.length; i++){
					if(i!=inputs.length-1){
						name += inputs[i].value+",";
						engName.value += inputs[i].name+",";
					}else{
						name += inputs[i].value;
						engName.value += inputs[i].name;
					}
				}
				chnName.value = name;
				document.getElementById("text").value = $("#filePath").val()+"\\"+$(".file_name").text();
				jQuery("#exportForm").submit();
			}
			function closeWin(){
				window.close();
			}
			function closeTips(){
				$(".prog").hide();
			}

/**
 * 进行导出文件路径选择方法。
 * 
 **/
function doEditPath(path){
		var filePath = document.getElementById("filePath").value;
		$.ajax({  
		    url:path+'/view/admin/component/report/controller/Do-showSaveFile.action',//先走校验的action   
		    //cache:false,        //拒绝缓存   
		    //async:false,        //异步提交   
		    type:"POST",          
		    data:"filePath="+filePath,       
		    dataType:'text',  
		    success:function(obj){
		    	document.getElementById("filePath").value = obj;
		    }
		}); 
	}

/**
 * 进行格式导出选择方法。
 * 
 **/
function checkedType(obj){
		$("#xls").removeClass("icon-xls");
		$("#xls").removeClass("iconxls");
		$("#pdf").removeClass("icon-pdf");
		$("#pdf").removeClass("iconpdf");
		$("#txt").removeClass("icon-txt");
		$("#txt").removeClass("icontxt");
		$("#xls").addClass("iconxls");
		$("#pdf").addClass("icon-pdf");
		$("#txt").addClass("icon-txt");
		var ty = document.getElementById("ty");
		var excel = document.getElementById("excel");
		var PDF = document.getElementById("PDF");
		var TXT = document.getElementById("TXT");
		var typ = document.getElementById("typ");
		
		if(obj=='xls'){
			excel.checked = "checked";
			$("#xls").removeClass("iconxls").addClass("icon-xls");
			typ.innerHTML = "xls";
			ty.innerHTML = "&nbsp;xls&nbsp;";
		}else if(obj=='pdf'){
			PDF.checked = "checked";
			$("#pdf").removeClass("icon-pdf").addClass("iconpdf");
			typ.innerHTML = "pdf";
			ty.innerHTML = "&nbsp;pdf&nbsp;";
		}else if(obj=='txt'){
			TXT.checked = "checked";
			$("#txt").removeClass("icon-txt").addClass("icontxt");
			typ.innerHTML = "txt";
			ty.innerHTML = "&nbsp;txt&nbsp;";
		}
	}

/**
 * 进行左边字段选择方法。
 * 
 **/
var flag = 0;
function check(obj,num){
	var div_1 = $("#data_table div.row_data");
	var div_2 = $("#data_table div.row_data2");
	
	for(var i = 0;i<div_1.length ;i++){
		div_1[i].style.backgroundColor="#ffffff";
	}
	for(var i = 0;i<div_2.length ;i++){
		div_2[i].style.backgroundColor="#f5f5f5";
	}
	$("#data_table input[type=checkbox]").attr("checked",false);
	
	var check = $(obj).find("input");
	if(flag==0){
		obj.style.backgroundColor="#80bdff";
		check[0].checked = "checked";
		flag = 1;
	}else{
		if((num%2)==0){
			obj.style.backgroundColor="#f5f5f5";
		}else{
			obj.style.backgroundColor="#ffffff";
		}
		check[0].checked = "";
		flag = 0;
	}
}

/**
 * 进行左边字段选择右移方法。
 * 
 **/
function ToRight(){    
	var arr = '';
	var name = '';
	var numb = document.getElementById("num");
	var inputs = $("#data_table input[type=checkbox]");
	
	for(var i = 0;i<inputs.length;i++){
		if(inputs[i].checked==true){
			arr = inputs[i].value;
			name = inputs[i].name;
		}
	}
	var str ='';
	var inputs2 = $("#data_table2 input[type=checkbox]");
	for(var i = 0; i <inputs2.length; i++){
		str += inputs2[i].value;
	}
	
	if(arr!='' && str.indexOf(arr)==-1){
		if((inputs2.length+1)%2==0){
			$("#data_table2 div.hid").before("<div class='row_data2' onclick='javascript:check2(this,"+(inputs2.length+1)+")'><div class='index_'>"+(inputs2.length+1)+"</div><div class='th_'>"+arr+"<span class='hid'><input type='checkbox' name='"+name+"' checked value='"+arr+"'/></span></div></div>");
		}else{
			$("#data_table2 div.hid").before("<div class='row_data' onclick='javascript:check2(this,"+(inputs2.length+1)+")'><div class='index_'>"+(inputs2.length+1)+"</div><div class='th_'>"+arr+"<span class='hid'><input type='checkbox' name='"+name+"' checked value='"+arr+"'/></span></div></div>");
		}
		numb.innerHTML = inputs2.length+1;
	}
		 
}

/**
 * 进行左边字段选择全部右移方法。
 * 
 **/
function allToRight(){
	var parentNode = document.getElementById("data_table2");
	var childs = parentNode.childNodes;
	var numb = document.getElementById("num");
	var inputs = $("#data_table input[type=checkbox]").attr("checked", true);
	var div_1 = $("#data_table div.row_data");
	var div_2 = $("#data_table div.row_data2");
	
	for(var i = 0;i<div_1.length ;i++){
		div_1[i].style.backgroundColor="#80bdff";
	}
	for(var i = 0;i<div_2.length ;i++){
		div_2[i].style.backgroundColor="#80bdff";
	}
	
	if(childs.length > 0){
		for(var i=childs.length-1;i>=0;i--){    
				parentNode.removeChild(childs.item(i));    
		}; 
	}
	$("#data_table2").append("<div class='hid'></div>");
	for(var i = 0;i < inputs.length;i++){
		if(((i+1)%2)==0){
			$("#data_table2 div.hid").before("<div class='row_data2' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+inputs[i].value+"<span class='hid'><input type='checkbox' name='"+inputs[i].name+"' checked value='"+inputs[i].value+"'/></span></div></div>");
		}else{
			$("#data_table2 div.hid").before("<div class='row_data' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+inputs[i].value+"<span class='hid'><input type='checkbox' name='"+inputs[i].name+"' checked value='"+inputs[i].value+"'/></span></div></div>");
		}
	}
	numb.innerHTML = inputs.length;
}

/**
 * 进行右边字段选择方法。
 * 
 **/
var n = 0;
function check2(obj,num){
	var div_1 = $("#data_table2 div.row_data");
	var div_2 = $("#data_table2 div.row_data2");
	
	for(var i = 0;i<div_1.length ;i++){
		div_1[i].style.backgroundColor="#ffffff";
	}
	for(var i = 0;i<div_2.length ;i++){
		div_2[i].style.backgroundColor="#f5f5f5";
	}
	$("#data_table2 input[type=checkbox]").attr("checked",true);
	
	var check = $(obj).find("input");
	if(n==0){
		obj.style.backgroundColor="#80bdff";
		check[0].checked = "";
		n = 1;
	}else{
		if((num%2)==0){
			obj.style.backgroundColor="#f5f5f5";
		}else{
			obj.style.backgroundColor="#ffffff";
		}
		check[0].checked = "checked";
		n = 0;
	}
}

/**
 * 进行右边字段选择移除方法。
 * 
 **/
function del(){
	var numb = document.getElementById("num");
	var inputs = $("#data_table2 input[type=checkbox]");
	for(var i = 0;i<inputs.length;i++){
		if(inputs[i].checked==false){
			inputs[i].parentNode.parentNode.parentNode.remove();
		}
	}
	
	var input = $("#data_table2 input[type=checkbox]");
	
	var parentNode = document.getElementById("data_table2");
	var childs = parentNode.childNodes;
	
	if(childs.length > 0){
		for(var i=childs.length-1;i>=0;i--){    
				parentNode.removeChild(childs.item(i));    
		}; 
	}
	$("#data_table2").append("<div class='hid'></div>");
	for(var i = 0;i<input.length;i++){
		if(((i+1)%2)==0){
			$("#data_table2 div.hid").before("<div class='row_data2' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' checked value='"+input[i].value+"'/></span></div></div>");
		 
		}else{
			$("#data_table2 div.hid").before("<div class='row_data' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' checked value='"+input[i].value+"'/></span></div></div>");
		}
	}
	numb.innerHTML = input.length;
}

/**
 * 进行右边字段选择向上移动方法。
 * 
 **/
function upShitf(){
	var inputs = $("#data_table2 input[type=checkbox]");
	var parNode = '';
	for(var i = 0;i<inputs.length;i++){
		if(inputs[i].checked==false){
			parNode = inputs[i].parentNode.parentNode.parentNode;
		}
	}
	if(parNode.previousSibling){
		$(parNode.previousSibling).before($(parNode).clone(true));
		parNode.remove();
	}
	var input = $("#data_table2 input[type=checkbox]");
	
	var pareNode = document.getElementById("data_table2");
	var childs = pareNode.childNodes;
	
	if(childs.length > 0){
		for(var i=childs.length-1;i>=0;i--){    
			pareNode.removeChild(childs.item(i));    
		}; 
	}
	$("#data_table2").append("<div class='hid'></div>");
	for(var i = 0;i<input.length;i++){
		if(input[i].checked==true){
			if(((i+1)%2)==0){
				$("#data_table2 div.hid").before("<div class='row_data2' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' checked value='"+input[i].value+"'/></span></div></div>");
				
			}else{
				$("#data_table2 div.hid").before("<div class='row_data' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' checked value='"+input[i].value+"'/></span></div></div>");
			}
		}else{
			if(((i+1)%2)==0){
			$("#data_table2 div.hid").before("<div class='row_data2' style='background-color:#80bdff' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' value='"+input[i].value+"'/></span></div></div>");
			}else{
			$("#data_table2 div.hid").before("<div class='row_data' style='background-color:#80bdff' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' value='"+input[i].value+"'/></span></div></div>");
			}
		}
	}
};

/**
 * 进行右边字段选择向下移动方法。
 * 
 **/
function downShitf(){
	var inputs = $("#data_table2 input[type=checkbox]");
	var parNode = '';
	for(var i = 0;i<inputs.length;i++){
		if(inputs[i].checked==false){
			parNode = inputs[i].parentNode.parentNode.parentNode;
		}
	}
	if(parNode.nextSibling){
		$(parNode.nextSibling).after($(parNode).clone(true));
		parNode.remove();
	}
	var input = $("#data_table2 input[type=checkbox]");
	
	var pareNode = document.getElementById("data_table2");
	var childs = pareNode.childNodes;
	
	if(childs.length > 0){
		for(var i=childs.length-1;i>=0;i--){    
			pareNode.removeChild(childs.item(i));    
		}; 
	}
	$("#data_table2").append("<div class='hid'></div>");
	for(var i = 0;i<input.length;i++){
		if(input[i].checked==true){
			if(((i+1)%2)==0){
				$("#data_table2 div.hid").before("<div class='row_data2' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' checked value='"+input[i].value+"'/></span></div></div>");
			}else{
				$("#data_table2 div.hid").before("<div class='row_data' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' checked value='"+input[i].value+"'/></span></div></div>");
			}
		}else{
			if(((i+1)%2)==0){
				$("#data_table2 div.hid").before("<div class='row_data2' style='background-color:#80bdff' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' value='"+input[i].value+"'/></span></div></div>");
			}else{
				$("#data_table2 div.hid").before("<div class='row_data' style='background-color:#80bdff' onclick='javascript:check2(this,"+(i+1)+")'><div class='index_'>"+(i+1)+"</div><div class='th_'>"+input[i].value+"<span class='hid'><input type='checkbox' name='"+input[i].name+"' value='"+input[i].value+"'/></span></div></div>");
			}
		}
	}
};

/**
 * 
 * 进行向左滑动动画方法。
 * 
 **/
function animate(){
	document.getElementById("part").checked = true;
	document.getElementById("all").checked = false;
	document.getElementById("a2").style.display = "none";
	document.getElementById("scop").innerHTML = "&nbsp;页面&nbsp;";
	$("#a1").animate({right:'94px'},1000);
	document.getElementById("a3").style.display = "block";
	$("#dat").removeClass("dat_h").addClass("dat");
	
}

/**
 * 
 * 进行向右滑动动画方法。
 * 
 **/
function animate1(){
	document.getElementById("part").checked = false;
	document.getElementById("all").checked = true;
	$("#dat").removeClass("dat").addClass("dat_h");
	document.getElementById("a3").style.display = "none";
	document.getElementById("scop").innerHTML = "&nbsp;全部&nbsp;";
	$("#a1").animate({left:'-1px'},1000);
	document.getElementById("a2").style.display = "block";
}

/**
 * 
 * 进行进度条加载动画方法。
 * 
 **/
function Progressbar(obj) {
	document.getElementById("prog").style.height = document.body.offsetWidth +"px";
	document.getElementById("count").innerHTML = obj;
	document.getElementById("counts").innerHTML = obj;
	//$(".prog").show();
	//$("#bottom").removeClass("bottom").addClass("bottom_prog");
	//var prog = $("#progressbar"), progressLabel = $(".progress-label");

//	prog.progressbar({
//		value : false,
//		change : function() {
//			progressLabel.text(prog.progressbar("value") + "%");
//		},
//		complete : function() {
//			progressLabel.text("导出完成..");
//			$('#progressbar').hide();
//			$("#take").hide();
//			$(".file_exp").show();
//			$("#op").show();
//		}
//	});
//
//	function progress() {
//		var val = prog.progressbar("value") || 0;
//		prog.progressbar("value", val + 1);
//		if (val < 99) {
//			setTimeout(progress, 10);
//		}
//	}
//	setTimeout(progress, 100);
}


/**
 * 进行导出文件后打开excel文件方法。
 * 
 **/
function openFile(){
	
	var path = $("#filePath").val()+"\\";
	var fileName = path+$(".file_name").text();
	$.ajax({  
	    url:'${pageContext.request.contextPath}/view/admin/component/report/controller/Do-openFile.action',//先走校验的action   
	    //cache:false,        //拒绝缓存   
	    //async:false,        //异步提交   
	    type:"POST",          
	    data:"fileName="+fileName,       
	    dataType:'text',  
	    success:function(obj){
	    	closeWin();
	    }
	}); 
}
$(function(){
	var inputs = $("#data_table input[type=checkbox]");
	var inputs2 = $("#data_table2 input[type=checkbox]");
	for(var i = 0;i < inputs2.length;i++){
		for(var j = 0;j < inputs.length;j++){
			if(inputs2[i].value==inputs[j].value){
				inputs2[i].name = inputs[j].name;
			}
		}
	}
});



