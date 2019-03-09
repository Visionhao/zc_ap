package com.mp100.risk.ap.seats.util;
import java.util.UUID;

public class UuidUtils {
	//获取UUID
	public static String getUuid(){
		String uuid = UUID.randomUUID().toString();
		 // 转换为大写
		uuid= uuid.toUpperCase();
		// 替换 -
		return  uuid= uuid.replaceAll("-", "");
	}
	
	public static void main(String[] args) {
		System.out.println(UuidUtils.getUuid());
	}
}
