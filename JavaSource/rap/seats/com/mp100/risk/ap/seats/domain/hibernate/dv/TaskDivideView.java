package com.mp100.risk.ap.seats.domain.hibernate.dv;
import java.io.Serializable;
import java.util.Date;
/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	任务分配实体
 * @version 1.0
 * @since: 	2015-04-22
 * @author 	梁家豪
 * @serial:	2015-04-22
 */
public class TaskDivideView implements Serializable{
 
	private static final long serialVersionUID = 1L;
	private String taskAssignId ;//任务指派标识
    private String membersId ;//任务指派标识
    private String workCategory ;//任务类别
    private Integer workLoad ;//任务量
    
    private String jobNumber;// 工号
    private String membersName;//成员
    private Date createDate;//时间
    private String membersGroupName;//组名
  
    
    public TaskDivideView() {
	 
    }

    /** full constructor */
    public TaskDivideView(String taskAssignId,  String workCategory,
    		Integer workLoad,String jobNumber,String membersName,Date createDate,String membersGroupName,String membersId) {
		this.taskAssignId = taskAssignId;
		this.workCategory = workCategory;
		this.workLoad = workLoad;
		
		this.jobNumber = jobNumber;
		this.membersName = membersName;
		this.createDate = createDate;
		this.membersGroupName = membersGroupName;
		this.membersId=membersId;
	}

	public String getTaskAssignId() {
		return taskAssignId;
	}

	public void setTaskAssignId(String taskAssignId) {
		this.taskAssignId = taskAssignId;
	}

	public String getMembersId() {
		return membersId;
	}

	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}

	public String getWorkCategory() {
		return workCategory;
	}

	public void setWorkCategory(String workCategory) {
		this.workCategory = workCategory;
	}

	public Integer getWorkLoad() {
		return workLoad;
	}

	public void setWorkLoad(Integer workLoad) {
		this.workLoad = workLoad;
	}

	public String getJobNumber() {
		return jobNumber;
	}

	public void setJobNumber(String jobNumber) {
		this.jobNumber = jobNumber;
	}

	public String getMembersName() {
		return membersName;
	}

	public void setMembersName(String membersName) {
		this.membersName = membersName;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getMembersGroupName() {
		return membersGroupName;
	}

	public void setMembersGroupName(String membersGroupName) {
		this.membersGroupName = membersGroupName;
	}
	

  
}
