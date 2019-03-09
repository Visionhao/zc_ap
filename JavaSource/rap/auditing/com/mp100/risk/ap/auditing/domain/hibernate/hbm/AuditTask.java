package com.mp100.risk.ap.auditing.domain.hibernate.hbm;
import java.io.Serializable;
import java.util.Date;

/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	审批任务实体
 * @version 1.0
 * @since: 	2015-04-27
 * @author 	梁家豪
 * @serial:	2015-04-27
 */
public class AuditTask implements Serializable{
	private static final long serialVersionUID = -4513903213373065443L;
	
	private String auditTaskId    ;  //审核任务标识
	private String msg            ;  //短信内容
	private String custId         ;  //客户标识
	private String textcate_id    ;  //机器分类
	private String smartDecide    ;  //机器判定策略  00 放01 拦
	private String smartSummary   ;  //机器决策摘要  
    private String state          ;  //状态 01 待审批 02 已审批type_code=XF0035
    private Date   stateTime      ;  //状态时间
    private String membersId      ;  //成员标识
    private String personDecide   ;  //人工判定策略  00 放01 拦
    private Date   createTime     ;  //创建时间
    
	public String getAuditTaskId() {
		return auditTaskId;
	}
	public void setAuditTaskId(String auditTaskId) {
		this.auditTaskId = auditTaskId;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getTextcate_id() {
		return textcate_id;
	}
	public void setTextcate_id(String textcate_id) {
		this.textcate_id = textcate_id;
	}
	public String getSmartDecide() {
		return smartDecide;
	}
	public void setSmartDecide(String smartDecide) {
		this.smartDecide = smartDecide;
	}
	public String getSmartSummary() {
		return smartSummary;
	}
	public void setSmartSummary(String smartSummary) {
		this.smartSummary = smartSummary;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Date getStateTime() {
		return stateTime;
	}
	public void setStateTime(Date stateTime) {
		this.stateTime = stateTime;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}
	public String getPersonDecide() {
		return personDecide;
	}
	public void setPersonDecide(String personDecide) {
		this.personDecide = personDecide;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	


	
    
}
