package com.mp100.risk.ap.seats.util;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.mp100.risk.ai.sms.service.appro.ApprovalStatusResult;
import com.mp100.risk.ai.sms.service.appro.ApprovalStatusService;

/**
 * ̬客户端连接dubbo操作类
 * @author 梁家豪
 *
 */
public class ClietnConnectDubbo {
	//服务接口
	private static ApprovalStatusService approvalStatusService = null;
	//上下文
	private static FileSystemXmlApplicationContext context = null;
	
	//返回结果
	private static ApprovalStatusResult result = null;
	
	static {
		      // spring 初始化
			 context = new FileSystemXmlApplicationContext(new String[] { RapParameter.DICTIONARY_PATH_PROVIDER });
			 context.start();
			// 获取远程服务接口
			 approvalStatusService = (ApprovalStatusService) context.getBean("statusService");

	}
	
	//发送到网关
	public static String  pushSms(String [] smsId, String status){
		result= new ApprovalStatusResult();
		result.setSmsId(smsId);
		result.setStatus(status);
		return approvalStatusService.doApprovalStatus(result);
	}

 

}
