package com.mp100.risk.ap.auditing.domain.hibernate.hbm;
import java.util.Date;

/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	人工校正样本库实体
 * @version 1.0
 * @since: 	2015-05-08
 * @author 	梁家豪
 * @serial:	2015-05-08
 */
public class AuditSamples {
	  private String sampleId;     //样本标识
	  private String message ;     //内容
	  private String machineSort;  //机器分类
	  private String manualSort;   //人工分类
	  private Date   createDate;   //创建日期
	  private String membersId;    //成员编号
	  
	  
	public String getSampleId() {
		return sampleId;
	}
	public void setSampleId(String sampleId) {
		this.sampleId = sampleId;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getMachineSort() {
		return machineSort;
	}
	public void setMachineSort(String machineSort) {
		this.machineSort = machineSort;
	}
	public String getManualSort() {
		return manualSort;
	}
	public void setManualSort(String manualSort) {
		this.manualSort = manualSort;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}
	  
	  
}
