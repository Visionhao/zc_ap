package com.mp100.risk.ap.team.thread;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;
import com.mp100.risk.ap.seats.util.GainUuidutils;
import com.mp100.risk.ap.team.domain.hibernate.dv.ComplainContentView;
import com.mp100.risk.ap.team.domain.hibernate.hbm.ComplainContent;
import com.mp100.risk.ap.team.domain.hibernate.hbm.Complainant;
import com.mp100.risk.ap.team.util.ContentSimilarUtil;
import com.mp100.risk.ap.team.util.RapParameter;
import com.mp100.risk.ap.util.RapDateUtils;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.domain.dao.IBaseDao;
import com.uap.core.service.IDaoService;

public class ComplaintsBackThread extends Thread{

	private final static ReentrantReadWriteLock readWriterLock = new ReentrantReadWriteLock() ;
    private final static Lock writeLock = readWriterLock.writeLock();
    
    public void run(){
		while(true){
	       try {
	    	  writeLock.lock();
	    	  IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
	    	  Map<String,String> map = new HashMap<String,String>();
	    	  Map<String,List<String>> maps = new HashMap<String,List<String>>();
	    	  //查询投诉回溯内容表中没有回溯过的数据
	    	  List<ComplainContentView> contentList =  (List<ComplainContentView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryListViewDV", new HashMap());
	    	  
	    	  for (ComplainContentView complainContentView : contentList) {
	    		  map.put("QD_month", ComplaintsBackThread.getDate(complainContentView.getComplainDate()));
	    		  map.put("QT_port", complainContentView.getComplainPort());
	    		  //在通过条件筛选出来的数据(状态，端口，时间)
	    		  String membersId = "";
	    		  //1 状态00，端口，时间(15)
		    	  List<AuditTaskView> auditTask =  (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryComplainBackMatchViewDV", map);
	    		  //ContentSimilarUtil.initContent(auditTask);
		    	  if(ObjectUtils.isNotNull(auditTask)){
			    	  //2 根据审批编号查询号码
		    		  for (AuditTaskView auditTaskView : auditTask) {
		    			  //查询号码ist <mobile> L有号码代表第二步成功(根据流水表)
		    			  List<AuditTaskView> phoneList =  (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryComplainBackPhoneListDV", map);
		    			  
		    			  if(ObjectUtils.isNotNull(phoneList)){
		    				  // 删除无号码审批短信
		    				  ContentSimilarUtil.initContent(auditTaskView.getCustGrade(),auditTaskView.getMsg());
		    			  }else{
		    				  ComplainContent complain = (ComplainContent) daoService.findEntityByKey(ComplainContent.class, complainContentView.getComplainId());
				    		  complain.setBackTrace("01");
				    		  daoService.updateEntity(complain);
		    			  }
					  }
		    	  }else{
		    		  //改状态
		    		  ComplainContent complain = (ComplainContent) daoService.findEntityByKey(ComplainContent.class, complainContentView.getComplainId());
		    		  complain.setBackTrace("01");
		    		  daoService.updateEntity(complain);
		    	  }
	    		  //第三步
		    	  membersId =ContentSimilarUtil.similarMatching(complainContentView.getComplainContent());
	    		 //回溯成功
	    		 if(ObjectUtils.isNotNull(membersId)){
	    			 //成员编号 
	    			 ComplainContent complain = (ComplainContent) daoService.findEntityByKey(ComplainContent.class, complainContentView.getComplainId());
	    			 complain.setMembersId(membersId);
		    		 complain.setBackTrace("01");
		    		 daoService.updateEntity(complain);
	    		 }else{//回溯失败
	    			 ComplainContent complain = (ComplainContent) daoService.findEntityByKey(ComplainContent.class, complainContentView.getComplainId());
	    			 complain.setBackTrace("01");
		    		 daoService.updateEntity(complain);
	    		 }
			  }
	    	  //统计数据到投诉人模式表
	    	  List<String> QD_months = RapDateUtils.getSomeMoth(6);	
	    	  maps.put("QD_months", QD_months);
	    	  //查询出每个月中每个人审核的短信总量
	    	  List<AuditTaskView> totalList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryContentListDV", maps);
	    	  //查询每个月每个人的投诉总量
	    	  List<ComplainContentView> complaintNumList = (List<ComplainContentView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryComplaintNumDV", maps);
			  //查询每个月每个人的审核放行短信总量
	    	  List<AuditTaskView> passNumList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryPassNumDV", maps);
			  //查询每个月每个人的审核拦截短信总量
	    	  List<AuditTaskView> interceptNumList = (List<AuditTaskView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryInterceptNumDV", maps);

	    	  daoService.executeQuerySQL("delete from X_AP_COMPLAINANT");
	    	  IBaseDao baseDao=(IBaseDao)AppContextUtils.getBean(IBaseDao.class.getName());
	    	  if(ObjectUtils.isNotNull(totalList) && ObjectUtils.isNotNull(complaintNumList) && ObjectUtils.isNotNull(passNumList) && ObjectUtils.isNotNull(interceptNumList)){
				  for (AuditTaskView auditTaskView : totalList) {
					  List<Complainant> list=new ArrayList<Complainant>();
					  Complainant complainant = new Complainant();
					  
					  complainant.setComplaintId(GainUuidutils.createUUID());
    				  complainant.setMembersId(auditTaskView.getCustName());
    				  complainant.setMonth(auditTaskView.getCustGrade());
    				  complainant.setExamineNum(Integer.parseInt(auditTaskView.getPersonDecide()));
    				  list.add(complainant);
    				  baseDao.save(list);
				  		  
    				  for (ComplainContentView complainContentView : complaintNumList) {
    					  if(auditTaskView.getCustName().equals(complainContentView.getMembersId()) && auditTaskView.getCustGrade().equals(complainContentView.getComplainDate())){
    						  complainant.setComplaintId(complainant.getComplaintId());
    						  complainant.setComplaintNum(Integer.parseInt(complainContentView.getComplainPort()));
    						  int ComplaintNum = Integer.parseInt(complainContentView.getComplainPort());
    						  int ExamineNum = complainant.getExamineNum();
    						  double ComplaintNumd =  ComplaintNum;
    						  double ExamineNumd = ExamineNum;
    						  BigDecimal bd = new BigDecimal(ComplaintNumd/ExamineNumd);
    						  complainant.setComplaintRate(bd.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
    						  baseDao.update(list);
    					  }
    				  }
    				  for (AuditTaskView auditTasks : passNumList) {
    					  if(auditTaskView.getCustName().equals(auditTasks.getCustName()) && auditTaskView.getCustGrade().endsWith(auditTasks.getCustGrade())){
    						  complainant.setComplaintId(complainant.getComplaintId());
    						  complainant.setPassNum(Integer.parseInt(auditTasks.getPersonDecide()));
    						  baseDao.update(list);
    					  }
    				  }
    				  for (AuditTaskView auditTasksView : interceptNumList) {
    					  if(auditTaskView.getCustName().equals(auditTasksView.getCustName()) && auditTaskView.getCustGrade().endsWith(auditTasksView.getCustGrade())){
    						  complainant.setComplaintId(complainant.getComplaintId());
    						  complainant.setInterceptNum((Integer.parseInt(auditTasksView.getPersonDecide())));
    						  baseDao.update(list);
    					  }
    				  }
		    	  }	
			  }
	    	  //定时扫描
	    	  Thread.sleep(RapParameter.DICTIONARY_COMPLAINTS_BACK_TIME);
			} catch (InterruptedException e) {
				LogUtils.error("投诉回溯扫描数据库出错", e);
		    }finally{
				writeLock.unlock() ;
			}
	    	
	   }
}
    
    //获取数据库中日期的前15天的数据
    public static String getDate(String specifiedDay){ 
    	Calendar c = Calendar.getInstance(); 
    	Date date=null; 
    	try { 
    		date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(specifiedDay); 
    	} catch (ParseException e) { 
    		e.printStackTrace(); 
    	} 
    	c.setTime(date); 
    	int day=c.get(Calendar.DATE); 
    	c.set(Calendar.DATE,day-15); 

    	String dayBefore=new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()); 
    	return dayBefore; 
    } 

    public void add(List<Complainant> list) {
		IBaseDao baseDao=(IBaseDao)AppContextUtils.getBean(IBaseDao.class.getName());
		baseDao.save(list);
	}
}
