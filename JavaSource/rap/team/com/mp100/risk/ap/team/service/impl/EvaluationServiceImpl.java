package com.mp100.risk.ap.team.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.MachineDecide;
import com.mp100.risk.ap.team.service.IEvaluationService;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.service.IDaoService;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-评测系统实现类
 * @version 1.0
 * @since: 	2015-05-13
 * @author 	吴文浩
 * @serial:	2015-05-13
 */
public class EvaluationServiceImpl implements IEvaluationService{

	/***查询已审核通过的任务**/
	public List<AuditTaskView> passAuditTask(){
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		List<AuditTaskView> taskList= (List<AuditTaskView>)daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryEvaluationTaskListDV", new HashMap());
		List<MachineDecide> decideList=new ArrayList<MachineDecide>();
		if(ObjectUtils.isNotNull(taskList)){
			for (AuditTaskView auditTaskView : taskList) {
				decideList.clear();
				decideList = (List<MachineDecide>) daoService.findByPropertyName(MachineDecide.class, "auditTaskId", auditTaskView.getAuditTaskId()); 
				auditTaskView.setDecideMap(getMap(decideList));
			}
		}
		return taskList;
	}
	
	/***根据特征列表将标签id和标签值封装成key,value**/
    public Map<String,MachineDecide>  getMap(List<MachineDecide> decideList){
    	//需要封装协助信息
    	Map<String,MachineDecide>  decideMap=new HashMap<String,MachineDecide>();
        for (MachineDecide decide : decideList) {
        	decideMap.put(decide.getLabelId(), decide);
		}
    	return decideMap;
    }

    /**评测系统-详情页面*/
	public AuditTaskView showDetailList(AuditTaskView auditTaskView,String session) {
		//回话获取成员编号
    	Map<String,String> map=new HashMap<String,String>();
    	map.put("QT_auditTaskId", auditTaskView.getAuditTaskId());
    	map.put("QT_membersId", session);
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
    	List<MachineDecide> decideList=new ArrayList<MachineDecide>();
		List<AuditTaskView> taskList= (List<AuditTaskView>)daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryTaskDetailDV", map);
		if(ObjectUtils.isNotNull(taskList)) {
			auditTaskView=taskList.get(0);
			decideList = (List<MachineDecide>) daoService.findByPropertyName(MachineDecide.class, "auditTaskId", auditTaskView.getAuditTaskId()); 
			auditTaskView.setDecideMap(getMap(decideList));
		}
    	return auditTaskView;
	}

}
