package com.mp100.risk.ap.auditing.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mp100.risk.ap.auditing.domain.hibernate.hbm.AuditTrategy;
import com.uap.common.confManager.domain.hibernate.hbm.CommonParam;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.DateUtils;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.service.IDaoService;
import com.uap.core.web.jmesa.action.BaseJmesaAction;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核平台 v1.0 
 * 类描述 : 	人工审批-审核策略配置Action类
 * @version 1.0
 * @since: 	2015-05-08
 * @author 	吴文浩
 * @serial:	2015-05-08
 */
public class AuditTrategyAction extends BaseJmesaAction{

	private static final long serialVersionUID = 1L;
	private AuditTrategy auditTrategy;
	private String result;
	private CommonParam commonParam;
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.审核策略配置】模块的主页面。
	 * ====================================================================
	 */
	public String main(){
		return successView;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.审核策略配置】模块的列表展示。
	 * ====================================================================
	 */
	public String list(){
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,String> map = new HashMap<String,String>();
		List<AuditTrategy> auditTrategy = (List<AuditTrategy>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryAuditTrategyViewDV", map);
		if(ObjectUtils.isNotNull(auditTrategy)){
			getRequest().setAttribute("AuditTrategy", auditTrategy.get(0));
		}
		List<CommonParam> commonParam = (List<CommonParam>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.auditing.domain.hibernate.dv.queryAuditTrategyView1DV", map);
		getRequest().setAttribute("commonParam", commonParam);
		return successView;
	}

	/** ===================================================================
	 * 【业务策略-EC分级管理】功能：EC分级管理等级模板的异步修改操作
	 * ====================================================================
	 */
	public String update(){
		try {
			IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
			daoService.updateEntity(this.auditTrategy);
			result = "yes";
		} catch (Exception e) {
			LogUtils.error("修改审核策略出错", e);
			result = "no";
		}
		return result;
	}
	
	/** ===================================================================
	 * 【业务策略-EC分级管理】功能：EC分级管理等级模板的异步修改操作
	 * ====================================================================
	 */
	public String updateAudit(){
		try {
			String id = getRequest().getParameter("id");
			String value = getRequest().getParameter("value");
			IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
			CommonParam commonParamVO = new CommonParam();
			commonParamVO.setParamId(id);
			commonParamVO.setParamName(value);
			commonParamVO.setParamValue(value);
			commonParamVO.setParamType("02");
			commonParamVO.setCreateDate(DateUtils.currentDate());
			commonParamVO.setOfSys("MEIPM");
			CommonParam commonParamPO = (CommonParam) daoService.findEntityByKey(CommonParam.class,commonParamVO.getParamId());
			
			ObjectUtils.copyProperties(commonParamVO, commonParamPO);
			
			daoService.updateEntity(commonParamPO);
			result = "yes";
		} catch (Exception e) {
			LogUtils.error("修改审核策略出错", e);
			result = "no";
		}
		return result;
	}
	
	public AuditTrategy getAuditTrategy() {
		return auditTrategy;
	}

	public void setAuditTrategy(AuditTrategy auditTrategy) {
		this.auditTrategy = auditTrategy;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
}
