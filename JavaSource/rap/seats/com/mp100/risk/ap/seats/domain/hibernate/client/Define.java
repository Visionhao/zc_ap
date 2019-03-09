package com.mp100.risk.ap.seats.domain.hibernate.client;
import java.io.Serializable;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核平台V1.0  
 * 类描述 : 	标签定义类
 * @version 1.0
 * @since: 	2015-5-25
 * @author 	梁家豪
 * @serial:	2015-5-25
 */
public class Define implements Serializable{
	private static final long serialVersionUID = 3528167002625885527L;
	
	/**标签名称- 端口标签  */
	public static final String  DICTIONARY_LABEL_NAME_PORT="XF003301";
		
	/**标签名称- 内容标签 */
	public static final String  DICTIONARY_LABEL_NAME_CONTENT="XF003302";
	
	/**标签名称- 行为标签  */
    public static final String  DICTIONARY_LABEL_NAME_ACTION="XF003303";
    
    
    /**端口标签-端口投诉风险 */
    public static final String  DICTIONARY_LABEL_ID_PORT_RISK="XF003401";
    /**端口标签-端口近3个月投诉次数 */
    public static final String  DICTIONARY_LABEL_ID_PORT_CONMLAIN_TOTLE="XF003402";
    
    /**端口标签-号码离散度*/
    public static final String  DICTIONARY_LABEL_ID_PORT_MOBILE_DISCRETE="XF003403";
    
    /**端口标签-动机离散度*/
    public static final String  DICTIONARY_LABEL_ID_PORT_MOTIVE_DISCRETE="XF003404";

    /**内容标签-受众数量*/
    public static final String  DICTIONARY_LABEL_ID_CONTENT_MOBILE_TOTLE="XF003405";
    
    /**内容标签-动机分类*/
    public static final String  DICTIONARY_LABEL_ID_CONTENT_MOTIVE_CLASS="XF003406";
    
    /**内容标签-敏感词*/
    public static final String  DICTIONARY_LABEL_ID_CONTENT_SENSITIVE_WORD="XF003407";
    
    /**内容标签-相识度标示符*/
    public static final String  DICTIONARY_LABEL_ID_CONTENT_SIMILAR_ID="XF003408";
    
    /**行为标签-投诉号码个数*/
    public static final String  DICTIONARY_LABEL_ID_ACTION_COMPLAIN_TOTLE="XF003409";
    
}
