package com.mp100.risk.ap.auditing.domain.hibernate.hbm;
import java.io.Serializable;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-短信发送号码明细实体
 * @version 1.0
 * @since: 	2015-05-08
 * @author 	梁家豪
 * @serial:	2015-05-08
 */
public class MobileSendCurrent implements Serializable{

	private static final long serialVersionUID = -6626212390579057256L;
	private String sendNumFlowCode          ; //发送号码流水号   
	private String smsBatchCode             ; //短信发送批次号
	private String smsContentCode           ; //短信发送正文编号 
	private String phoneNum                 ; //手机号码
	private String numStatus                ; //数量状态   
	private String gatewayStatus            ; //网关访问状态
	private String gatewayStatusTime        ; //网关访问状态时间
	private String gatewayMsgId             ; //网关消息ID
	private String gatewayCode              ; //网关状态码
	
	
	public String getSendNumFlowCode() {
		return sendNumFlowCode;
	}
	public void setSendNumFlowCode(String sendNumFlowCode) {
		this.sendNumFlowCode = sendNumFlowCode;
	}
	public String getSmsBatchCode() {
		return smsBatchCode;
	}
	public void setSmsBatchCode(String smsBatchCode) {
		this.smsBatchCode = smsBatchCode;
	}
	public String getSmsContentCode() {
		return smsContentCode;
	}
	public void setSmsContentCode(String smsContentCode) {
		this.smsContentCode = smsContentCode;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getNumStatus() {
		return numStatus;
	}
	public void setNumStatus(String numStatus) {
		this.numStatus = numStatus;
	}
	public String getGatewayStatus() {
		return gatewayStatus;
	}
	public void setGatewayStatus(String gatewayStatus) {
		this.gatewayStatus = gatewayStatus;
	}
	public String getGatewayStatusTime() {
		return gatewayStatusTime;
	}
	public void setGatewayStatusTime(String gatewayStatusTime) {
		this.gatewayStatusTime = gatewayStatusTime;
	}
	public String getGatewayMsgId() {
		return gatewayMsgId;
	}
	public void setGatewayMsgId(String gatewayMsgId) {
		this.gatewayMsgId = gatewayMsgId;
	}
	public String getGatewayCode() {
		return gatewayCode;
	}
	public void setGatewayCode(String gatewayCode) {
		this.gatewayCode = gatewayCode;
	}
	
	   
	   
}
