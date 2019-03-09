<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>选择数据</title>
 </head>
  <script type="text/javascript">
	//弹出窗口
	function pop(){
		//document.getElementById("mainDiv").style.display="block";
		
		openwindow('${pageContext.request.contextPath}/view/widget/alert-alertSelect.action','查询企业信息',1000,500); 
	}

	function openwindow(url,name,iWidth,iHeight)  
	{  
	    var url;                             //转向网页的地址;  
	    var name;                            //网页名称，可为空;  
	    var iWidth;                          //弹出窗口的宽度;  
	    var iHeight;                         //弹出窗口的高度;  
	    //获得窗口的垂直位置  
	    var iTop = (window.screen.availHeight-30-iHeight)/2;         
	    //获得窗口的水平位置  
	    var iLeft = (window.screen.availWidth-10-iWidth)/2;            
	    window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no');  
	} 
  </script>
 <body>
	<input type="text" id="openName" name="Org.Id" onclick="pop()" />
	<input type="hidden" id="openId" />

</body>
</html>
