package com.mp100.risk.ap.team.domain.hibernate.dv;

import java.util.Date;

public class EvaluationView implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private String evaluationId;      //评测标识
	private String membersId;         //成员标识   
	private int  interceptTotal;      //拦截数量
	private int  passTotal;           //放行数量
	private int  errorTotal;          //错误数量
	private int  exactnessTotal;      //正确数量
	private Date  createDate;         //创建日期
	public EvaluationView() {
		super();
	}
	public EvaluationView(String evaluationId, String membersId,
			int interceptTotal, int passTotal, int errorTotal,
			int exactnessTotal, Date createDate) {
		super();
		this.evaluationId = evaluationId;
		this.membersId = membersId;
		this.interceptTotal = interceptTotal;
		this.passTotal = passTotal;
		this.errorTotal = errorTotal;
		this.exactnessTotal = exactnessTotal;
		this.createDate = createDate;
	}
	public String getEvaluationId() {
		return evaluationId;
	}
	public void setEvaluationId(String evaluationId) {
		this.evaluationId = evaluationId;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}
	public int getInterceptTotal() {
		return interceptTotal;
	}
	public void setInterceptTotal(int interceptTotal) {
		this.interceptTotal = interceptTotal;
	}
	public int getPassTotal() {
		return passTotal;
	}
	public void setPassTotal(int passTotal) {
		this.passTotal = passTotal;
	}
	public int getErrorTotal() {
		return errorTotal;
	}
	public void setErrorTotal(int errorTotal) {
		this.errorTotal = errorTotal;
	}
	public int getExactnessTotal() {
		return exactnessTotal;
	}
	public void setExactnessTotal(int exactnessTotal) {
		this.exactnessTotal = exactnessTotal;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
}
