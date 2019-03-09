package com.mp100.risk.ap.seats.web.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mp100.risk.ap.seats.domain.hibernate.dv.TaskDivideView;
import com.mp100.risk.ap.seats.domain.hibernate.hbm.TaskDivide;
import com.mp100.risk.ap.seats.service.ITaskDivideService;
import com.uap.common.utils.AppContextUtils;
import com.uap.core.service.IDaoService;
import com.uap.core.web.action.base.BaseAction;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-分配任务Action类
 * @version 1.0
 * @since: 	2015-04-14
 * @author 	梁家豪
 * @serial:	2015-04-14
 */
@SuppressWarnings("serial")
public class TaskDivideAction extends BaseAction{
	private List<TaskDivide> TaskDivideList=new ArrayList<TaskDivide>();
	private String result;
	/** 分配任务-成员任务列表*/
	public String taskList(){
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		List<TaskDivideView> taskDivideList = (List<TaskDivideView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.seats.domain.hibernate.dv.queryTaskListDV", new HashMap());
		getRequest().setAttribute("taskDivideList", taskDivideList);
		return "taskList";
	}
	
	
	
	/** 分配任务-修改任务*/
	
	public String updateTask(){
		try{
			if(TaskDivideList!=null){
				IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
				ITaskDivideService IdaoService = (ITaskDivideService)AppContextUtils.getBean(IDaoService.class.getName());
				daoService.updateEntity(TaskDivideList);
				/***往成员缓存数据添加分配的任务  */
				IdaoService.setMembers(TaskDivideList);
			}
			result="ok";
		}catch (Exception e) {
			result="no";
			e.printStackTrace();
		}
		return "updateTask";
	}

	public String getResult() {
		return result;
	}



	public void setResult(String result) {
		this.result = result;
	}


	public List<TaskDivide> getTaskDivideList() {
		return TaskDivideList;
	}

	public void setTaskDivideList(List<TaskDivide> taskDivideList) {
		TaskDivideList = taskDivideList;
	}
	
	
	
}
