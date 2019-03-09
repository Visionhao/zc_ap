package com.mp100.risk.ap.seats.service.impl;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import com.mp100.risk.ap.seats.cache.MembersDataCache;
import com.mp100.risk.ap.seats.domain.hibernate.hbm.TaskDivide;
import com.mp100.risk.ap.seats.service.ITaskDivideService;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.service.IDaoService;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	分配任务-分配任务业务实现
 * @version 1.0
 * @since: 	2015-04-23
 * @author 	梁家豪
 * @serial:	2015-04-23
 */
public class TaskDivideServiceImpl implements ITaskDivideService{
	
  /***修改任务参数*/
   public void setTask(){
	   List<TaskDivide> taskDivideList=new ArrayList<TaskDivide>();
	   IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
	   taskDivideList = (List<TaskDivide>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.seats.domain.hibernate.hbm.queryOnTaskListDV", new HashMap());
		if(taskDivideList.size() > 0){
			//在线人数
			int count=taskDivideList.size();
			//平均数占比
			int pagNum=100/count;
			//剩余占比
			int yu=100-pagNum*count;
			for (int i = 0; i < taskDivideList.size(); i++) {
				//刚好平均没余数
				if(yu==0){
					taskDivideList.get(i).setWorkLoad(pagNum);
				}else{
					//默认把剩余的一个一个分给最新上班的人直到没有为止
					if(yu!=0){
						taskDivideList.get(i).setWorkLoad(pagNum+1);
						yu--;
					}else{
						taskDivideList.get(i).setWorkLoad(pagNum);
					}
				}
			}
			//重新修改
			daoService.updateEntity(taskDivideList);
		    //往成员缓存数据添加分配的任务
			setMembers(taskDivideList);
		}
   }
   
   /***往成员缓存数据添加分配的任务  */
   public void  setMembers(List<TaskDivide> list){
	   MembersDataCache.clearMembersList();
	   MembersDataCache.clearWordLoadList();
	   if(ObjectUtils.isNotNull(list)){
		   for (int i = 0; i < list.size(); i++) {
			   MembersDataCache.putWorkLoad(i, list.get(i).getWorkLoad());
			   MembersDataCache.putMembers(list.get(i));
		   }
	   }
   }
  
}
