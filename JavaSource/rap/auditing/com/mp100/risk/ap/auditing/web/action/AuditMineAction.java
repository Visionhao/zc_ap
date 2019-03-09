package com.mp100.risk.ap.auditing.web.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditTaskPool;
import com.mp100.risk.ap.auditing.service.IAuditingService;
import com.mp100.risk.ap.team.domain.hibernate.dv.MembersView;
import com.mp100.risk.ap.util.RapParameter;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.LogUtils;
import com.uap.core.service.IDaoService;
import com.uap.core.web.action.base.BaseAction;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审核工作台(排雷)Action类
 * @version 1.0
 * @since: 	2015-04-23
 * @author 	梁家豪
 * @serial:	2015-04-23
 */
@SuppressWarnings("serial")
public class AuditMineAction extends BaseAction{
	private List<AuditTaskView> auditTaskList=new ArrayList<AuditTaskView>();
	/** 审核工作台（排雷）-主页面*/
	 @SuppressWarnings({ "rawtypes", "unchecked" })
	 public String main(){
		 IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		 MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
		 Map<String,String> map = new HashMap<String,String>();
		 map.put("QT_membersId", membersView.getMembersId());
		 List<AuditTaskView> totalList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMemberTotalDV", new HashMap());
		 getRequest().setAttribute("totalList", totalList);
		 //查询每个人每天审核的短信放行总量  
		 List<AuditTaskView> passList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMemberPassDV", new HashMap());
		 getRequest().setAttribute("passList", passList);
		 
		 //查询除了登录成员所有人每天审核的短信总量 
		 List<AuditTaskView> exceptTotalList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryexceptMemberTotalDV", map);
		 getRequest().setAttribute("exceptTotalList", exceptTotalList);
		 //查询除了登录成员所有人每天审核的短信放行总量
		 List<AuditTaskView> exceptPassList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryexceptMemberPassDV", map);
		 getRequest().setAttribute("exceptPassList", exceptPassList);
		 
		 //查询当天所有的任务
		 List<AuditTaskPool> sumTaskList = (List<AuditTaskPool>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.hbm.querySumTaskDV", new HashMap());
		 getRequest().setAttribute("sumTaskList", sumTaskList);
		 //查询当天当前登录的成员的所有任务
		 List<AuditTaskPool> taskSumList = (List<AuditTaskPool>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.hbm.queryMembersSumTaskDV",  map);
		 getRequest().setAttribute("taskSumList", taskSumList);
		 //查询登录成员当天已审短信总量 
		 List<AuditTaskView> membersTaskList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryLoginMemberTotalDV",  map);
		 getRequest().setAttribute("membersTaskList", membersTaskList);
		 
		 //查询登录的成员
		 List<AuditTaskView> loginMember = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryLoginMemberDV", map);
		 getRequest().setAttribute("loginMember", loginMember);
		 
		 List<MembersView> memberLogin = (List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersTaskDV", map);
		 getRequest().setAttribute("memberLogin", memberLogin);
		 return "main";
	 }
	 
	 /** 审核工作台（快速扫描）-获取成员审批任务列表*/
	 public String membersAuditTask(){
		   try{
			 IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
			 MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
			 auditTaskList=auditingService.membersAuditTask(RapParameter.DICTIONARY_TASK_MINE_COUNT,membersView.getMembersId());
			 }catch(Exception e){
				LogUtils.error("审核工作台-排雷加载任务出错", e);
				e.printStackTrace(); 
			}
		   return "membersAuditTask";
	 }

	public List<AuditTaskView> getAuditTaskList() {
		return auditTaskList;
	}

	public void setAuditTaskList(List<AuditTaskView> auditTaskList) {
		this.auditTaskList = auditTaskList;
	}
	 
	 
}
