<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>菜单</title>
<script src="${pageContext.request.contextPath}/resource/tools/jquery/jquery-1.8.0.min.js"></script>


<style type="text/css">

*{margin:0;padding:0;}
body {
padding-left:8px;
 font-family:  宋体;
 font-size:12px;
}
#da{
border:2px solid #89b5e9;
 width:180px;
height: 580px;
border-right: 5px solid #89b5e9;
}


#menu{
padding-left:20px;
 width:160px;
background:#d0dce9;
height: 30px;
}

#menu li{
list-style-type: none;
}





 a {
 width: 160px; 
 display: block;
padding-top:10px;
}
li {
 float:left;
}
a:link  {
 text-decoration:none;
}
ul {
 list-style:none;
 text-align:left;
}
ul a{
         padding-left:20px;
         width:160px;
}
/*下面是二级目录的链接样式*/
ul a:link  {
 text-decoration:none;
}
ul a:visited  {
text-decoration:none;
}
ul a:hover {
 text-decoration:none;
}



ul.collapsed {
 display: none;
}

.img{
border:none;
width: 6px;
height: 6px;
}
.img_zhan{
border:none;
width: 8px;
height: 5px;
float: right;
margin-right: 18px;
}
</style>
</head>
<body>
    <div id="da" >
        <div id="menu"><ul><li style="float: left;padding-top: 8px;">我的菜单</li><li style="float: right;padding-top: 8px;padding-right: 4px;"><img src="${pageContext.request.contextPath}/view/admin/images/index/setting.png" style="border: none;"></li></ul></div>
		<ul id="nav">
					<c:forEach  items="${menus2}" var="menu"
						varStatus="vs"> 
						<li><a href="#Menu=ChildMenu${vs.count }"  onclick="DoMenu('ChildMenu${vs.count}','ChildImg${vs.count}')"><span style="width:150px;"><font color="#000000;">${menu.name }</font></span><img src="${pageContext.request.contextPath}/view/admin/images/index/show.png" class="img_zhan" id="ChildImg${vs.count}" /></a>
						<ul id="ChildMenu${vs.count }" class="collapsed">
							<c:forEach  items="${menu.subMenus }" var="sub"> 
								<li class="li_2" ><a href="${pageContext.request.contextPath}${sub.url }" target="main">&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/view/admin/images/index/greypoint.png" class="img" style=""/>&nbsp;&nbsp;&nbsp;<font color="#000000;">${sub.name }</font></a></li>
							</c:forEach>
						 </ul>
						</li>						
    				</c:forEach>
				
	
				
		</ul>
        <div style="width: 6px;height: 120px;position: absolute;margin-left: 179px;margin-top: 240px;" onclick="changDiv(1)" id="fudong" ><img src="${pageContext.request.contextPath}/view/admin/images/index/pon.png" style="width: 7px;height: 120px;"/></div>
    </div>
     <div style="border-left:5px solid #89b5e9;height: 580px;display: none" id="fudong2">
        <div style="width: 6px;height: 120px;position: absolute;margin-top: 240px;margin-left: -6px;" onclick="changDiv(2)" ><img src="${pageContext.request.contextPath}/view/admin/images/index/pon_open.png" style="width: 7px;height: 120px;"/></div>
    </div>
</body>
<script type="text/javascript">
 var count=0;
DoMenu("ChildMenu1","ChildImg1");
function DoMenu (ChildMenu,ChildImg){
	$(".collapsed").hide();
	$("#"+ChildMenu).show();
	
	$(".img_zhan").attr("src","${pageContext.request.contextPath}/view/admin/images/index/show.png");
	$("#"+ChildImg).attr("src","${pageContext.request.contextPath}/view/admin/images/index/handup.png");
}

$(".li_2").click(function(){
	//全部变成灰色
	$(".img").attr("src","${pageContext.request.contextPath}/view/admin/images/index/greypoint.png");
	
	//改变当前对象下面的子节点下面子节点的src
	$(this).children().children().attr("src","${pageContext.request.contextPath}/view/admin/images/index/bluepoint.png");
});

function changDiv(scount){

	if(scount==1){
		
		$("#da").hide();
		$("#fudong2").show();
		parent.frame.cols="15,*";
	}else{
		$("#da").show();
		$("#fudong2").hide();
		parent.frame.cols="195,*";
	}
}
</script>
</html>