package com.mp100.risk.ap.auditing.domain.hibernate.hbm;

import java.io.Serializable;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审核任务与短信关联实体
 * @version 1.0
 * @since: 	2015-05-08
 * @author 	梁家豪
 * @serial:	2015-05-08
 */
public class AuditTaskSms implements Serializable{
	private static final long serialVersionUID = -6176514265124375507L;
    private String auditTaskSmsId     ;//审核短信标识  
	private String auditTaskId        ;//审核任务标识
	private String smsBatchCode       ;//短信发送批次号
	
	public String getAuditTaskSmsId() {
		return auditTaskSmsId;
	}
	public void setAuditTaskSmsId(String auditTaskSmsId) {
		this.auditTaskSmsId = auditTaskSmsId;
	}
	public String getAuditTaskId() {
		return auditTaskId;
	}
	public void setAuditTaskId(String auditTaskId) {
		this.auditTaskId = auditTaskId;
	}
	public String getSmsBatchCode() {
		return smsBatchCode;
	}
	public void setSmsBatchCode(String smsBatchCode) {
		this.smsBatchCode = smsBatchCode;
	}
	
	
}
