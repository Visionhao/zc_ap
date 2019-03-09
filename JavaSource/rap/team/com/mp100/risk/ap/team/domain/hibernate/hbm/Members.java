package com.mp100.risk.ap.team.domain.hibernate.hbm;

import java.util.Date;

public class Members implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	private String  membersId;           
	private String  jobNumber;          
	private String  chnName;          
	private String   mobilePhone;                
	private String  state; 
	private Date   stateTime;
	private Date   createDate;
	private String remark;  
	private String orgId;
	private String passWord;
	private MembersGroup group;
	public Members() {
		super();
	}
	
	
	public Members(String membersId, String jobNumber, String chnName,
			String mobilePhone, String state, Date stateTime, Date createDate,
			String remark, String orgId, String passWord, MembersGroup group) {
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
		this.passWord = passWord;
		this.group = group;
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


	public String getOrgId() {
		return orgId;
	}


	public void setOrgId(String orgId) {
		this.orgId = orgId;
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
	public MembersGroup getGroup() {
		return group;
	}
	public void setGroup(MembersGroup group) {
		this.group = group;
	}


	public String getPassWord() {
		return passWord;
	}


	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	

}
