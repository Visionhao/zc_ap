package com.mp100.risk.ap.seats.domain.hibernate.hbm;
import java.io.Serializable;
/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	任务分配实体
 * @version 1.0
 * @since: 	2015-04-22
 * @author 	梁家豪
 * @serial:	2015-04-22
 */
public class TaskDivide implements Serializable{
	private static final long serialVersionUID = -5057423240377706170L;
	private String taskAssignId ;//任务指派标识
    private String membersId ;//成员编号
    private String workCategory ;//任务类别
    private Integer workLoad ;//任务量
  
  
    public TaskDivide() {
    	
	}

    /** full constructor */
    public TaskDivide(String taskAssignId, String membersId, String workCategory,
    		Integer workLoad) {
		this.taskAssignId = taskAssignId;
		this.membersId = membersId;
		this.workCategory = workCategory;
		this.workLoad = workLoad;
		
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
	
  
  
  
  
}
