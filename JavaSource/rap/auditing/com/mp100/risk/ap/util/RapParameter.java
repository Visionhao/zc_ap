package com.mp100.risk.ap.util;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核平台V1.0  
 * 类描述 : 	数据字典代码说明
 * @version 1.0
 * @since: 	2015-4-21
 * @author 	吴文浩
 * @serial:	2015-4-21
 */
public class RapParameter {
	/**成员管理状态--正常 */
	public static final String DICTIONARY_MEMBER_STATUS_ONLINE = "XF003001"; 
	/**成员管理状态--暂停 */
	public static final String DICTIONARY_MEMBER_STATUS_LEAVE = "XF003002"; 
	/**成员管理状态--未加入 */
	public static final String DICTIONARY_MEMBER_STATUS_NOJOIN= "XF003003"; 
	
	/**任务分配类型 -按量 */
	public static final String  DICTIONARY_TASK_TYPE_ALL="XF003101";
	
	
	/**任务团队决策类型-投票 */
	public static final String DICTIONARY_TASK_TYPE_VOTE= "XF003201"; 
	
	/**任务团队决策类型-求帮助 */
	public static final String DICTIONARY_TASK_TYPE_HELP= "XF003202"; 
	
	/**审核工作台快速审核条数 */
	public static final int DICTIONARY_TASK_FAST_COUNT= 5; 
	
	/**审核工作台快排雷条数 */
    public static final int DICTIONARY_TASK_MINE_COUNT= 1; 
    
    
    /**审核工作台操作放行   */
    public static final String DICTIONARY_AUDIT_OPERATION_FANG= "fang"; 
   /**审核工作台操作跳过  */
    public static final String DICTIONARY_AUDIT_OPERATION_SKIP= "skip"; 
   /**审核工作台操作拦截  */
    public static final String DICTIONARY_AUDIT_OPERATION_INTERCEPT= "intercept"; 
    
    
	/**任务状态-待审批 */
	public static final String DICTIONARY_TASK_STATE_DAI= "XF003501"; 
	
	/**任务状态-已审批 */
	public static final String DICTIONARY_TASK_STATE_YI= "XF003502"; 
	
    /**登录获取到的session*/
	public static final String DICTIONARY_LOGIN_INFO = "LoginInfo";
	
}
