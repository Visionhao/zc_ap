package com.mp100.risk.ap.team.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import jxl.Sheet;
import jxl.Workbook;

import com.mp100.risk.ap.team.domain.hibernate.hbm.ComplainContent;
import com.mp100.risk.ap.team.service.IComplaintService;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.domain.dao.IBaseDao;

public class ComplaintServiceImpl implements IComplaintService{
	
	/**
	 * ===================================================================* 
	 * 进行 【人工审核.投诉回溯】 功能模块的添加数据操作。
	 * ====================================================================
	 */
	@Override
	public List<ComplainContent> complainContent(List<ComplainContent> comList) {
		List<ComplainContent> list=new ArrayList<ComplainContent>();
		for (ComplainContent complain : comList) {
			ComplainContent com =new ComplainContent();
			com.setComplainPhone(complain.getComplainPhone());
			com.setComplainPort(complain.getComplainPort());
			com.setComplainContent(complain.getComplainContent());
			com.setComplainDate(complain.getComplainDate());
			com.setBackTrace("00");
			list.add(com);
		}
		return list;
	}

	/**
	 * ===================================================================* 
	 * 进行 【人工审核.投诉回溯】 功能模块的保存数据操作。
	 * ====================================================================
	 */
	@Override
	public void add(List<ComplainContent> list) {
		IBaseDao baseDao=(IBaseDao)AppContextUtils.getBean(IBaseDao.class.getName());
		baseDao.save(list);
	}

	/**
	 * ===================================================================* 
	 * 进行 【人工审核.投诉回溯】 功能模块的读取excel操作。
	 * ====================================================================
	 */
	@Override
	public List<ComplainContent> readUserExcelFile(File file) {
		int column;  
        String temp=null;  
        Workbook book =null;  
        Sheet sheet=null;  
       
        
        List<ComplainContent> comList=new ArrayList<ComplainContent>();  
        try {
			book = Workbook.getWorkbook(file);
		} catch (Exception e) {
			e.printStackTrace();
		}  
        
        sheet = book.getSheet(0);  
        for(int row = 1;row<sheet.getRows();row++){  
            column=0;  
            ComplainContent com = new ComplainContent();  
            com.setComplainId(String.valueOf(row)); 
            
            temp=sheet.getCell(column++,row).getContents().trim(); 
            //com.setComplainPhone(temp);
            if(temp.length()<8){
            	com.setComplainPhone(temp);
            }else{
            	com.setComplainPhone(temp);
            }
            
            temp=sheet.getCell(column++,row).getContents().trim();
            if(temp.indexOf(".") != -1){
            	String temps = temp.substring(0,temp.indexOf("."));
            	com.setComplainPort(temps);
            }else{
            	com.setComplainPort(temp);
            }
            
            temp=sheet.getCell(column++,row).getContents().trim();
            
            com.setComplainContent(temp);
           
            temp=sheet.getCell(column++,row).getContents().trim();  
            try {
            	if(temp.indexOf(".") != -1){
            		String tempSub = temp.substring(0,temp.indexOf("."));
            		com.setComplainDate(tempSub);
            	}else{
            		com.setComplainDate(temp);
            	}
            } catch (Exception e) {
            	e.printStackTrace();
            }
            comList.add(com);
        }  
        if(book!=null) book.close();  
        return comList;  
    }
	
	/**
	 * ===================================================================* 
	 * 进行 【人工审核.投诉回溯】 功能模块的验证读取读取excel操作。
	 * ====================================================================
	 */
	@Override
	public String readUserExcelFileVerify(File file) {
		int error=0;
        int correct=0;
        String temp=null;  
        Workbook book =null;  
        Sheet sheet=null;
        int count=0;
        String regex = "^[1-9]\\d*$";
        String date = "^(\\d{4})-(0\\d{1}|1[0-2])-(0\\d{1}|[12]\\d{1}|3[01]) (0\\d{1}|1\\d{1}|2[0-3]):([0-5]\\d{1}):([0-5]\\d{1}).0$";
		//String date ="^([0][1-9]|(1[0-2]))[/]([1-9]|([012]\\d)|(3[01]))[/](\\d{2})([ \\t\\n\\x0B\\f\\r])([0-1]?[0-9]|2[0-3])([:])(([0-5]{1}[0-9]{1}|[6]{1}[0]{1}))$";
        try {
			book = Workbook.getWorkbook(file);
		} catch (Exception e) {
			e.printStackTrace();
		}  
        sheet = book.getSheet(0);  
        if(sheet.getColumns()!=4){
       	 	return "列数不对,列数只能是4列";
        }else if(sheet.getRows()>1001){
        	return "导入的数据不能超过1000条";
        }else if(sheet.getRows()<2){
        	return "必须要导入一行数据进行分析";
        }
        count=sheet.getRows();
        for(int row = 1;row<count;row++){  
            for(int column=0;column<4;column++){
            	    temp=sheet.getCell(column,row).getContents().trim(); 
		            if(ObjectUtils.isNull(temp) && column!=3 && temp.matches(date)){
		            	error++;
		            	break;
		            }else if(column==0 && !temp.matches(regex)){
		            	error++;
		            	break;
		            }else if(column==1 && !temp.matches(regex)){
		            	error++;
		            	break;
		            }
            }
       }
        book.close();  
        correct = (count-1)-error;
        return (count-1)+"-"+correct+"-"+error;  
	}
	
	/**
	 * ===================================================================*
	 * 进行 【人工审核.投诉回溯】 的文件上传之后保存操作。
	 * ====================================================================
	 */
	public String save(File file){
		IComplaintService complaintService = (IComplaintService) AppContextUtils.getBean(IComplaintService.class.getName());
		List<ComplainContent> comlist = complaintService.readUserExcelFile(file);
		List<ComplainContent> listContent = complaintService.complainContent(comlist);
		complaintService.add(listContent);
		comlist.clear();
		return "save";
	}
}
