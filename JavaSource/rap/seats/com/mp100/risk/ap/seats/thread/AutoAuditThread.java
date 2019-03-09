package com.mp100.risk.ap.seats.thread;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;
import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTrategyView;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditTaskPool;
import com.mp100.risk.ap.auditing.service.impl.AuditingServiceImpl;
import com.mp100.risk.ap.seats.util.RapParameter;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.LogUtils;
import com.uap.core.service.IDaoService;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	审核工作台--自动审核处理线程
 * @version 1.0
 * @since: 	2015-06-12
 * @author 	吴文浩
 * @serial:	2015-06-12
 */
public class AutoAuditThread extends Thread{
	
	 private final static ReentrantReadWriteLock readWriterLock = new ReentrantReadWriteLock() ;
	 private final static Lock writeLock = readWriterLock.writeLock();
	 
	 public void run(){
		 while(true){
			 try {
		    	  writeLock.lock();
		    	  IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		  		  //查询最晚响应时间
		      	  List<AuditTrategyView> lastTimeView = (List<AuditTrategyView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryTrategyLastTimeDV", new HashMap());
		      	  //查询是否自动审核
		      	  List<AuditTrategyView> autoAuditView = (List<AuditTrategyView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryTrategyAutoauditDV", new HashMap());
		      	  //查询超过最晚相应时间的list
		      	  List<AuditTaskView> auditTaskList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryTotalAuditTaskDV", new HashMap());
		      	  //查询审核任务池中的分配到的审核成员的任务id
		      	  List<AuditTaskPool> taskPoolList = (List<AuditTaskPool>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.hbm.queryMembersTotalTaskDV", new HashMap());
		      	  
		      	  
		      	  String lastTime = lastTimeView.get(0).getOvertimeWay();
		      	  String autoAudit = autoAuditView.get(0).getAuditTrategyId();
		  		  if(lastTime.indexOf("分钟")>0 && lastTime.indexOf("不设置")<0 && autoAudit.equals("是") || lastTime.indexOf(String.valueOf("分钟")) == -1){
			  			//最晚响应时间
			  			int times = Integer.parseInt(lastTime.replaceAll("分钟", ""));
			  			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			  			//创建时间
			  			for (AuditTaskView auditTaskView : auditTaskList) {
			  				int date = Integer.parseInt(df.format(new Date()).substring(14,16)) - Integer.parseInt(df.format(auditTaskView.getCreateTime()).substring(14,16));
			  				AuditingServiceImpl auditingService = new AuditingServiceImpl();
			  				if(date > times){
			  					for (AuditTaskPool auditTaskPool : taskPoolList) {
			  						if(auditTaskView.getAuditTaskId().equals(auditTaskPool.getAuditTaskId()) && auditTaskView.getReason().equals("XF003501")){
			  							LogUtils.error("执行自动审核操作。。。。");
			  							auditingService.executeTask(auditTaskView.getAuditTaskId(),"","00",auditTaskPool.getMembersId());
			  						    auditingService.pushGateway(auditTaskView.getAuditTaskId(),"E1001");
			  						}
			  					}
			  				}
						}
		  		  }else{
		  			break ;
		  		}
		  		Thread.sleep(RapParameter.DICTIONARY_AUTOAUDOT_TIME);
			 }catch (InterruptedException e) {
					LogUtils.error("自动审核线程出错"+e);
			    }finally{
					writeLock.unlock() ;
				}
		 }
	 }

}
