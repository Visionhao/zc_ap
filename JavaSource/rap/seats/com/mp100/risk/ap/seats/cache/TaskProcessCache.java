package com.mp100.risk.ap.seats.cache;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import com.mp100.risk.ap.auditing.domain.hibernate.hbm.SmsSendBatchCurrent;
import com.mp100.risk.ap.seats.domain.hibernate.client.AuditDataParameter;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	任务分配-任务处理缓存（用于缓存处理后和合并后的任务和流水信息）
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public class TaskProcessCache {
	    /*** 任务buff**/
	    private static Map<String, AuditDataParameter> taskMap = new ConcurrentHashMap<String, AuditDataParameter>();  
	    /*** 批次流水buff**/
	    private static Map<String, List<SmsSendBatchCurrent>> batchMap = new ConcurrentHashMap<String, List<SmsSendBatchCurrent>>();  
	    
	    
	   /*** 添加任务**/
	   public static synchronized void putTask(String key,AuditDataParameter auditDataParameter){
		   taskMap.put(key, auditDataParameter);
	   }
	   /*** 获取任务**/
	   public static AuditDataParameter getAudit(String key){
		  return taskMap.get(key);
	   }
	   /*** 根据key删除任务**/
	  public static synchronized void  removeAudit(String key){
			   taskMap.remove(key);
	  }
	   /*** 清空任务**/
	  public static synchronized void  clearTaskMap(String key){
		   taskMap.clear();
      }
	  
	  /*** 判断任务key是否已存在**/
	  public static Boolean containsTaskKey(String key){
		  return taskMap.containsKey(key);
      }
	  
	  /*** 获取当前所有任务key**/
	  public static Set<String> taskKeys(){
		  return taskMap.keySet();
	  }
	  
	  
	  /*** 添加批次流水*/
	   public static synchronized void putBatch(String key,List<SmsSendBatchCurrent> list){
		   batchMap.put(key, list);
	   }
	   /*** 获取批次流水**/
	   public static List<SmsSendBatchCurrent> getBatchList(String key){
		  return batchMap.get(key);
	   }
	   /*** 根据key删除批次流水**/
	   public static synchronized void removeBatch(String key){
		   batchMap.remove(key);
	  }
	   /*** 清空批次流水**/
	  public static void clearBatchMap(String key){
		  batchMap.clear();
      }
	  
	  /*** 判断批次流水key是否已存在**/
	  public static Boolean containsBatchKey(String key){
		  return batchMap.containsKey(key);
      }
	  
	  /*** 获取当前所有批次流水key**/
	  public static Set<String> batchKeys(){
		  return batchMap.keySet();
	  }
	   
}
