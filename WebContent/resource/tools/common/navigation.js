function displaySubMenu(li) { 
var subMenu = li.getElementsByTagName("ul")[0]; 
subMenu.style.display = "block"; 
} 
function hideSubMenu(li) { 
var subMenu = li.getElementsByTagName("ul")[0]; 
subMenu.style.display = "none"; 
} 
/*
 示例：
  <ul id="navigation"> 
		<li onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)"> 
		<a href="#">栏目1</a> 
			<ul> 
				<li><a href="#">栏目1->菜单1</a></li> 
				<li><a href="#">栏目1->菜单2</a></li> 
				<li><a href="#">栏目1->菜单3</a></li> 
				<li><a href="#">栏目1->菜单4</a></li> 
			</ul> 
		</li> 
  </ul>
  
  
 */