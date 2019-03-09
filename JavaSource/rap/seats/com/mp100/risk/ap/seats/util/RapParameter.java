package com.mp100.risk.ap.seats.util;

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
	
	/**数据加工处理时间*/
	public static final Integer  DICTIONARY_TIME_TASK_PROCESS=7000;
	
	/**任务分配时间*/
	public static final Integer  DICTIONARY_TIME_TASK_DIVIDE=5000;
	
	/**相似度精度 0.9 */
	public static final double  DICTIONARY_SIMILAR_PRECISION=0.9;
	
	/**相似度匹配样本数量*/
	public static final double  DICTIONARY_SIMILAR_CACHE_COUNT=2000;
	
	/**dubbo生产者文件路径*/
	public static final String DICTIONARY_PATH_PROVIDER="classpath:"+System.getProperty("file.separator")+"config"+System.getProperty("file.separator")+"dubbo"+System.getProperty("file.separator")+"dubbo-provider.xml";
	
	/**自动审核扫描时间*/
	public static final Integer DICTIONARY_AUTOAUDOT_TIME = 60000;
}
