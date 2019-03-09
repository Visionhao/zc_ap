package com.mp100.risk.ap.auditing.service;
import java.util.List;
import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.TeamDecisions;
import com.mp100.risk.ap.seats.domain.hibernate.dv.TaskDivideView;


/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审核工作台业务接口
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public interface IAuditingService {
	
	/***获取正常的成员和对应的成员任务**/
	public List<TaskDivideView>  getNormalMembers();
	
	/***查询成员对应审批任务**/
	public List<AuditTaskView>   membersAuditTask(int pageNumber,String session); 
	
	 /***用于处理审核工作台放拦和跳过操作**/
    public void aduitOperation(AuditTaskView auditTaskView,String session);
    
    /** 审核工作台（快速扫描）-求帮助*/
    public void help(TeamDecisions teamDecisions);
    /** 审核工作台（快速扫描）-我帮助别人*/
   	public void helpOthers(TeamDecisions teamDecisions);
    
    /** 审核工作台（快速扫描）-发起投票*/
    public void launchVotes(TeamDecisions teamDecisions,String session);
    
    /** 审核工作台（快速扫描）-分错了*/
    public void taskError(AuditTaskView auditTaskView,String session);
    
    /**审核工作台（快速扫描）-详情页面*/
    public AuditTaskView showDetail(AuditTaskView auditTaskView,String session);
}
