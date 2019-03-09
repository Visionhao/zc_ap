package com.mp100.risk.ap.auditing.service;
import java.util.List;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditTask;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.SmsSendBatchCurrent;
import com.mp100.risk.ap.seats.domain.hibernate.client.AuditDataParameter;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审批数据保存中心接口
 * @version 1.0
 * @since: 	2015-05-23
 * @author 	梁家豪
 * @serial:	2015-05-23
 */
public interface IAuditDataSaveCenterService {
	
	//审核任务保存中心
	public void save(AuditDataParameter auditDataParameter,List<SmsSendBatchCurrent> batchList);
	
   //处理和保存审核任务
   public AuditTask saveAuditTask(AuditDataParameter auditDataParameter);	
   
   //处理和保存任务辅助信息
   public void saveTaskDecide(AuditDataParameter auditDataParameter,AuditTask auditTask);
   
   //保存短信发送批次流水信息
   public void saveSmsSendBatch(List<SmsSendBatchCurrent> batchList,AuditTask auditTask);
   
   
}
