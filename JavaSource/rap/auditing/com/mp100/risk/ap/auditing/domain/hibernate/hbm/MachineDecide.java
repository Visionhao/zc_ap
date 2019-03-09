package com.mp100.risk.ap.auditing.domain.hibernate.hbm;
import java.io.Serializable;
/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	机器协助决策信息实体
 * @version 1.0
 * @since: 	2015-04-27
 * @author 	梁家豪
 * @serial:	2015-04-27
 */
public class MachineDecide implements Serializable{
   
	private static final long serialVersionUID = -3776829232367286647L;
	private String     machineDecideId;       //机器辅助标识
	private String     auditTaskId;           //审核任务标识
	private String     labelName;             //标签名称(01 端口标签,02内容标签,03行为标签)type_code=XF0033
	private String     labelId  ;             //标签标识(01 端口投诉风险 02 端口近3个月投诉次数03号码池离散度04动机离 散度    05受众数量  06动机分类 07敏感词  08内容相似标识  09投诉号码个数)type_code=XF0034
	private String     reason  ;              //结论依据
	
	public String getMachineDecideId() {
		return machineDecideId;
	}
	public void setMachineDecideId(String machineDecideId) {
		this.machineDecideId = machineDecideId;
	}
	public String getAuditTaskId() {
		return auditTaskId;
	}
	public void setAuditTaskId(String auditTaskId) {
		this.auditTaskId = auditTaskId;
	}
	public String getLabelName() {
		return labelName;
	}
	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}
	public String getLabelId() {
		return labelId;
	}
	public void setLabelId(String labelId) {
		this.labelId = labelId;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
	
	

	  
}
