package com.mp100.risk.ap.team.domain.hibernate.dv;

import java.util.Date;

public class MembersView implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private String  membersId;           
	private String  jobNumber;          
	private String  chnName;          
	private String  mobilePhone;                
	private String  state; 
	private Date    stateTime;
	private Date    createDate;
	private String  remark;  
	private String  orgId;
	private String  groupId;
	private String  groupName;
	private String  dates;
	private String passWord;
	
	public MembersView() {
		super();
	}

	public MembersView(String membersId, String jobNumber, String chnName,
			String mobilePhone, String state, Date stateTime, Date createDate,
			String remark, String orgId, String groupId, String groupName,
			String dates, String passWord) {
		super();
		this.membersId = membersId;
		this.jobNumber = jobNumber;
		this.chnName = chnName;
		this.mobilePhone = mobilePhone;
		this.state = state;
		this.stateTime = stateTime;
		this.createDate = createDate;
		this.remark = remark;
		this.orgId = orgId;
		this.groupId = groupId;
		this.groupName = groupName;
		this.dates = dates;
		this.passWord = passWord;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getMembersId() {
		return membersId;
	}

	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}

	public String getJobNumber() {
		return jobNumber;
	}

	public void setJobNumber(String jobNumber) {
		this.jobNumber = jobNumber;
	}

	public String getChnName() {
		return chnName;
	}

	public void setChnName(String chnName) {
		this.chnName = chnName;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
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

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	
	public String getGroupId() {
		return groupId;
	}


	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}


	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getDates() {
		return dates;
	}

	public void setDates(String dates) {
		this.dates = dates;
	}

	
}
