
function toExportPage(iframeName,titleName,queryName,path){
	var con = new Array();
	var name = '';
	var value = '';
	var children = $("div.search-table").children();
	var inp = $("div.search-table").find("input[type=text]");
	var selects = $("div.search-table").find("select");
	var div = $("div.search-table").find("div.field");
	 var j = 0;
	for(var i = 0; i < (inp.length+selects.length); i++){
		if(children[i].style.display!="none"){
			if($(children[i]).find("input[type=text]").length >= 2 || $(children[i]).find("select").length >= 2 || ($(children[i]).find("input[type=text]").length + $(children[i]).find("select").length) >= 2){
				for(var n =0 ;n < $(children[i]).find("input[type=text]").length;n++){
					name = $(children[i]).find("input[type=text]")[n].getAttribute("name");
					value = $($(children[i]).find("input[type=text]")[n]).val();
					con[j] = (name+"="+value);
					j++;
				}
				
			}else{
				//name = div[i].nextSibling.getAttribute("name");
				name = $(inp[i]).attr("name");
				value = $(div[i].nextSibling).val();
				con[j] = (name+"="+value);
				j++;
			}
		};
	} 
 var QT_data = con.toString();     //当前页面查询条件
 var queryName;		 			//需要导出的对象PO
 var titleName;      			//需要导出的表名称名称;
 var iframeObject = window.frames[iframeName];
 var t = iframeObject.document.getElementById("tableId");
 var chnName ='';
	 var divObj = $(t).find("tr.header div");
	 for(var i = 0;i <divObj.length ;i++){
		 if($(divObj[i]).find("input").length!=0){
			continue;
		 }else{
 			 if(i==divObj.length-1){
 				chnName += divObj[i].innerHTML;
 			 }else{
 				chnName += divObj[i].innerHTML+",";
 			 }
		 }
	 }
var url = path+'/view/admin/component/report/controller/Do-exportPage.action?title='+titleName+'&chnName='+chnName+'&queryName='+queryName+'&QT_query='+QT_data;
url = encodeURI(url);
url = encodeURI(url);
openwindow(url,'',850,700);
}