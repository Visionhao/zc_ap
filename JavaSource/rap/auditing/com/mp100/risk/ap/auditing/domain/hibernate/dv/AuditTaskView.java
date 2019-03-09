package com.mp100.risk.ap.auditing.domain.hibernate.dv;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.MachineDecide;

/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	审批任务视图
 * @version 1.0
 * @since: 	2015-05-11
 * @author 	梁家豪
 * @serial:	2015-05-11
 */
public class AuditTaskView implements java.io.Serializable{
	private static final long serialVersionUID = -3508295839304300819L;
	private String auditTaskId    ;  //审核任务标识
	private String msg            ;  //短信内容
	private String custName       ;  //客户名称
	private String custGrade      ;  //客户等级
	private Date   createTime     ;  //创建时间
	private String personDecide   ;  //人工判定策略  00 放01 拦
	private String decideType     ;  //任务类型    1预警任务 2 正常任务  3我投票 4我求帮助  5别人投票给我的任务  6.别人求我帮助的任务
	private String decideResult   ;  //团队判定结果 00 放01 拦
	private String reason         ;  //相似度标识
	
	//机器协助信息和统计信息
	private Map<String,MachineDecide>  decideMap=new HashMap<String,MachineDecide>();
	
	public Map<String, MachineDecide> getDecideMap() {
		return decideMap;
	}
	public void setDecideMap(Map<String, MachineDecide> decideMap) {
		this.decideMap = decideMap;
	}
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
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getCustGrade() {
		return custGrade;
	}
	public void setCustGrade(String custGrade) {
		this.custGrade = custGrade;
	}

	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getPersonDecide() {
		return personDecide;
	}
	public void setPersonDecide(String personDecide) {
		this.personDecide = personDecide;
	}
	public String getDecideType() {
		return decideType;
	}
	public void setDecideType(String decideType) {
		this.decideType = decideType;
	}
	public String getDecideResult() {
		return decideResult;
	}
	public void setDecideResult(String decideResult) {
		this.decideResult = decideResult;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
	
	
	
}
