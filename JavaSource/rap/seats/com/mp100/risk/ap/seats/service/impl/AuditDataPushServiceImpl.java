package com.mp100.risk.ap.seats.service.impl;
import java.util.List;
import com.mp100.risk.ap.seats.cache.AuditDataCachePool;
import com.mp100.risk.ap.seats.domain.hibernate.client.AuditDataParameter;
import com.mp100.risk.ap.seats.service.IAuditDataPushService;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	人工审批-审批数据推送接口
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public class AuditDataPushServiceImpl implements IAuditDataPushService{
   /** 审批任务推送 */
   public int auditDataPush(List<AuditDataParameter> auditSmsList) throws Exception{
		   return AuditDataCachePool.putAuditSmsList(auditSmsList);
   }
}
