package com.mp100.risk.ap.auditing.domain.hibernate.dv;
import java.io.Serializable;
import java.util.Date;

/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	团队决策实体
 * @version 1.0
 * @since: 	2015-04-27
 * @author 	梁家豪
 * @serial:	2015-04-27
 */
public class TeamDecisionsView implements Serializable{
	private static final long serialVersionUID = 8638146340042470517L;
	private String     teamDecieId     ;  //团队决策标识
	private String     auditTaskId     ;  //多对一审核任务表
	private String     decideResult    ;  //判定结果 00 放01 拦
	private String     decideBasis     ;  //判定理由
	private Date       dicideTime      ;  //判定时间
	private Date       submitTime      ;  //提交时间
	private String     decideType      ;  //决策类型  type_code=XF0032      01 投票   02 求帮助
	private String     membersId       ;  //审核员标识      
	private String     chnName         ;  //成员名称
	
	
	public String getTeamDecieId() {
		return teamDecieId;
	}
	public void setTeamDecieId(String teamDecieId) {
		this.teamDecieId = teamDecieId;
	}
	public String getAuditTaskId() {
		return auditTaskId;
	}
	public void setAuditTaskId(String auditTaskId) {
		this.auditTaskId = auditTaskId;
	}
	public String getDecideResult() {
		return decideResult;
	}
	public void setDecideResult(String decideResult) {
		this.decideResult = decideResult;
	}
	public String getDecideBasis() {
		return decideBasis;
	}
	public void setDecideBasis(String decideBasis) {
		this.decideBasis = decideBasis;
	}
	public Date getDicideTime() {
		return dicideTime;
	}
	public void setDicideTime(Date dicideTime) {
		this.dicideTime = dicideTime;
	}
	public Date getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(Date submitTime) {
		this.submitTime = submitTime;
	}
	public String getDecideType() {
		return decideType;
	}
	public void setDecideType(String decideType) {
		this.decideType = decideType;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}
	public String getChnName() {
		return chnName;
	}
	public void setChnName(String chnName) {
		this.chnName = chnName;
	}
	

}
