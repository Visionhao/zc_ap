package com.mp100.risk.ap.auditing.domain.hibernate.hbm;

public class AuditTrategy implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	private String auditTrategyId;  //审核策略标识
	private	int warnTime;			//预警时间
	private	String havePriority; 	//预警后优先审核		
	private	int lastAuditTime;	    //最晚响应时间
	private	String overtimeWay;     //超过响应时间是否自动审核
	
	
	public AuditTrategy() {
		super();
	}

	

	public AuditTrategy(String auditTrategyId, int warnTime,
			String havePriority, int lastAuditTime, String overtimeWay) {
		super();
		this.auditTrategyId = auditTrategyId;
		this.warnTime = warnTime;
		this.havePriority = havePriority;
		this.lastAuditTime = lastAuditTime;
		this.overtimeWay = overtimeWay;
	}



	public String getAuditTrategyId() {
		return auditTrategyId;
	}


	public void setAuditTrategyId(String auditTrategyId) {
		this.auditTrategyId = auditTrategyId;
	}


	

	public int getWarnTime() {
		return warnTime;
	}



	public void setWarnTime(int warnTime) {
		this.warnTime = warnTime;
	}



	public String getHavePriority() {
		return havePriority;
	}


	public void setHavePriority(String havePriority) {
		this.havePriority = havePriority;
	}


	public int getLastAuditTime() {
		return lastAuditTime;
	}


	public void setLastAuditTime(int lastAuditTime) {
		this.lastAuditTime = lastAuditTime;
	}


	public String getOvertimeWay() {
		return overtimeWay;
	}


	public void setOvertimeWay(String overtimeWay) {
		this.overtimeWay = overtimeWay;
	}


}
