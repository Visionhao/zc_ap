package com.mp100.risk.ap.seats.cache;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import com.mp100.risk.ap.seats.domain.hibernate.client.AuditDataParameter;
import com.mp100.risk.ap.seats.util.UuidUtils;
import com.uap.common.utils.LogUtils;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	任务分配-审批数据缓存池管理器
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public class AuditDataCachePool {

	//定义一个map 作为短信缓存任务池
    private static Map<String, List<AuditDataParameter>> smsPool = new ConcurrentHashMap<String, List<AuditDataParameter>>();  
    
    // 读写锁
    private final static ReentrantReadWriteLock readWriterLock = new ReentrantReadWriteLock() ;
    private final static Lock writeLock = readWriterLock.writeLock();
    
    private volatile static int poolTotle=0;
    //向池里放任务
    public  static synchronized int  putAuditSmsList(List<AuditDataParameter> auditSmsList){
    	 writeLock.lock();
    	try{
    		if(poolTotle <= 1000 ){
      		  poolTotle += auditSmsList.size();
    		  smsPool.put(getKey(), auditSmsList);
    		  LogUtils.info(poolTotle+":当前成功推送审批短信数量："+auditSmsList.size());
    		  return 0;
    		}else{
    			LogUtils.info("当前短信缓存池已满,数量为："+poolTotle);
    			return 1;
    		}
    		
    	}catch (Exception e) {
    		LogUtils.error("当前服务推送短信缓存池失败", e);
    		return 2;
		}finally{
			  writeLock.unlock() ;
		}
    	
    }
    
    
	//向池里取任务
	public static Map<String, List<AuditDataParameter>> getAuditSmsList(){
		return smsPool;
	}
    
	//根据key往缓存里面删除对应数据
	public static synchronized void  removeTask(String key){
		smsPool.remove(key);
	}
	
	//获取所有的key
	public static Set<String> getKeys(){
		return smsPool.keySet();
	}
	
	
	//key的格式为（ddHHmmssms）天到毫秒 然后拼接前5位uuid
	private static String getKey(){
		SimpleDateFormat df = new SimpleDateFormat("ddHHmmssms");
		Date date=new Date();
		return df.format(date)+UuidUtils.getUuid().substring(2,7);
	}
	
	//减少池中审批短信的数量
	public static void setPoolTotle(int count){
		poolTotle = poolTotle-count;
	}
}
