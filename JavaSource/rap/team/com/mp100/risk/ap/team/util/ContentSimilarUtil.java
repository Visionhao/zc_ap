package com.mp100.risk.ap.team.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mp100.risk.ap.seats.util.RapParameter;

/**
 * 简单模糊相识度算法
 */
public class ContentSimilarUtil {

	private static Map<Double, String> map = new HashMap<Double, String>();
	private static Map<String, String> mapConten = new HashMap<String, String>();
	
	//初始化内容list
   public  static void initContent(String membersId,String content){
		mapConten.put(membersId, content);
   }
	
	private static class WorkerThread extends Thread {

		String compareStr;
		String localStr = "";
		String key = "";
		double dou;

		@SuppressWarnings("unused")
		public WorkerThread() {
		}

		public WorkerThread(String localStr,String key,String compareStr) {
			this.localStr = localStr;
			this.compareStr = compareStr;
			this.key = key;
		}
		
		@Override
		public void run() {
			dou = ContentSimilarUtil.dice(localStr, compareStr);
			map.put(dou, key);
		}

		public double getDou() {
			return dou;
		}

	}

	private static List<char[]> bigram(String input) {
		ArrayList<char[]> bigram = new ArrayList<char[]>();
		for (int i = 0; i < (input.length() - 1); i++) {
			char[] chars = new char[2];
			chars[0] = input.charAt(i);
			chars[1] = input.charAt(i + 1);
			bigram.add(chars);
		}
		return bigram;
	}

	public static double dice(String input1, String input2) {
		List<char[]> bigram1 = bigram(input1);
		List<char[]> bigram2 = bigram(input2);
		List<char[]> copy = new ArrayList<char[]>(bigram2);
		int matches = 0;
		for (int i = bigram1.size(); --i >= 0;) {
			char[] bigram = bigram1.get(i);
			for (int j = copy.size(); --j >= 0;) {
				char[] toMatch = copy.get(j);
				if ((bigram[0] == toMatch[0]) && (bigram[1] == toMatch[1])) {
					copy.remove(j);
					matches += 2;
					break;
				}

			}

		}
		return (double) matches / (bigram1.size() + bigram2.size());
	}
    
	//根据内容进行和历史数据相似度匹配返回相似度标识
	public static String  similarMatching(String content) {
		
         int len = mapConten.size();
         String result="";
	     if(len > 0){
			WorkerThread[] threads = new WorkerThread[len];
			double max = Double.MIN_VALUE;
			int y=0;
			//开启多个线程来匹配内容的相似度
			for (String key : mapConten.keySet()) {
				threads[y] = new WorkerThread(content,key,mapConten.get(key));
				threads[y].start();
				y++;
		    }
		
			// 等待每个线程结束，然后求取最大值
			try {
				for (int i = 0; i < len; i++) {
					threads[i].join();
					max = Math.max(max, threads[i].getDou());
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			//大于等于0.9 代表相似 
			if(max >= RapParameter.DICTIONARY_SIMILAR_PRECISION){
				result = map.get(max);
				map.clear();
				mapConten.clear();
				
			}else{
				map.clear();
				mapConten.clear();
			}
	    }
	     return result;
	}    
}
