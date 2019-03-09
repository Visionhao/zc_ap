package com.mp100.risk.ap.seats.thread;
import java.util.Set;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import com.mp100.risk.ap.auditing.service.IAuditDataSaveCenterService;
import com.mp100.risk.ap.seats.cache.MembersDataCache;
import com.mp100.risk.ap.seats.cache.TaskProcessCache;
import com.mp100.risk.ap.seats.service.ITaskDivideService;
import com.mp100.risk.ap.seats.util.RapParameter;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	任务分配-任务分配线程
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public class DivideTaskThread extends Thread{
    private final static ReentrantReadWriteLock readWriterLock = new ReentrantReadWriteLock() ;
    private final static Lock writeLock = readWriterLock.writeLock();
    private int index = 0;
    public void run(){
    	 //初始化分配任务参数
    	    initTask();
			while(true){
		       try {
		    	  writeLock.lock();
		    	  Set<String> sets=TaskProcessCache.batchKeys();
		    	  if(ObjectUtils.isNotNull(sets)){
			    	  for (String key : sets) {
			    		  //确保有至少有一个成员以上才可以分配任务
			    		 if(MembersDataCache.getMemberTotle() > 0 ){ 
			    			 //获取要分配的成员索引
				    		  index=MembersDataCache.getTaskIndex();
				    		  ////可能由于同步问题导致暂成员数量为0;
				    		  if(index == -1 || MembersDataCache.getMemberTotle() == 0){
				    			  break;
				    		  }
				    		  //给当前任务分配成员
			    			  TaskProcessCache.getAudit(key).setMembersId(MembersDataCache.getAlMemberl(index).getMembersId());
			    			  //减少当前成员当前这一轮已经分配的工作量
			    			  MembersDataCache.reduceWordLoad(index);
			    			  //进行保存已经分配的任务
			    			  IAuditDataSaveCenterService auditDataSaveCenterService = (IAuditDataSaveCenterService) AppContextUtils.getBean(IAuditDataSaveCenterService.class.getName());
			    			  auditDataSaveCenterService.save(TaskProcessCache.getAudit(key), TaskProcessCache.getBatchList(key)); 
			    			  LogUtils.info("当前任务一共保存批次："+TaskProcessCache.getBatchList(key).size()+"条"); 
			    			  //保存成功后删除对应的任务处理缓存数据
			    			  TaskProcessCache.removeAudit(key);
			    			  TaskProcessCache.removeBatch(key);
			    		 }else{
			    			 break;
			    		 }
					  }
		    	  }
				  Thread.sleep(RapParameter.DICTIONARY_TIME_TASK_DIVIDE);
				} catch (InterruptedException e) {
					LogUtils.error("任务分配线程出错"+e);
			    }finally{
					writeLock.unlock() ;
				}
		    	
			}
	}
   //初始化分配任务参数
	public void initTask(){
		ITaskDivideService taskDivideService = (ITaskDivideService) AppContextUtils.getBean(ITaskDivideService.class.getName());
		taskDivideService.setTask();
	}
}
