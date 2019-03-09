package com.mp100.risk.ap.team.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mp100.risk.ap.auditing.domain.hibernate.dv.AuditTaskView;
import com.mp100.risk.ap.team.domain.hibernate.dv.EvaluationView;
import com.mp100.risk.ap.team.domain.hibernate.dv.MembersView;
import com.mp100.risk.ap.team.domain.hibernate.hbm.Evaluation;
import com.mp100.risk.ap.team.service.IEvaluationService;
import com.mp100.risk.ap.util.RapParameter;
import com.opensymphony.xwork2.Action;
import com.uap.common.util.massgeUtils;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.DateUtils;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.service.IDaoService;
import com.uap.core.web.jmesa.action.BaseJmesaAction;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核平台 v1.0 
 * 类描述 : 	人工审批-评测系统Action类
 * @version 1.0
 * @since: 	2015-05-12
 * @author 	吴文浩
 * @serial:	2015-05-12
 */
public class EvaluationSystemAction extends BaseJmesaAction{

	private static final long serialVersionUID = 1L;
	
	private List<AuditTaskView> auditTaskList=new ArrayList<AuditTaskView>();
	private AuditTaskView auditTaskView;
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.评测系统】模块的主页面。
	 * ====================================================================
	 */
	public String main(){
		long num_01 = 0,num_02 = 0,num_03 = 0,total = 0;
		double rate = 0,num_04 = 0,num_05 = 0,num_06 = 0;
		java.text.DecimalFormat   df=new   java.text.DecimalFormat("#.##");  
		java.text.DecimalFormat   dfs=new   java.text.DecimalFormat("#");  
		Map<String,String> map = new HashMap<String,String>();
		MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
		String membersId = membersView.getMembersId();
		if(ObjectUtils.isNotNull(membersId)) map.put("QT_membersId", membersId);
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		List<EvaluationView> last = (List<EvaluationView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryEvaluationViewLastDV", map);
		List<EvaluationView> best = (List<EvaluationView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryEvaluationViewBestDV", map);
		List<EvaluationView> sum = (List<EvaluationView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryEvaluationViewErrorDV", map);
		
		if(ObjectUtils.isNotNull(last)) num_01 = last.get(0).getExactnessTotal();
		if(ObjectUtils.isNotNull(best)) num_02 = best.get(0).getExactnessTotal();
		if(ObjectUtils.isNotNull(sum)) num_03 = sum.get(0).getErrorTotal();
		if(ObjectUtils.isNotNull(sum)) num_04 = sum.get(0).getExactnessTotal();
		if(ObjectUtils.isNotNull(total)) num_05 = num_03+num_04;
		if(ObjectUtils.isNotNull(rate)) num_06 = num_04/num_05;
		getRequest().setAttribute("lastNum", num_01);
		getRequest().setAttribute("bestNum", num_02);
		getRequest().setAttribute("errorNum", num_03);
		getRequest().setAttribute("exactnessNum", dfs.format(num_04));
		getRequest().setAttribute("totalNum", dfs.format(num_05));
		getRequest().setAttribute("membersView", membersId);
		if(num_05 == 0){
			getRequest().setAttribute("rateNum", 0);
		}else{
			getRequest().setAttribute("rateNum", df.format(num_06*100));
		}
		
		return successView;
	}

	/**
	 * ===================================================================* 
	 * 进入 【人工审核.评测系统】模块的列表。
	 * ====================================================================
	 */
	 public String passAuditTask(){
		   try{
			 IEvaluationService evaluationService = (IEvaluationService) AppContextUtils.getBean(IEvaluationService.class.getName());
			 auditTaskList=evaluationService.passAuditTask();
			 }catch(Exception e){
				LogUtils.error("评测系统加载任务出错", e);
			}
		   return "passAuditTask";
	 }
	 
	 /**
		 * ===================================================================* 
		 * 进入 【人工审核.评测系统】模块的提交保存操作。
		 * ====================================================================
		 */
	 public String save(){
		boolean flag = false;
			try {
				 //回话获取
				 MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
				 String membersId = membersView.getMembersId();
				 IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
				 Evaluation evaluation = (Evaluation) getModel(Evaluation.class);
				 evaluation.setMembersId(membersId);
				 evaluation.setCreateDate(DateUtils.currentDate());
				 daoService.saveEntity(evaluation);
				flag = true;
			} catch (Exception e) {
				LogUtils.error("提交失败！", e);
				e.printStackTrace();
			}finally{
				massgeUtils.massge(flag);
			}
		return Action.NONE;
	 }
	 
	 /**
		 * ===================================================================* 
		 * 进入 【人工审核.评测系统】模块的查看详情页面
		 * ====================================================================
		 */
	public String showDetailList(){
		 try{
			 IEvaluationService evaluationService = (IEvaluationService) AppContextUtils.getBean(IEvaluationService.class.getName());
			 MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);	
			 this.auditTaskView=evaluationService.showDetailList(auditTaskView,membersView.getMembersId());
		}catch(Exception e){
			LogUtils.error("评测系统-详情页面出错", e);
			e.printStackTrace(); 
		}
		 return "showDetailList";
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
	 
	 
}
