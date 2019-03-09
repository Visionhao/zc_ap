package com.mp100.risk.ap.auditing.domain.hibernate.hbm;

import java.io.Serializable;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-短信发送正文记录实体
 * @version 1.0
 * @since: 	2015-05-08
 * @author 	梁家豪
 * @serial:	2015-05-08
 */
public class SmsSendContent implements Serializable{

	private static final long serialVersionUID = 7014951868842284849L;
	private String smsContentCode ; //短信发送正文编号
	private String smsBatchCode   ; //短信发送批次号
	private String smsContent     ; //短信正文
	
	public String getSmsContentCode() {
		return smsContentCode;
	}
	public void setSmsContentCode(String smsContentCode) {
		this.smsContentCode = smsContentCode;
	}
	public String getSmsBatchCode() {
		return smsBatchCode;
	}
	public void setSmsBatchCode(String smsBatchCode) {
		this.smsBatchCode = smsBatchCode;
	}
	public String getSmsContent() {
		return smsContent;
	}
	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}
	
	
	

}
