		var n = 0;
		var jsonArray = null;
		var json = null;
		var pass = 0,intercept = 0,correct=0,incorrect=0;
		
		//用来判断点击了开始测试之后,就不可以再加载相同的数据
		$(function(){
			$(".sta_h").click(function(){
			    $(this).removeAttr("onclick");
			});
		});
		
		//开始测试
		function start(){
		 	$.post("${pageContext.request.contextPath}/view/rap/team/evaluating/EvaluationSystemAction-passAuditTask.action",function(auditTaskList){
		 		//获取第一条数据
		 		jsonArray = auditTaskList;
		 		
	    		json = eval(auditTaskList[n].decideMap);
	    		 $(".append_div").append("<div  class='sms_div'>"+
			                     "<ul class='sms_ul'>"+
									  "<li>"+"<span style='float:left;margin-left:20px;'>"+auditTaskList[n].msg+"<span>"+"</li>"+
									  "<br><br>"+
								      "<li>"+
								      		"<label style='float:left;margin-left:20px;'>["+auditTaskList[n].custName+"："+auditTaskList[n].custGrade+"]</label>"+
								      		"<label style='float:left;margin-left:50px;'>["+json["XF003406"].reason+"]</label>"+
									  		"<label style='float:left;margin-left:150px;'>[投诉风险："+json["XF003401"].reason+"]</label>"+
									  		"<label id='checked' style='float:left;margin-left:150px;display:none;'>"+jsonArray[n].personDecide+"</label>"+
								      		"<label style='color: #3E93DA;float: right;margin-right: 100px;cursor:pointer;' onclick=\"showDetailList('"+auditTaskList[n].auditTaskId+"')\">详情</label>"+
								       "</li>"+ 
			                    "</ul></div> ");  
	    				 	
			});  
		}
		
		//点击详情方法
		 function showDetailList(id){
			 $.post("${pageContext.request.contextPath}/view/rap/team/evaluating/EvaluationSystemAction-showDetailList.action",{"auditTaskView.auditTaskId":id},function(bean){
				 var json = eval(bean.decideMap);
				 var html="";
					 html+="<div class='sms_Detail'>"+
			                     "<ul class='detail_ul'>"+
									  "<li>"+bean.msg+"</li>"+
									  "<br>"+
								      "<li style='margin-left: 0px;'>"+
								      		"<label style='float:left;margin-left:0px;'>["+bean.custName+"："+bean.custGrade+"]</label>"+
								      		"<label style='float:left;margin-left:50px;'>["+json["XF003406"].reason+"]</label>"+
								      		"<label style='float:left;margin-left:70px;'>[投诉风险："+json["XF003401"].reason+"]</label>"+
								       "</li>"+ 
			                    "</ul><br>" +
				                "<div  class='detailsDiv'><div id='laber1' ><b>端口风险相关信息</b><br></div><div id='laber2'><b>内容相关度信息<br></b></div>"+
			                   "<div id='laber3' ><b>号码相关度信息</b><br></div></div></div>";
				      showdialogComponent("详情",600,550,html);
				      $.each(bean.decideMap,function(index,value){
							 //端口标签
							 if(value.labelName=="XF003301"){
								 $("#laber1").append(""+getLaberName(value.labelId)+"："+value.reason+"<br>");
							 }else if(value.labelName=="XF003302" && value.labelId!="XF003408"){//内容标签
								$("#laber2").append(""+getLaberName(value.labelId)+"："+value.reason+"<br>");
							 }else if(value.labelName=="XF003303"){//行为标签
								$("#laber3").append(""+getLaberName(value.labelId)+"："+value.reason+"<br>");
							 }
						  });  
		  }); 
		} 
		//标签标识(01 端口投诉风险 02 端口近3个月投诉次数03号码池离散度04动机离散度    05受众数量  06动机分类 07敏感词  08内容相似标识  09投诉号码个数)type_code=XF0034
			function getLaberName(key){
				var laberName={"XF003401":"端口投诉风险","XF003402":"近3个月投诉次数","XF003403":"号码池离散度",
					"XF003404":"动机离散度","XF003405":"受众数量","XF003406":"动机分类","XF003407":"敏感词","XF003409":"投诉号码个数"};
				return laberName[key];
			}

		function onPs(){
			$(".sms_div").fadeToggle(1000,function(){
				onPass();
			});
		}
		//点击通过按钮执行
		function onPass(){
			pass ++ ;
			var value = $("#checked").text();
			
			if(value == '00') {
				correct++;
			}else{
				incorrect ++;
			};
			
			$(".sms_div").remove();
			n++;
			if(jsonArray != null && n == jsonArray.length){
				$(".s_text").css("display","none");
				$(".s_submit").css("display","block");
			}
			if(jsonArray!=null&& n < jsonArray.length){
				
				json = eval(jsonArray[n].decideMap);
				$(".append_div").append("<div  class='sms_div'>"+
	                    "<ul class='sms_ul'>"+
							  "<li>"+"<span style='float:left;margin-left:20px;'>"+jsonArray[n].msg+"<span><br><br>"+"</li>"+
							  "<br><br>"+
						      "<li>"+
						      		"<label style='float:left;margin-left:20px;'>["+jsonArray[n].custName+"："+jsonArray[n].custGrade+"]</label>"+
						      		"<label style='float:left;margin-left:50px;'>["+json["XF003406"].reason+"]</label>"+
							  		"<label style='float:left;margin-left:150px;'>[投诉风险："+json["XF003401"].reason+"]</label>"+
							  		"<label id='checked' style='float:left;margin-left:150px;display:none;'>"+jsonArray[n].personDecide+"</label>"+
						      		"<label style='color: #3E93DA;float: right;margin-right: 100px;cursor:pointer;' onclick=\"showDetailList('"+jsonArray[n].auditTaskId+"')\">详情</label>"+
						       "</li>"+ 
							 
	                   "</ul></div> ");
			}
		}
		
		function onIt(){
			$(".sms_div").fadeToggle(1000,function(){
				onIntercept();
			});
		}
		
		//点击拦截按钮执行
		function onIntercept(){
			$(".sms_div").fadeToggle("slow");
			intercept++;
			//获取隐藏的人工判定策略  00 放01 拦
			var value = $("#checked").text();
			
			if(value == '01') {
				correct ++;
			}else{
				incorrect ++ ;
			};
			
			$(".sms_div").remove();
			n++;
			if(jsonArray!=null&& n == jsonArray.length){
				$(".s_text").css("display","none");
				$(".s_submit").css("display","block");
			}
			if(jsonArray!=null&& n < jsonArray.length){
				
				json = eval(jsonArray[n].decideMap);
				$(".append_div").append("<div  class='sms_div'>"+
	                    "<ul class='sms_ul'>"+
							  "<li>"+"<span style='float:left;margin-left:20px;'>"+jsonArray[n].msg+"<span><br><br>"+"</li>"+
							  "<br><br>"+
						      "<li>"+
						      		"<label style='float:left;margin-left:20px;'>["+jsonArray[n].custName+"："+jsonArray[n].custGrade+"]</label>"+
						      		"<label style='float:left;margin-left:50px;'>["+json["XF003406"].reason+"]</label>"+
							  		"<label style='float:left;margin-left:150px;'>[投诉风险："+json["XF003401"].reason+"]</label>"+
							  		"<label id='checked' style='float:left;margin-left:150px;display:none;'>"+jsonArray[n].personDecide+"</label>"+
						      		"<label style='color: #3E93DA;float: right;margin-right: 100px;cursor:pointer;' onclick=\"showDetailList('"+jsonArray[n].auditTaskId+"')\">详情</label>"+
						       "</li>"+ 
							 
	                   "</ul></div> ");
			}
			
		} 

		//提交保存
		function save(){
			$("#interceptTotal").val(intercept);
			$("#passTotal").val(pass);
			$("#errorTotal").val(incorrect);
			$("#exactnessTotal").val(correct);
			
			var num = (correct/(correct+incorrect))*100;
			var rates = num.toFixed(2); 
			var param = $("#EvaluationForm").serialize();
			$.post("${pageContext.request.contextPath}/view/rap/team/evaluating/EvaluationSystemAction-save.action",param,function(obj){
				if(obj=="yes"){
					mp_alter3("提示","你本次的考试成绩为：正确的有"+correct+"条,错误的有"+incorrect+"条,准确率为："+rates+"%!",refresh);
					//alert("你本次的考试成绩为：正确的有"+correct+"条,错误的有"+incorrect+"条,准确率为："+rates+"%!");
					$(".s_text").css("display","block");
					$(".s_submit").css("display","none");
					
					//refresh();
				}else{
					alert("提交失败");
				}
			});
		}