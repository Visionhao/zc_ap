package com.mp100.risk.ap.team.service;

import java.io.File;
import java.util.List;

import com.mp100.risk.ap.team.domain.hibernate.hbm.ComplainContent;

public interface IComplaintService {

	/**
	 * ===================================================================* 
	 * 进行 【人工审核.投诉回溯】 功能模块的添加数据操作。
	 * ====================================================================
	 */
	public List<ComplainContent> complainContent(List<ComplainContent> messList);
	
	/**
	 * ===================================================================* 
	 * 进行 【人工审核.投诉回溯】 功能模块的保存数据操作。
	 * ====================================================================
	 */
	public void add(List<ComplainContent> list);
	
	/**
	 * ===================================================================* 
	 * 进行 【人工审核.投诉回溯】 功能模块的读取excel操作。
	 * ====================================================================
	 */
	public  List<ComplainContent> readUserExcelFile(File file);
	
	/**
	 * ===================================================================* 
	 * 进行 【人工审核.投诉回溯】 功能模块的验证读取读取excel操作。
	 * ====================================================================
	 */
	public String readUserExcelFileVerify(File file);
	
	/**
	 * ===================================================================*
	 * 进行 【人工审核.投诉回溯】 的文件上传之后保存操作。
	 * ====================================================================
	 */
	public String save(File file);
}
