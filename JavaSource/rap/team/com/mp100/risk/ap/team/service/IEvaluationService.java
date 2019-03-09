package com.mp100.risk.ap.team.service;

import java.util.List;

import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;

public interface IEvaluationService {

	/***查询已审核通过的任务**/
	public List<AuditTaskView>   passAuditTask(); 
	
	/**评测系统-详情页面*/
    public AuditTaskView showDetailList(AuditTaskView auditTaskView,String session);
}
