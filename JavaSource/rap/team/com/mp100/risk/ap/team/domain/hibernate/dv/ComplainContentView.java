package com.mp100.risk.ap.team.domain.hibernate.dv;

import java.util.Date;

public class ComplainContentView implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private String id;
	private String complainId;
	private String complainPhone;
	private String complainPort;
	private String complainContent;
	private String complainDate;
	private Date auditDate;
	private String  membersId;
	private String  state;
	private String  backTrace;
	public ComplainContentView() {
		super();
	}
	
	public String getId() {
		return complainId;
	}

	
	public ComplainContentView(String id, String complainId,
			String complainPhone, String complainPort, String complainContent,
			String complainDate, Date auditDate, String membersId,
			String state, String backTrace) {
		super();
		this.id = id;
		this.complainId = complainId;
		this.complainPhone = complainPhone;
		this.complainPort = complainPort;
		this.complainContent = complainContent;
		this.complainDate = complainDate;
		this.auditDate = auditDate;
		this.membersId = membersId;
		this.state = state;
		this.backTrace = backTrace;
	}

	public void setId(String id) {
		this.complainId = complainId;
	}

	public String getComplainId() {
		return complainId;
	}
	public void setComplainId(String complainId) {
		this.complainId = complainId;
	}
	public String getComplainPhone() {
		return complainPhone;
	}
	public void setComplainPhone(String complainPhone) {
		this.complainPhone = complainPhone;
	}
	public String getComplainPort() {
		return complainPort;
	}
	public void setComplainPort(String complainPort) {
		this.complainPort = complainPort;
	}
	public String getComplainContent() {
		return complainContent;
	}
	public void setComplainContent(String complainContent) {
		this.complainContent = complainContent;
	}
	
	public String getComplainDate() {
		return complainDate;
	}

	public void setComplainDate(String complainDate) {
		this.complainDate = complainDate;
	}

	public Date getAuditDate() {
		return auditDate;
	}
	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

	public String getBackTrace() {
		return backTrace;
	}

	public void setBackTrace(String backTrace) {
		this.backTrace = backTrace;
	}
	
}
