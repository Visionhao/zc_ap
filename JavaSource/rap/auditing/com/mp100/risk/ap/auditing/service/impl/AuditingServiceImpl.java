package com.mp100.risk.ap.auditing.service.impl;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;
import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTrategyView;
import com.mp100.risk.ap.auditing.domain.hibernate.dv.TeamDecisionsView;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditSamples;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditTask;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.MachineDecide;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.TeamDecisions;
import com.mp100.risk.ap.auditing.service.IAuditingService;
import com.mp100.risk.ap.seats.domain.hibernate.dv.TaskDivideView;
import com.mp100.risk.ap.seats.util.ClietnConnectDubbo;
import com.mp100.risk.ap.util.RapParameter;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.DateUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.service.IDaoService;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审核工作台业务实现类
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public class AuditingServiceImpl implements IAuditingService {
	
	
	/***获取正常的成员和对应的成员任务**/
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public List<TaskDivideView>  getNormalMembers(){
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
    	return (List<TaskDivideView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.seats.domain.hibernate.dv.queryTaskListDV", new HashMap());
    }
    
    /***查询成员对应审批任务**/
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public List<AuditTaskView>   membersAuditTask(int pageNumber,String session){
    	Map map=new HashMap();
    	map.put("QT_membersId", session);
    	map.put("QT_munber", pageNumber);
    	
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		List<AuditTaskView> taskList= (List<AuditTaskView>)daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryAuditTaskListDV", map);
		List<MachineDecide> decideList=new ArrayList<MachineDecide>();
		if(ObjectUtils.isNotNull(taskList)){
			for (AuditTaskView auditTaskView : taskList) {
				//根据任务类型查询分别处理业务
				auditTaskView=decideTypeHandle(auditTaskView,daoService);
				decideList.clear();
				decideList = (List<MachineDecide>) daoService.findByPropertyName(MachineDecide.class, "auditTaskId", auditTaskView.getAuditTaskId()); 
				auditTaskView.setDecideMap(getMap(decideList));
			}
		}
		return taskList;
	}
   
    /***根据任务类型查询分别处理业务**/
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public AuditTaskView  decideTypeHandle(AuditTaskView task,IDaoService daoService){
    	//处理decideType 字段结果  1预警任务 2 正常任务  3我投票 4我求帮助  5别人投票给我的任务  6.别人求我帮助的任务
    	if("my".equals(task.getDecideResult().trim()) && StringUtils.isBlank(task.getDecideType())){//正常任务
    		//报警任务  超过审核策略设置的预警事件则边预警任务  (查询审核策略配置表中的时间)
    		List<AuditTrategyView> auditTrategyView = (List<AuditTrategyView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryTrategyWarnTimeDV", new HashMap());
    		for (AuditTrategyView trategyView : auditTrategyView) {
    			String warnTime = trategyView.getHavePriority();
    			if(warnTime.indexOf("分钟")>0 && warnTime.indexOf("不设置")<0 || warnTime.indexOf(String.valueOf("分钟")) == -1){
    				//预警时间
    				int time =Integer.parseInt(warnTime.replaceAll("分钟", ""));
    				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    				//创建时间
    				int date = Integer.parseInt(df.format(new Date()).substring(14,16)) - Integer.parseInt(df.format(task.getCreateTime()).substring(14,16));
    				if(date >= time){
    					task.setDecideType("1");
    				}else{
    					task.setDecideType("2");
    		    		daoService.executeQuerySQL("update X_AP_PEND_TASK_POOL set IS_LOCK='0' where  IS_LOCK='1' ");
    				}
    			}
			}
    		
    		//正常任务
    		//task.setDecideType("2");
    	}else if("my".equals(task.getDecideResult().trim()) && RapParameter.DICTIONARY_TASK_TYPE_VOTE.equals(task.getDecideType())){ //我投票
    		task.setDecideType("3");
    		//处理我发起投票的任务业务 返回投票结果
    		task.setDecideResult(handleVoteService(task,daoService));
    	}else if("my".equals(task.getDecideResult().trim()) && RapParameter.DICTIONARY_TASK_TYPE_HELP.equals(task.getDecideType()) ){//我求帮助
    		//处理我求帮助的任务业务 返回帮助结果
    		task.setDecideResult(handleHelpService(task,daoService));
    		task.setDecideType("4");
    	}else if("others".equals(task.getDecideResult().trim()) && RapParameter.DICTIONARY_TASK_TYPE_VOTE.equals(task.getDecideType())){//别人投票给我的任务
    		task.setDecideType("5");
    	}else if("others".equals(task.getDecideResult().trim()) && RapParameter.DICTIONARY_TASK_TYPE_HELP.equals(task.getDecideType())){//别人求我帮助的任务
    		task.setDecideType("6");
    	}
    	return task;
    }
    
    /***处理我发起投票的任务业务 返回投票结果**/
    @SuppressWarnings("unchecked")
	public String handleVoteService(AuditTaskView task,IDaoService daoService){
    	int fang=0; int lan=0;
    	List<TeamDecisions> teamlist=new ArrayList<TeamDecisions>();
    	teamlist=(List<TeamDecisions>) daoService.findByPropertyName(TeamDecisions.class, "auditTaskId", task.getAuditTaskId()); 
		for (TeamDecisions team : teamlist) {
			//放
			if("00".equals(team.getDecideResult())){
				fang+=1;
			}else if("01".equals(team.getDecideResult())){//拦截
				lan+=1;
			}
		}
		return "总投票人数/放/拦："+teamlist.size()+"/"+fang+"/"+lan;
    }
    
    /***处理我求帮助的任务业务 返回帮助结果**/
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public String handleHelpService(AuditTaskView task,IDaoService daoService){
    	String result="";
		Map map=new HashMap();
    	map.put("QT_auditTaskId", task.getAuditTaskId());
    	List<TeamDecisionsView> teamlist=(List<TeamDecisionsView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryTermByTaskIdDV", map);
		if(ObjectUtils.isNotNull(teamlist)){
			if(ObjectUtils.isNotNull(teamlist.get(0).getDecideBasis())){
				result= teamlist.get(0).getChnName()+": "+teamlist.get(0).getDecideBasis();
			}else{
				result=  teamlist.get(0).getChnName()+":暂无回复";
			}
		}
		return result;
    }
   
    /***根据特征列表将标签id和标签值封装成keyvalue**/
    public Map<String,MachineDecide>  getMap(List<MachineDecide> decideList){
    	//需要封装协助信息
    	Map<String,MachineDecide>  decideMap=new HashMap<String,MachineDecide>();
        for (MachineDecide decide : decideList) {
        	decideMap.put(decide.getLabelId(), decide);
		}
       
    	return decideMap;
    }
    
    /***用于处理审核工作台放拦和跳过操作**/ 
    public void aduitOperation(AuditTaskView auditTaskView,String session){
    	//格式      "任务类型：任务编号,任务类型：任务编号
    	//任务类型   1预警任务 2 正常任务  3我投票 4我求帮助  5别人投票给我的任务  6.别人求我帮助的任务"
    	String [] task=auditTaskView.getAuditTaskId().split(",");
    	
    	//放行
    	if(RapParameter.DICTIONARY_AUDIT_OPERATION_FANG.equals(auditTaskView.getPersonDecide())){
    		paramSplitHandle(task,1,session);
    	}else if(RapParameter.DICTIONARY_AUDIT_OPERATION_INTERCEPT.equals(auditTaskView.getPersonDecide())){//拦截
    		paramSplitHandle(task,2,session);
    	}else if(RapParameter.DICTIONARY_AUDIT_OPERATION_SKIP.equals(auditTaskView.getPersonDecide())){//跳过
    		paramSplitHandle(task,3,session);
    	}
    }

    /***将参数拆分出来 并拼接任务编号**/ 
    public void paramSplitHandle(String [] task,int opera,String membersId){
    	
    	//任务类型
    	String taskType="";String myTaskId="";String othersTaskId="";
    	for(int i=0; i < task.length;  i++){
    		taskType=task[i].split(":")[0];
    		//处理我自己的任务
    		if(isMyTask(taskType)){
    			if(myTaskId.length()==0){
    				myTaskId+="'"+task[i].split(":")[1]+"'";
    			}else{
    			    myTaskId+=","+"'"+task[i].split(":")[1]+"'";
    			}
    		}else{//处理帮别人投票任务
    			  //修改投票结果
    			if(othersTaskId.length()==0){
    				othersTaskId+="'"+task[i].split(":")[1]+"'";
    			}else{
    				othersTaskId+=","+"'"+task[i].split(":")[1]+"'";
    			}
    		}
    		
		}
      	
    	if(opera==1){//fang
    		executeTask(myTaskId,othersTaskId,"00",membersId);
    		pushGateway(myTaskId,"E1001");
    		
    		//---------------------------------------------------------------------------对接网关放行(按照任务ID查批次流水表和号码表推送到网关)
    	}else if(opera==2) {//lan
    		executeTask(myTaskId,othersTaskId,"01",membersId);
    		pushGateway(myTaskId,"E1002");
    		
    	}else{//跳过
    		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
    		daoService.executeQuerySQL("update X_AP_PEND_TASK_POOL set IS_LOCK='1' where  AUDIT_TASK_ID in ("+myTaskId+") ");
    	}
    	
    	
    }
    /**根据任务id查询到smsId*/
    public void  pushGateway(String myTaskId,String status){
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,List<String>> map = new HashMap<String,List<String>>();
		List<String> list = new ArrayList<String>();
		String taskId = myTaskId.replace("'", "");
		String [] myTaskIds = taskId.split(",");
		for(int i=0;i<myTaskIds.length;i++){
			list.add(myTaskIds[i]);
		}
		map.put("QT_taskId", list);
		
		//查询已经放行和拦截短信的smsId
		List<AuditTaskView> pushList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryDockingGatewayDV", map);
		for (AuditTaskView auditTaskView : pushList) {
			String[] arr  = auditTaskView.getMsg().split(",");
			
			ClietnConnectDubbo.pushSms(arr, status);
		}
    }
    
    /***判定是否是自己的任务**/ 
    public Boolean isMyTask(String taskType){
    	if("1".equals(taskType) || "2".equals(taskType)|| "3".equals(taskType) || "4".equals(taskType)){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    /***执行任务**/ 
	public void executeTask(String myTaskId,String othersTaskId,String ops,String membersId){
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		//1预警任务 2 正常任务  3我投票 4我求帮助  进行操作
		if(ObjectUtils.isNotNull(myTaskId)){
			daoService.executeQuerySQL("update X_AP_AUDIT_TASK set STATE='"+RapParameter.DICTIONARY_TASK_STATE_YI+"', STATE_TIME=Current_date, PERSON_DECIDE='"+ops+"', MEMBERS_ID='"+membersId+"'  where AUDIT_TASK_ID in ("+myTaskId+") ");
			
			//删除对应的任务池数据
			daoService.executeQuerySQL("delete from  X_AP_PEND_TASK_POOL   where AUDIT_TASK_ID in ("+myTaskId+") ");
			
		}
		//XF0035
        if(ObjectUtils.isNotNull(othersTaskId)){//别人给我投票
        	daoService.executeQuerySQL("update X_AP_TERM_DECIDE set DECIDE_RESULT='"+ops+"', DECIDE_TIME=Current_date " +
        	"where DECIDE_TYPE='"+RapParameter.DICTIONARY_TASK_TYPE_VOTE+"' and  MEMBERS_ID='"+membersId+"' and AUDIT_TASK_ID in ("+othersTaskId+")");
		}
		
		
	}
    
	  /** 审核工作台（快速扫描）-求帮助*/
    public void help(TeamDecisions teamDecisions){
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName()); 
    	//修改任务标识为投票任务
    	AuditTask bean=(AuditTask)daoService.findEntityByKey(AuditTask.class,teamDecisions.getAuditTaskId());
    	bean.setTextcate_id(RapParameter.DICTIONARY_TASK_TYPE_HELP);
        //添加到团队表
    	teamDecisions.setSubmitTime(DateUtils.currentDate());
    	teamDecisions.setDecideType(RapParameter.DICTIONARY_TASK_TYPE_HELP);
    	daoService.saveEntity(teamDecisions);
    	daoService.updateEntity(bean);
    	
    }
    /** 审核工作台（快速扫描）-我帮助别人*/
   	@SuppressWarnings("unchecked")
	public void helpOthers(TeamDecisions teamDecisions){
   		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
   		List<TeamDecisions> list = (List<TeamDecisions>) daoService.findByPropertyName(TeamDecisions.class, "auditTaskId", teamDecisions.getAuditTaskId());
   		if(ObjectUtils.isNotNull(list)){
	   		TeamDecisions tbean=list.get(0);
	   		tbean.setDecideResult(teamDecisions.getDecideResult());
	   		tbean.setDecideBasis(teamDecisions.getDecideBasis());
	   		tbean.setDicideTime(DateUtils.currentDate());
	   		daoService.updateEntity(tbean);
   		}
    	
   	}
    
    /** 审核工作台（快速扫描）-发起投票*/
    public void launchVotes(TeamDecisions teamDecisions,String session){
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
    	AuditTask bean=(AuditTask)daoService.findEntityByKey(AuditTask.class,teamDecisions.getAuditTaskId());
    	bean.setTextcate_id(RapParameter.DICTIONARY_TASK_TYPE_VOTE);
    	//获取正常人员
    	List<TaskDivideView> list=getNormalMembers();
    	if(ObjectUtils.isNotNull(list)){
    		for (TaskDivideView taskDivideView : list) {
    			//排除投票给自己
    			if(!session.equals(taskDivideView.getMembersId())){
	    			TeamDecisions team=new TeamDecisions();
	    			team.setAuditTaskId(teamDecisions.getAuditTaskId());
	    			team.setMembersId(taskDivideView.getMembersId());
	    			team.setSubmitTime(DateUtils.currentDate());
	    			team.setDecideType(RapParameter.DICTIONARY_TASK_TYPE_VOTE);
    			}
			}
    		//修改任务为投票任务
    		daoService.updateEntity(bean);
    	}
    }
    
    /** 审核工作台（快速扫描）-分错了*/
    public void taskError(AuditTaskView auditTaskView,String session){
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
    	AuditSamples bean=new AuditSamples();
    	bean.setSampleId(auditTaskView.getAuditTaskId());
    	bean.setMembersId(session);
    	bean.setCreateDate(DateUtils.currentDate());
    	bean.setMachineSort(auditTaskView.getDecideResult());
    	bean.setManualSort(auditTaskView.getDecideType());
    	bean.setMessage(auditTaskView.getMsg());
    	daoService.saveEntity(bean);
    }
    
    /**审核工作台（快速扫描）-详情页面*/
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public AuditTaskView showDetail(AuditTaskView auditTaskView,String session){
    	Map map=new HashMap();
    	map.put("QT_auditTaskId", auditTaskView.getAuditTaskId());
    	map.put("QT_membersId", session);
    	IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
    	List<MachineDecide> decideList=new ArrayList<MachineDecide>();
    	//判定是否是自己的任务
    	if(isMyTask(auditTaskView.getDecideType())){
    		List<AuditTaskView> taskList= (List<AuditTaskView>)daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryAuditTaskListMyDV", map);
    		auditTaskView=taskList.get(0);
    	}else{
    		List<AuditTaskView> taskList= (List<AuditTaskView>)daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryAuditTaskListMyOthersDV", map);
    		auditTaskView=taskList.get(0);
    	}
    	auditTaskView=decideTypeHandle(auditTaskView,daoService);
		decideList = (List<MachineDecide>) daoService.findByPropertyName(MachineDecide.class, "auditTaskId", auditTaskView.getAuditTaskId()); 
		auditTaskView.setDecideMap(getMap(decideList));
    	return auditTaskView;
    }
    
}
