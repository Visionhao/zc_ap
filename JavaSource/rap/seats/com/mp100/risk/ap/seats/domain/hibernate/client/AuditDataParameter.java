package com.mp100.risk.ap.seats.domain.hibernate.client;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审批数据参数类
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public class AuditDataParameter implements Serializable{
    
	private static final long serialVersionUID = -7241012535837911420L;
	private String custId;              //客户标识(ec标识)
	private String port  ;              //端口号    
	private String content;             //短信内容
	private String filterContent;       //过滤后内容（去掉一些词）
	private Date submitTime;          //提交时间  
	private String membersId;//临时成员编号
	private String smsId    ; //网关短信标识
	private List<AudienceDataParameter> audienceList = new ArrayList<AudienceDataParameter>();//受众信息
	private Map<String,MachineDecide>  decideMap = new HashMap<String,MachineDecide>();//机器辅助信息（特征）
	private Map<Object,Object> attrMap=new HashMap<Object, Object>(); //扩展属性map
	
	
	public Map<Object, Object> getAttrMap() {
		return attrMap;
	}
	public void setAttrMap(Map<Object, Object> attrMap) {
		this.attrMap = attrMap;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFilterContent() {
		return filterContent;
	}
	public void setFilterContent(String filterContent) {
		this.filterContent = filterContent;
	}
	public Date getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(Date submitTime) {
		this.submitTime = submitTime;
	}
	public List<AudienceDataParameter> getAudienceList() {
		return audienceList;
	}
	public void setAudienceList(List<AudienceDataParameter> audienceList) {
		this.audienceList = audienceList;
	}
	
	public Map<String, MachineDecide> getDecideMap() {
		return decideMap;
	}
	public void setDecideMap(Map<String, MachineDecide> decideMap) {
		this.decideMap = decideMap;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getSmsId() {
		return smsId;
	}
	public void setSmsId(String smsId) {
		this.smsId = smsId;
	}
	
	
}
