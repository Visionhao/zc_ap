package com.mp100.risk.ap.seats.listener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.mp100.risk.ap.seats.thread.AutoAuditThread;
import com.mp100.risk.ap.seats.thread.DivideTaskThread;
import com.mp100.risk.ap.seats.thread.TaskProcessThread;
import com.mp100.risk.ap.seats.util.DubboComponet;
import com.mp100.risk.ap.team.thread.ComplaintsBackThread;
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核 v1.0 
 * 类描述 : 	线程监听器 
 * @version 1.0
 * @since: 	2015-05-23
 * @author 	梁家豪
 * @serial:	2015-05-23
 */
public class ThreadListener implements ServletContextListener{
     private DivideTaskThread  divideTaskThread;
     private TaskProcessThread taskProcessThread;
     private ComplaintsBackThread complaintsBackThread;
     private AutoAuditThread autoAuditThread;
     
	@Override
	public void contextDestroyed(ServletContextEvent e) {
		if (divideTaskThread != null && divideTaskThread.isInterrupted()) {  
			divideTaskThread.interrupt();  
        } 
		if (taskProcessThread != null && taskProcessThread.isInterrupted()) {  
			taskProcessThread.interrupt();  
        } 
		if (complaintsBackThread != null && complaintsBackThread.isInterrupted()) {  
			complaintsBackThread.interrupt();  
		} 
		if (autoAuditThread != null && autoAuditThread.isInterrupted()) {  
			autoAuditThread.interrupt();  
		} 
	}

	@Override
	public void contextInitialized(ServletContextEvent e) {
        if ( divideTaskThread == null) {  
        	divideTaskThread = new DivideTaskThread();  
        	divideTaskThread.start(); // 启动任务分配线程  
        }  
        if ( taskProcessThread == null) {  
        	taskProcessThread = new TaskProcessThread();  
        	taskProcessThread.start(); // 启动任务分配线程  
        } 
        if ( complaintsBackThread == null) {  
        	complaintsBackThread = new ComplaintsBackThread();  
        	complaintsBackThread.start(); // 启动任务分配线程  
        } 
        if ( autoAuditThread == null) {  
        	autoAuditThread = new AutoAuditThread();  
        	autoAuditThread.start(); // 启动任务分配线程  
        } 
        DubboComponet.start();
	}

}
