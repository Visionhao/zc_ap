package com.mp100.risk.ap.seats.util;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
/**
 * Description: dubbo alibaba 的开源服务框架，通过集成dubbo实现服务的远程调用，以及负载均衡和失败恢复
 * 由于dubbo扩展了spring内核，所以启动dubbo，也就是初始化一个spring配置
 * 
 * @author 梁家豪
 * @version 1.0
 * @since 2015-6-01
 */
public class DubboComponet{
	// spring的上下文
	private static FileSystemXmlApplicationContext context;

	public static void start() {
		try {
			if(ObjectUtils.isNull(context)){
				context = new FileSystemXmlApplicationContext(new String[] {RapParameter.DICTIONARY_PATH_PROVIDER });
				context.start();
				LogUtils.info("启动dubbo服务:"+context);
			}
		} catch (Exception e) {
			LogUtils.error(e);
		}
		
	}

	public static void stop() {
		try {
			if (context != null) {
				context.stop();
				context.close();
				context = null;
			}
		} catch (Exception e) {
			LogUtils.error(e);
		}

	}
}
