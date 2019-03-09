package com.mp100.risk.ap.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.ParseException;
import com.uap.common.utils.DateUtils;
import com.uap.common.utils.LogUtils;

public class RapDateUtils {
	public static Calendar calendar = Calendar.getInstance(); 
	  

    /**
     * 获取某个月的第一天
     * @return
     * yyyyMMdd
     */
    public static String getFirstDay(){
    	SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
    	calendar.setTime(new Date());
    	calendar.add(Calendar.MONTH, -1);
    	calendar.set(Calendar.DAY_OF_MONTH, 1);
    	return  simple.format(calendar.getTime())+"";
    }
    
    /**
     * 获取某个月的最后一天
     * @return
     * yyyyMMdd
     */
    public static String getLastDay(){
    	SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
    	calendar.add(Calendar.MONTH,1);
		calendar.set(Calendar.DATE, 1);
		calendar.add(Calendar.DATE, -1);
    	return  simple.format(calendar.getTime())+"";
    }
    /**
     * 获取当前时间的前若干个月份
     * @return list
     * yyyyMM
     */
    public static List<String> getSomeMoth(int num){
    	SimpleDateFormat simple = new SimpleDateFormat("yyyyMM");
    	List<String> list = new ArrayList<String>();
    	for(int i=num;i>0;i--){
    		calendar.setTime(new Date());
    		calendar.add(Calendar.MONTH,-i);
    		list.add(simple.format(calendar.getTime()));
    	}
    	return list;
    }
    
    /**
     * 获取获取指定时间的月份
     * @param str
     * yyyyMM
     */
    public static String getYearMonth(String str){
		   SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
	    	try {
				Date date=sdf.parse(str);
				calendar.setTime(date);
				String month=sdf.format(calendar.getTime());
				return month;
			} catch (ParseException e) {
				LogUtils.error(e);
			}
			return null;
	    }
    /**
     * 获取获取指定时间的上一个月份
     * @param str
     * yyyyMM
     */
    public static String getOldYearMonth(String str){
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
    	try {
    		Date date=sdf.parse(str);
    		date.setMonth(date.getMonth()-1);
    		calendar.setTime(date);
    		String month=sdf.format(calendar.getTime());
    		return month;
    	} catch (ParseException e) {
    		LogUtils.error(e);
    	}
    	return null;
    }
    /**
     * 获取某月的第一天
     * @return
     * yyyyMMdd
     */
    public static String getFirstDaybyYearMonth(String yearMonth){
    	SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
    	try {
			calendar.setTime(DateUtils.parseYearMonth(Integer.parseInt(yearMonth)));
		} catch (NumberFormatException e) {
			LogUtils.error(e);
		} catch (ParseException e) {
			LogUtils.error(e);
		}
    	calendar.set(Calendar.DAY_OF_MONTH, 1);
    	return  simple.format(calendar.getTime())+"";
    }
}
