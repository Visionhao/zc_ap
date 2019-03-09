package com.mp100.risk.ap.auditing.service.impl;
import java.util.List;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditTask;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditTaskPool;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.MobileSendCurrent;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.SmsSendBatchCurrent;
import com.mp100.risk.ap.auditing.service.IAuditDataSaveCenterService;
import com.mp100.risk.ap.seats.domain.hibernate.client.AuditDataParameter;
import com.mp100.risk.ap.seats.domain.hibernate.client.MachineDecide;
import com.mp100.risk.ap.seats.util.UuidUtils;
import com.mp100.risk.ap.util.RapParameter;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.LogUtils;
import com.uap.core.service.IDaoService;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审批数据保存中心实现
 * @version 1.0
 * @since: 	2015-05-23
 * @author 	梁家豪
 * @serial:	2015-05-23
 */
public class AuditDataSaveCenterServiceImpl implements IAuditDataSaveCenterService{
	
	    //审核任务保存中心
		public void save(AuditDataParameter auditDataParameter,List<SmsSendBatchCurrent> batchList){
			try{
				//处理和保存审核任务
				AuditTask auditTask=saveAuditTask(auditDataParameter);
				//处理和保存任务辅助信息
				saveTaskDecide(auditDataParameter,auditTask);
				//保存短信发送批次流水信息
				saveSmsSendBatch(batchList,auditTask);
		   } catch (Exception e) {
			 LogUtils.error("任务数据保存中心出错"+e);
	       }
		}
	
	
	   //处理和保存审核任务
	   public AuditTask saveAuditTask(AuditDataParameter auditDataParameter){
		   IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		   //封装任务对象
		   AuditTask audit=new AuditTask();
		   audit.setMsg(auditDataParameter.getContent());
		   audit.setCustId(auditDataParameter.getCustId());
		   audit.setState(RapParameter.DICTIONARY_TASK_STATE_DAI);
		   audit.setCreateTime(auditDataParameter.getSubmitTime());
		   daoService.saveEntity(audit);
		   //封装任务池对象
		   AuditTaskPool pool=new AuditTaskPool();
		   pool.setAuditTaskId(audit.getAuditTaskId());
		   pool.setMembersId(auditDataParameter.getMembersId());
		   pool.setCreateTime(auditDataParameter.getSubmitTime());
		   pool.setIsLock("0");
		   daoService.saveEntity(pool);
		   return audit;
	   }
	   
	   
	   //处理和保存任务辅助信息
	   public void saveTaskDecide(AuditDataParameter auditDataParameter,AuditTask auditTask){
		   IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		 //封装机器辅助对象
		   StringBuffer sb=new StringBuffer();
		   sb.append("insert into X_AP_MACHINE_DECIDE_INFO(MACHINE_DECIDE_ID,AUDIT_TASK_ID,LABEL_NAME,LABEL_ID,REASON) ");
		   for (MachineDecide bean : auditDataParameter.getDecideMap().values()) {
			  sb.append(" union all ");
			  sb.append("select '"+UuidUtils.getUuid()+"' , '"+auditTask.getAuditTaskId()+"' , '"+bean.getLabelName()+"' , '"+bean.getLabelId()+"' , '"+bean.getReason()+"' from dual  ");
		   }
		   //批量添加辅助信息
		    daoService.executeSaveSQL(sb.toString().replaceFirst(" union all ", ""));
		   //清空buff
		   sb.delete(0,sb.length()-1);
	   }
	   
	   //保存短信发送批次流水信息
	   public void saveSmsSendBatch(List<SmsSendBatchCurrent> batchList,AuditTask auditTask){
		   IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		   //短信发送批次
		   StringBuffer batchSb=new StringBuffer();
		   //正文
		   StringBuffer contentSb=new StringBuffer();
		   //号码
		   StringBuffer mobileSb=new StringBuffer();
		   
		   //批次与任务关联
		   StringBuffer taskBatchSb=new StringBuffer();
		   
		   String batchId = "";
		   String contentCode = "";
		   batchSb.append("insert into EP_SMS_SEND_BATCH_CURRENT(SMS_BATCH_CODE,CUSTOMER_ID,SUBMIT_TIME,BATCH_STATUS,DOWN_PORT,INTERFACE_ID) ");
		   contentSb.append("insert into EP_SMS_SEND_CONTENT_CURRENT(SMS_CONTENT_CODE,SMS_BATCH_CODE,SMS_CONTENT) ");
		   mobileSb.append("insert into EP_SMS_SEND_NUM_CURRENT(SEND_NUM_FLOW_CODE,SMS_BATCH_CODE,SMS_CONTENT_CODE,PHONE_NUM ) ");
		   taskBatchSb.append("insert into X_AP_AUDIT_TASK_SMS(AUDIT_TASK_SMS_ID,AUDIT_TASK_ID,SMS_BATCH_CODE) ");
		   for (SmsSendBatchCurrent batchBean : batchList) {
			   batchId = UuidUtils.getUuid();
			   contentCode = UuidUtils.getUuid();
			   //追加批次流水信息
			   batchSb.append(" union all ");
			   batchSb.append("select '"+batchId+"' , '"+batchBean.getCustomerId()+"' , Current_date, '"+batchBean.getBatchStatus()+"' , '"+batchBean.getDownPort()+"' , '"+batchBean.getInterFaceId()+"' from dual  ");
		       
			   //批次与任务关联信息
			   //追加批次流水信息
			   taskBatchSb.append(" union all ");
			   taskBatchSb.append("select '"+UuidUtils.getUuid()+"' , '"+auditTask.getAuditTaskId()+"' ,  '"+batchId+"' from dual  ");
			   
			   //追加内容正文信息
			   contentSb.append(" union all ");
			   contentSb.append("select '"+contentCode+"' , '"+batchId+"' ,  '"+batchBean.getContentBean().getSmsContent()+"'  from dual  ");
		      
			   for (MobileSendCurrent mobileBean : batchBean.getMobileList()) {
		    	   //追加内容正文信息
		    	   mobileSb.append(" union all ");
		    	   mobileSb.append("select '"+UuidUtils.getUuid()+"' , '"+batchId+"' ,  '"+contentCode+"' , '"+mobileBean.getPhoneNum()+"'  from dual  ");
			   }
		   }
		   //批量添加短信发送批次流水
		    daoService.executeSaveSQL(batchSb.toString().replaceFirst(" union all ", ""));
		    //清空buff
		    batchSb.delete(0,batchSb.length()-1);
		    
		   //批量添加短信正文信息
		    daoService.executeSaveSQL(contentSb.toString().replaceFirst(" union all ", ""));
		    //清空buff
		    contentSb.delete(0,contentSb.length()-1);
		    
		    //批量添加号码信息
		    daoService.executeSaveSQL(mobileSb.toString().replaceFirst(" union all ", ""));
		    //清空buff
		    mobileSb.delete(0,mobileSb.length()-1);
		    
		  //批次与任务关联信息
		    daoService.executeSaveSQL(taskBatchSb.toString().replaceFirst(" union all ", ""));
		    //清空buff
		    taskBatchSb.delete(0,taskBatchSb.length()-1);
		
	   }
	   
	   
	   
	   
}
