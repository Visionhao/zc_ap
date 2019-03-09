package com.mp100.risk.ap.team.domain.hibernate.hbm;


public class Complainant implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	private String  complaintId;
	private String  membersId;
	private String  month;
	private int  examineNum;//审评量
	private int  complaintNum;//投诉量
	private double  complaintRate;//投诉率
	private int interceptNum;//拦截量
	private int passNum;//放行量
	
	public Complainant(String complaintId, String membersId, String month,
			int examineNum, int complaintNum, double complaintRate,
			int interceptNum, int passNum) {
		super();
		this.complaintId = complaintId;
		this.membersId = membersId;
		this.month = month;
		this.examineNum = examineNum;
		this.complaintNum = complaintNum;
		this.complaintRate = complaintRate;
		this.interceptNum = interceptNum;
		this.passNum = passNum;
	}
	public Complainant() {
		super();
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
