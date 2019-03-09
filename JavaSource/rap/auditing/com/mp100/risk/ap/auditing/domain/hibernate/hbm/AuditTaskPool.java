package com.mp100.risk.ap.auditing.domain.hibernate.hbm;
import java.io.Serializable;
import java.util.Date;

/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	审批任务池
 * @version 1.0
 * @since: 	2015-04-27
 * @author 	梁家豪
 * @serial:	2015-04-27
 */
public class AuditTaskPool  implements Serializable{

	private static final long serialVersionUID = 8988140993728725419L;
	private String auditTaskId;   // 任务标识
	private Date   createTime ;   //创建时间
	private String membersId  ;   //分配成员标识
	private String isLock     ;   //0  未锁定  1  锁定;
	private Date  lockTime    ;   //锁定时间
	
	
	
	public String getAuditTaskId() {
		return auditTaskId;
	}
	public void setAuditTaskId(String auditTaskId) {
		this.auditTaskId = auditTaskId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}
	public String getIsLock() {
		return isLock;
	}
	public void setIsLock(String isLock) {
		this.isLock = isLock;
	}
	public Date getLockTime() {
		return lockTime;
	}
	public void setLockTime(Date lockTime) {
		this.lockTime = lockTime;
	}
	
	
	

}
