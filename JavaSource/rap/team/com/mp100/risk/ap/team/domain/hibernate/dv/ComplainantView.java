package com.mp100.risk.ap.team.domain.hibernate.dv;

import java.util.Date;

public class ComplainantView implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private String id;
	private String  complaintId;
	private String  membersId;
	private String  jobNumber;          
	private String  chnName; 
	private Date    createDate;
	private String  month;
	private int  examineNum;
	private int  complaintNum;
	private double  complaintRate;
	private int interceptNum;//拦截量
	private int passNum;//放行量
	private String  dates;
	
	public ComplainantView() {
		super();
	}
	
	public ComplainantView(String id, String complaintId, String membersId,
			String jobNumber, String chnName, Date createDate, String month,
			int examineNum, int complaintNum, double complaintRate,
			int interceptNum, int passNum, String dates) {
		super();
		this.id = id;
		this.complaintId = complaintId;
		this.membersId = membersId;
		this.jobNumber = jobNumber;
		this.chnName = chnName;
		this.createDate = createDate;
		this.month = month;
		this.examineNum = examineNum;
		this.complaintNum = complaintNum;
		this.complaintRate = complaintRate;
		this.interceptNum = interceptNum;
		this.passNum = passNum;
		this.dates = dates;
	}

	public String getId() {
		return complaintId;
	}

	public void setId(String id) {
		this.complaintId = complaintId;
	}

	public String getComplaintId() {
		return complaintId;
	}
	public void setComplaintId(String complaintId) {
		this.complaintId = complaintId;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}
	
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getExamineNum() {
		return examineNum;
	}
	public void setExamineNum(int examineNum) {
		this.examineNum = examineNum;
	}
	public int getComplaintNum() {
		return complaintNum;
	}
	public void setComplaintNum(int complaintNum) {
		this.complaintNum = complaintNum;
	}
	public double getComplaintRate() {
		return complaintRate;
	}
	public void setComplaintRate(double complaintRate) {
		this.complaintRate = complaintRate;
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


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getDates() {
		return dates;
	}

	public void setDates(String dates) {
		this.dates = dates;
	}

	public int getInterceptNum() {
		return interceptNum;
	}

	public void setInterceptNum(int interceptNum) {
		this.interceptNum = interceptNum;
	}

	public int getPassNum() {
		return passNum;
	}

	public void setPassNum(int passNum) {
		this.passNum = passNum;
	}
	
}
