package com.mp100.risk.ap.team.web.action;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.mp100.risk.ap.team.domain.hibernate.dv.ComplainContentView;
import com.mp100.risk.ap.team.domain.hibernate.dv.ComplainantView;
import com.mp100.risk.ap.team.domain.hibernate.dv.MembersView;
import com.mp100.risk.ap.team.service.IComplaintService;
import com.mp100.risk.ap.util.RapDateUtils;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.service.IDaoService;
import com.uap.core.web.jmesa.action.BaseJmesaAction;

/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核平台 v1.0 
 * 类描述 : 	人工审批-投诉回溯Action类
 * @version 1.0
 * @since: 	2015-05-21
 * @author 	吴文浩
 * @serial:	2015-05-21
 */
public class ComplaintsBackAction  extends BaseJmesaAction{

	private static final long serialVersionUID = 1L;
	private File[] file;
	private String[] fileName;
	private String path;	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.投诉回溯】模块的主页面。
	 * ====================================================================
	 */
	public String main(){
		return successView;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.投诉回溯】模块的主页面。
	 * ====================================================================
	 */
	public String auditList(){
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,List<String>> map = new HashMap<String,List<String>>();
		map.put("QD_months", RapDateUtils.getSomeMoth(6));
		List<ComplainantView> complainantList = (List<ComplainantView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryComplainantViewDV", map);
		List<MembersView> membersViewList = (List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersComplaintDV", new HashMap());
		List<ComplainantView> complainantSum = (List<ComplainantView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.querySumDV", map);
		
		if(ObjectUtils.isNotNull(complainantList)){
			getRequest().setAttribute("complainantList", complainantList);
			getRequest().setAttribute("complainantSum", complainantSum);
			getRequest().setAttribute("count", complainantList.size());
			getRequest().setAttribute("membersViewList", membersViewList);
			getRequest().setAttribute("counts", membersViewList.size());
		}
		
		return successView;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.投诉回溯】模块的投诉详细主页面。
	 * ====================================================================
	 */
	public String detailMain(){
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,String> map = new HashMap<String,String>();
		Map<String,List<String>> maps = new HashMap<String,List<String>>();
		List<String> QD_months = RapDateUtils.getSomeMoth(6);	
		maps.put("QD_months", QD_months);
		
		map.put("QD_month", getRequest().getParameter("QD_month"));
		map.put("QT_membersId", getRequest().getParameter("QT_membersId"));
		List<ComplainContentView>  complainContentList=  (List<ComplainContentView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryComplainContentViewDV", map);
		List<MembersView> membersList = (List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersComplaintDV", new HashMap());
		List<ComplainantView> detailSum = (List<ComplainantView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.querySumDV", maps);
		
		getRequest().setAttribute("detailSum", detailSum);
		getRequest().setAttribute("membersList", membersList);
		getRequest().setAttribute("QD_month", getRequest().getParameter("QD_month"));
		getRequest().setAttribute("QT_membersId", getRequest().getParameter("QT_membersId"));
		getRequest().setAttribute("QD_months", QD_months);
		return successView;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.投诉回溯】模块的投诉详细列表。
	 * ====================================================================
	 */
	public String detailList(){
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,String> map = new HashMap<String,String>();
		
		if(ObjectUtils.isNotNull(getRequest().getParameter("QT_mobile"))) map.put("QT_mobile","%"+getRequest().getParameter("QT_mobile")+"%");
		if(ObjectUtils.isNotNull(getRequest().getParameter("QT_port"))) map.put("QT_port","%"+getRequest().getParameter("QT_port")+"%");
		if(ObjectUtils.isNotNull(getRequest().getParameter("QT_content"))) map.put("QT_content",  "%"+getRequest().getParameter("QT_content")+"%");
		if(ObjectUtils.isNotNull(getRequest().getParameter("QD_month"))) map.put("QD_month", getRequest().getParameter("QD_month"));
		map.put("QT_membersId", getRequest().getParameter("QT_membersId"));
		List<ComplainContentView> list = (List<ComplainContentView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryComplainContentViewDV",map);

		getRequest().setAttribute("QT_mobile", getRequest().getParameter("QT_mobile"));
		getRequest().setAttribute("QT_port", getRequest().getParameter("QT_port"));
		getRequest().setAttribute("QT_content", getRequest().getParameter("QT_content"));
		getRequest().setAttribute("QD_month", getRequest().getParameter("QD_month"));
		getRequest().setAttribute("QT_membersId", getRequest().getParameter("QT_membersId"));
		getRequest().setAttribute("object_items", list);
		return "detailList";
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.投诉回溯】模块投诉内容模式的主页面。
	 * ====================================================================
	 */
	public String contentMain(){
		List<String> months = RapDateUtils.getSomeMoth(6);	
		getRequest().setAttribute("months", months);
		getRequest().setAttribute("QD_month", months.get(months.size()-1));
		Collections.reverse(months);
		return successView;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.投诉回溯】模块投诉内容模式的列表界面。
	 * ====================================================================
	 */
	public String contentList(){
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,String> map = new HashMap<String,String>();
		if(ObjectUtils.isNotNull(getRequest().getParameter("QT_mobile"))) map.put("QT_mobile","%"+getRequest().getParameter("QT_mobile")+"%");
		if(ObjectUtils.isNotNull(getRequest().getParameter("QT_port"))) map.put("QT_port","%"+getRequest().getParameter("QT_port")+"%");
		if(ObjectUtils.isNotNull(getRequest().getParameter("QT_content"))) map.put("QT_content","%"+getRequest().getParameter("QT_content")+"%");
		map.put("QD_month",getRequest().getParameter("QD_month"));
		List<ComplainContentView> contentList = (List<ComplainContentView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryComplainContentListViewDV",map);
		
		getRequest().setAttribute("QT_mobile", getRequest().getParameter("QT_mobile"));
		getRequest().setAttribute("QT_port", getRequest().getParameter("QT_port"));
		getRequest().setAttribute("QT_content", getRequest().getParameter("QT_content"));
		getRequest().setAttribute("QD_month", getRequest().getParameter("QD_month"));
		getRequest().setAttribute("object_items", contentList);
		return "contentList";
	}
	
	/**
	 * ===================================================================*
	 * 上传文件； 进行 【人工审核.投诉回溯】 的文件上传操作。
	 * ====================================================================
	 */
	public String upload(){
		// 获取文件路径  
		String dir = ServletActionContext.getServletContext().getRealPath("/files");
		deletefile(dir);
		
		File target = null;
		try {
			for(int i = 0; i < file.length; i++){
				target = new File(dir,fileName[i]);
				FileUtils.copyFile(file[i], target);
				dir+="/"+fileName[i];
			}
		} catch (IOException e) {
			LogUtils.error(e);
		}
		fileList();
		
		File file = new File(dir);
		getRequest().getSession().setAttribute("path",file);
		IComplaintService complaintService = (IComplaintService) AppContextUtils.getBean(IComplaintService.class.getName());
		String str = complaintService.readUserExcelFileVerify(file);
		complaintService.save(file);
		if(str.split("-").length==3){
			getRequest().setAttribute("str", "总共导入的数据有"+str.split("-")[0]+"条。有效的有："+str.split("-")[1]+"条。无效的有："+str.split("-")[2]+"条。");
		}else{
			getRequest().setAttribute("str", str);
		}
		return successView;
	}
	
	/**
	 * ===================================================================*
	 * 列表显示； 进行 【人工审核.投诉回溯】 的文件列表展示操作。
	 * ====================================================================
	 */
	public String fileList(){
		String dir = ServletActionContext.getServletContext().getRealPath("/files");
		List<String> files = new ArrayList<String>();
		File root = new File(dir);
		File[] fs = root.listFiles();
		
		for(File f : fs){
			if(f.isFile()){
				String fileName = f.getName();
				files.add(fileName);
			}else{
				fileList();
			}
		}
		getRequest().setAttribute("files", files);
		getRequest().setAttribute("path", dir);
		return null;
	}
	
	/**
	 * ===================================================================*
	 * 清空列表； 进行 【人工审核.投诉回溯】 的文件列表清空操作。
	 * ====================================================================
	 */
	public boolean deletefile(String delpath){ 
		try{ 
		    File file = new File(delpath);
		    /* 如果是文件  */
			if(!file.isDirectory()){ 
			            file.delete(); 
			  }else if(file.isDirectory()){  /* 如果是文件夹  */ 
			        String[] filelist = file.list(); 
			        /* 遍历所有文件夹中文件  */
					for(int i = 0; i < filelist.length; i++) { 
					   File delfile = new File(delpath + "\\" + filelist[i]); 
					   	/* 如果是文件  */
						if(!delfile.isDirectory()){ 
							delfile.delete(); 
						}else if(delfile.isDirectory()){ /* 如果是文件夹  */
								  deletefile(delpath + "\\" + filelist[i]); 
						} 
					} 
					file.delete(); 
			  } 
		}catch (Exception e) { 
		    LogUtils.error(e); 
		} 
			return true; 
		}

	public File[] getFile() {
		return file;
	}
	public void setFile(File[] file) {
		this.file = file;
	}

	public String[] getFileFileName() {
		return fileName;
	}
	public void setFileFileName(String[] fileFileName) {
		this.fileName = fileFileName;
	}

	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
}
