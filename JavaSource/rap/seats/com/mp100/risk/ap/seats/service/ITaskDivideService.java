package com.mp100.risk.ap.seats.service;

import java.util.List;

import com.mp100.risk.ap.seats.domain.hibernate.hbm.TaskDivide;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-分配任务业务接口
 * @version 1.0
 * @since: 	2015-04-23
 * @author 	梁家豪
 * @serial:	2015-04-23
 */
public interface ITaskDivideService {
	  /***修改任务参数*/
   public void setTask();
   /***往成员缓存数据添加分配的任务  */
   public void  setMembers(List<TaskDivide> list);
}
