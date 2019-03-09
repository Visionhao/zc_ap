package com.mp100.risk.ap.auditing.web.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;
import com.mp100.risk.ap.auditing.domain.hibernate.dv.TextCateDefView;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditSamples;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditTaskPool;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.TeamDecisions;
import com.mp100.risk.ap.auditing.service.IAuditingService;
import com.mp100.risk.ap.seats.domain.hibernate.dv.TaskDivideView;
import com.mp100.risk.ap.team.domain.hibernate.dv.MembersView;
import com.mp100.risk.ap.util.RapParameter;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.service.IDaoService;
import com.uap.core.web.action.base.BaseAction;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审核工作台(快速扫描)Action类
 * @version 1.0
 * @since: 	2015-04-23
 * @author 	梁家豪
 * @serial:	2015-04-23
 */
@SuppressWarnings("serial")
public class AuditTableAction extends BaseAction{
	private List<AuditTaskView> auditTaskList=new ArrayList<AuditTaskView>();
	private List<TaskDivideView> taskDivideList=new ArrayList<TaskDivideView>();
	private List<TextCateDefView> textList=new ArrayList<TextCateDefView>();
	private AuditTaskView auditTaskView;
	private String reslut;
	private TeamDecisions teamDecisions;
	
	/** 审核工作台（快速扫描）-主页面*/
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
		 //查询登录成员的任务
		 List<MembersView> memberLogin = (List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersTaskDV", map);
		 getRequest().setAttribute("memberLogin", memberLogin);
		 return "main";
	 }
	 
	 /** 审核工作台（快速扫描）-获取成员审批任务列表*/
	 public String membersAuditTask(){
		   try{
			 IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
			 MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
			 auditTaskList=auditingService.membersAuditTask(RapParameter.DICTIONARY_TASK_FAST_COUNT,membersView.getMembersId());
			 }catch(Exception e){
				LogUtils.error("审核工作台快速扫描加载任务出错", e);
				e.printStackTrace(); 
			}
		   return "membersAuditTask";
	 }
	 
	 /** 审核工作台（快速扫描）-操作放行和拦截和跳过操作*/
	 public String aduitOperation(){
		 try{
			   IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
			   MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
			   auditingService.aduitOperation(auditTaskView,membersView.getMembersId());
			  reslut="ok";
			 }catch(Exception e){
				 reslut="no";
				LogUtils.error("审核工作台快速扫描点击放行或者拦截出错", e);
				e.printStackTrace(); 
			}
		 return "aduitOperation";
	 }
	 
	 /** 审核工作台（快速扫描）-求帮助*/
	public String help(){
	     try{
	    	  IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
			  auditingService.help(teamDecisions);
			 reslut="ok";
		}catch(Exception e){
			 reslut="no";
			LogUtils.error("审核工作台（快速扫描）-求帮助出错", e);
			e.printStackTrace(); 
		}
		return "help";
	}
	
	 /** 审核工作台（快速扫描）-我帮助别人*/
	public String helpOthers(){
		 try{
	    	  IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
			  auditingService.helpOthers(teamDecisions);
			 reslut="ok";
		}catch(Exception e){
			 reslut="no";
			LogUtils.error("审核工作台（快速扫描）-我帮助别人出错", e);
			e.printStackTrace(); 
		}
		return "helpOthers";
	}
	 /** 审核工作台（快速扫描）-发起投票*/
	 public String launchVotes(){
		 try{
	    	  IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
	    	  MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
			  auditingService.launchVotes(teamDecisions,membersView.getMembersId());
			 reslut="ok";
		}catch(Exception e){
			 reslut="no";
			LogUtils.error("审核工作台（快速扫描）-发起投票出错", e);
			e.printStackTrace(); 
		}
		return "launchVotes";
	 }
	 /** 审核工作台（快速扫描）-分错了*/
	 public String taskError(){
		 try{
	    	  IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
	    	  MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
			  auditingService.taskError(auditTaskView,membersView.getMembersId());
			 reslut="ok";
		}catch(Exception e){
			 reslut="no";
			LogUtils.error("审核工作台（快速扫描）-分错了出错", e);
			e.printStackTrace(); 
		}
		 return "taskError";
	 }
	 
	 /** 审核工作台（快速扫描）-详情页面*/
	public String showDetail(){
		 try{
	    	  IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
	    	  MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
	    	  this.auditTaskView=auditingService.showDetail(auditTaskView,membersView.getMembersId());
		}catch(Exception e){
			LogUtils.error("审核工作台（快速扫描）-详情页面出错", e);
			e.printStackTrace(); 
		}
		 return "showDetail";
	}
  
	/** 审核工作台（快速扫描）-查询正常成员*/
    public String normalMembers(){
    	 IAuditingService auditingService = (IAuditingService) AppContextUtils.getBean(IAuditingService.class.getName());
    	 taskDivideList=auditingService.getNormalMembers();
    	return "normalMembers";

    }
    
	/** 审核工作台（快速扫描）-分错了查询动机大类*/
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public String getBigClass(){
    	Map map=new HashMap();
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		textList= (List<TextCateDefView>)daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryReceiverTotalDV", map);
    	return "getBigClass";

    }
    
	/** 审核工作台（快速扫描）-分错了查询动机小类*/
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public String SmallClass(){
    	Map map=new HashMap();
    	map.put("QT_textcateId", teamDecisions.getAuditTaskId());
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		textList= (List<TextCateDefView>)daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryReceiverSmallDV", map);
		return "SmallClass";

    }
    /** 审核工作台（快速扫描）-分错了验证是否有纠正过*/
    @SuppressWarnings({"unchecked" })
    public String isCorrect(){
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
    	List<AuditSamples> slist = (List<AuditSamples>) daoService.findByPropertyName(AuditSamples.class, "sampleId", auditTaskView.getAuditTaskId()); 
    	if(ObjectUtils.isNotNull(slist)){
    		 reslut="no";
    	}else{
    		 reslut="ok";
    	}
    	return "taskError";
    }
	
	public String getReslut() {
		return reslut;
	}

	public void setReslut(String reslut) {
		this.reslut = reslut;
	}

	public List<AuditTaskView> getAuditTaskList() {
		return auditTaskList;
	}
	public void setAuditTaskList(List<AuditTaskView> auditTaskList) {
		this.auditTaskList = auditTaskList;
	}

	public AuditTaskView getAuditTaskView() {
		return auditTaskView;
	}

	public void setAuditTaskView(AuditTaskView auditTaskView) {
		this.auditTaskView = auditTaskView;
	}

	public TeamDecisions getTeamDecisions() {
		return teamDecisions;
	}

	public void setTeamDecisions(TeamDecisions teamDecisions) {
		this.teamDecisions = teamDecisions;
	}

	public List<TaskDivideView> getTaskDivideList() {
		return taskDivideList;
	}

	public void setTaskDivideList(List<TaskDivideView> taskDivideList) {
		this.taskDivideList = taskDivideList;
	}

	public List<TextCateDefView> getTextList() {
		return textList;
	}

	public void setTextList(List<TextCateDefView> textList) {
		this.textList = textList;
	}


	 
	 
}

