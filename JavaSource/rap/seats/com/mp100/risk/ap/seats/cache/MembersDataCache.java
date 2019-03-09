package com.mp100.risk.ap.seats.cache;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.mp100.risk.ap.seats.domain.hibernate.hbm.TaskDivide;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	任务分配-成员数据管理器
 * @version 1.0
 * @since: 	2015-04-29
 * @author 	梁家豪
 * @serial:	2015-04-29
 */
public class MembersDataCache {
	 /*** 成员任务**/
	private static List<TaskDivide>  membersList=new ArrayList<TaskDivide>();
	/*** 当前所有成员任务量**/
	private static Map<Integer,Integer>  workLoad = new HashMap<Integer,Integer>();
	/*** 用于计算当前取的成员索引**/
    private static int  membersIndex=-1;
    
    /*** 获取当前要分配索引**/
  	public static int getTaskIndex(){
  		//判断成员当前这一轮工作量是否完成（就是成员全部任务量为0就完成一轮 ）
  		if(isComplete()){
  			//进行复原工作量
  			resetWordLoad();
  			if(membersList.size() <= 0){
  				return -1;
  			}
  			membersIndex = 0;
  		}else if(membersIndex >= getMemberTotle()-1){//大于最后索引还原索引为0
				membersIndex = 0;
		}else{//找到工作量不等于0的成员
  			membersIndex++;
  			while(membersIndex < getMemberTotle()){
  				//可能由于同步问题导致暂时为0
  				if(membersList.size() == 0  || workLoad.size()== 0 || membersList.size()!= workLoad.size()){
  					return -1;
  				}
  				//判断是最后最后一位的时候没找到然后重新找索引0开始
  				if(membersIndex >= getMemberTotle()){
  					membersIndex = 0;
  				}
  				//判断成员是否下线（同步）
  				if(membersList.size() == 0  || workLoad.size()== 0 || membersList.size()!= workLoad.size()){
	  				return -1;
  				}else{
  					//找到工作量>0 返回索引
	  				if(workLoad.get(membersIndex) > 0){
						return membersIndex;
					}
  				}
  				membersIndex++;
  			}
  			
  		}
  		return membersIndex;
  	}
  	
  	/***根据索引获取当前要分配的成员**/
  	public static boolean isComplete(){
  		for (int i = 0; i < getMemberTotle(); i++) {
  		  if(workLoad.size() > 0){	
	  			if(workLoad.get(i) > 0){
	  				return false;
	  			}
  		  }
  		}
  		return true;
  	}
  	/***根据索引获取当前要分配的成员**/
  	public static TaskDivide getAlMemberl(int index){
  		return membersList.get(index);
  	}
  	
  	/***根据索引获取工作量**/
  	public static int getWordLoad(int index){
  		return  workLoad.get(index);
  	}
  	
  	/***减少当前成员当前这一轮已经分配的工作量**/
  	public static void reduceWordLoad(int key){
  		workLoad.put(key,workLoad.get(key)-1);
  	}

	/***清空	缓存成员列表**/
  	public static void clearMembersList(){
  		membersList.clear();
  	}
  	
  	/***清空	缓存当前所有成员任务量列表**/
  	public static void clearWordLoadList(){
  		workLoad.clear();
  	}
  	
	/***成员索引付值**/
	public static void setMembersIndex(int membersIndex) {
		MembersDataCache.membersIndex = membersIndex;
	}
	
	/***成员任务按量分配完成一轮工作量进行复原工作量**/
	public static void resetWordLoad(){
		int count=membersList.size();
		for(int i=0; i< count ;i++){
			workLoad.put(i, membersList.get(i).getWorkLoad());
		}
	}
	
	/***获取成员数量**/
	public static int getMemberTotle(){
		return membersList.size();
	}
  	
	/***给当前成员任务量添加数据**/
	public static void putWorkLoad(int key,int value){
		workLoad.put(key, value);
	}
	/***添加成员任务**/
	public static void putMembers(TaskDivide taskDivide){
		membersList.add(taskDivide);
	}
}
