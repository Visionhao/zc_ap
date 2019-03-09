package com.mp100.risk.ap.auditing.domain.hibernate.hbm;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-短信发送批次流水
 * @version 1.0
 * @since: 	2015-05-08
 * @author 	梁家豪
 * @serial:	2015-05-08
 */
public class SmsSendBatchCurrent implements Serializable{
	private static final long serialVersionUID = -7622013250894695084L;
	private String smsBatchCode  ; //短信发送批次号  
	 private String customerId    ; // 客户编号
	 private String userId        ; // 用户ID
	 private Date   submitTime    ; // 用户提交时间  
	 private String abilityId     ; // 能力ID
	 private String interFaceId   ; // 接口ID
	 private String appId         ; //应用ID
	 private String batchStatus   ; // 01  已提交  02  已发送
	 private String downPort      ; // 下行端口号
	 
	 private List<MobileSendCurrent> mobileList = new ArrayList<MobileSendCurrent>(); //一对多号码
	 private SmsSendContent contentBean = new SmsSendContent(); //一对一短信正文
	 
	 
	 
	public List<MobileSendCurrent> getMobileList() {
		return mobileList;
	}
	public void setMobileList(List<MobileSendCurrent> mobileList) {
		this.mobileList = mobileList;
	}
	public SmsSendContent getContentBean() {
		return contentBean;
	}
	public void setContentBean(SmsSendContent contentBean) {
		this.contentBean = contentBean;
	}
	public String getSmsBatchCode() {
		return smsBatchCode;
	}
	public void setSmsBatchCode(String smsBatchCode) {
		this.smsBatchCode = smsBatchCode;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(Date submitTime) {
		this.submitTime = submitTime;
	}
	public String getAbilityId() {
		return abilityId;
	}
	public void setAbilityId(String abilityId) {
		this.abilityId = abilityId;
	}
	public String getInterFaceId() {
		return interFaceId;
	}
	public void setInterFaceId(String interFaceId) {
		this.interFaceId = interFaceId;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getBatchStatus() {
		return batchStatus;
	}
	public void setBatchStatus(String batchStatus) {
		this.batchStatus = batchStatus;
	}
	public String getDownPort() {
		return downPort;
	}
	public void setDownPort(String downPort) {
		this.downPort = downPort;
	}
	
	 
}
