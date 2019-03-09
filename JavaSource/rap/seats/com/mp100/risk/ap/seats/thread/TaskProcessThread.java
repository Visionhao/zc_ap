package com.mp100.risk.ap.seats.thread;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import com.mp100.risk.ap.auditing.domain.hibernate.hbm.MobileSendCurrent;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.SmsSendBatchCurrent;
import com.mp100.risk.ap.auditing.domain.hibernate.hbm.SmsSendContent;
import com.mp100.risk.ap.seats.cache.AuditDataCachePool;
import com.mp100.risk.ap.seats.cache.TaskProcessCache;
import com.mp100.risk.ap.seats.domain.hibernate.client.AudienceDataParameter;
import com.mp100.risk.ap.seats.domain.hibernate.client.AuditDataParameter;
import com.mp100.risk.ap.seats.domain.hibernate.client.Define;
import com.mp100.risk.ap.seats.domain.hibernate.client.MachineDecide;
import com.mp100.risk.ap.seats.util.RapParameter;
import com.mp100.risk.ap.seats.util.SimilarUtil;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	任务分配-审批数据加工处理
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public class TaskProcessThread extends Thread{
	    private final static ReentrantReadWriteLock readWriterLock = new ReentrantReadWriteLock() ;
	    private final static Lock writeLock = readWriterLock.writeLock();
	    public void run(){
				while(true){
			       try {
			    	  writeLock.lock();
			    	  String similarId = "";
			    	  String mapKey="";
			    	  //获取任务池的key
			     	  Set<String> sets=AuditDataCachePool.getKeys();
			    	  if(ObjectUtils.isNotNull(sets)){
				    	  for (String key : sets) {
				    		  for (AuditDataParameter param : AuditDataCachePool.getAuditSmsList().get(key)) {
				    			//相似度匹配返回相似度标识
				      			similarId=SimilarUtil.similarMatching(param.getFilterContent());
				      			//key
				      			mapKey=param.getCustId()+":"+similarId;
				      		    //判断待分配的任务是否存储当前的key 如果存储则合并任务
				      			if(TaskProcessCache.containsTaskKey(mapKey)){
				      				List<SmsSendBatchCurrent> batchList=(List<SmsSendBatchCurrent>)TaskProcessCache.getBatchList(mapKey);
				      				batchList.add(getSendBatch(param,mapKey,1));
				      				TaskProcessCache.putBatch(mapKey,batchList);
				      			}else{
				      			    //初始化一些参数
				      			 	param.getDecideMap().put(Define.DICTIONARY_LABEL_ID_CONTENT_SIMILAR_ID,getMachineDecide(Define.DICTIONARY_LABEL_NAME_CONTENT,Define.DICTIONARY_LABEL_ID_CONTENT_SIMILAR_ID,similarId));
				      			 	//将参数添加到任务map中
				      			 	TaskProcessCache.putTask(mapKey, param);
				      			 	
				      			 	//将批次流水添加到流水map中
				      				List<SmsSendBatchCurrent> batchList=new ArrayList<SmsSendBatchCurrent>();
				      				batchList.add(getSendBatch(param,mapKey,0));
				      				TaskProcessCache.putBatch(mapKey,batchList);
				      			}
				  			 }
				    		  
				    		  //减任务池数量
				    		  AuditDataCachePool.setPoolTotle(AuditDataCachePool.getAuditSmsList().get(key).size());
				    		  //处理完成删除任务池对应的数据
				    		  AuditDataCachePool.removeTask(key);
						  }
			    	  } 
					  Thread.sleep(RapParameter.DICTIONARY_TIME_TASK_PROCESS);
					} catch (InterruptedException e) {
						LogUtils.error("审批数据加工处理线程出错", e);
				    }finally{
						writeLock.unlock() ;
					}
			    	
				}
		}
	    
	
	    
	    //封装批次流水  type:0 代表不存在同客户同相似的短信     type:1 存在同客户同相似的短信
	    public SmsSendBatchCurrent getSendBatch(AuditDataParameter param,String key,int type){
	    	//号码总量
	    	int mobileTotle=0;
	    	//封装批次信息
	    	SmsSendBatchCurrent batch=new SmsSendBatchCurrent();
	    	batch.setCustomerId(param.getCustId());
	    	batch.setSubmitTime(param.getSubmitTime());
	    	batch.setBatchStatus("01");
	    	batch.setDownPort(param.getPort());
	    	batch.setInterFaceId(param.getSmsId());
	    	
	    	//封装短信正文
	    	SmsSendContent contentBean = new SmsSendContent();
	    	contentBean.setSmsContent(param.getContent());
	    	batch.setContentBean(contentBean);
	    	
	    	//批次号码处理和封装
	    	List<MobileSendCurrent> mobileList = new ArrayList<MobileSendCurrent>();
	    	
	    	
	    	if(type==0){
	    		mobileTotle=param.getAudienceList().size();
		    }else{//合并任务的数量也要增加
	    		mobileTotle=Integer.parseInt(TaskProcessCache.getAudit(key).getDecideMap().get(Define.DICTIONARY_LABEL_ID_CONTENT_MOBILE_TOTLE).getReason());
	    		mobileTotle=mobileTotle+param.getAudienceList().size();
		    }
	    	MobileSendCurrent mobile = null;
	    	for (AudienceDataParameter audience : param.getAudienceList()) {
	    		mobile=new MobileSendCurrent();
	    		mobile.setPhoneNum(audience.getMobile());
	    		mobileList.add(mobile);
			}
	    	batch.setMobileList(mobileList);
    		//添加统计后的机器辅助信息  号码总量  省数量 地市数量 
	    	TaskProcessCache.getAudit(key).getDecideMap().put(Define.DICTIONARY_LABEL_ID_CONTENT_MOBILE_TOTLE,getMachineDecide(Define.DICTIONARY_LABEL_NAME_CONTENT,Define.DICTIONARY_LABEL_ID_CONTENT_MOBILE_TOTLE,String.valueOf(mobileTotle)));
	    	return batch;
	    }
	    
	    //封装机器辅助信息 
	    public MachineDecide getMachineDecide(String labelName,String labelId,String reason){
	    	MachineDecide bean=new MachineDecide();
	    	bean.setLabelName(labelName);
	    	bean.setLabelId(labelId);
	    	bean.setReason(reason);
	    	return bean;
	    }
	    
}
