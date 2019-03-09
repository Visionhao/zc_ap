package com.mp100.risk.ap.home.web.action;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.mp100.risk.ap.team.domain.hibernate.dv.MembersView;
import com.mp100.risk.ap.team.domain.hibernate.hbm.Members;
import com.mp100.risk.ap.team.domain.hibernate.hbm.MembersPicture;
import com.mp100.risk.ap.team.service.IMemberService;
import com.mp100.risk.ap.util.RapParameter;
import com.opensymphony.xwork2.Action;
import com.uap.common.util.massgeUtils;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.core.service.IDaoService;
import com.uap.core.web.jmesa.action.BaseJmesaAction;

public class MemberLoginAction extends BaseJmesaAction{

	private static final long serialVersionUID = 1L;
	
	private File file;
	/* 需要上传的文件的文件名  */
	private String fileName;

	/**
	 * ===================================================================* 
	 * 进入 【人工审核平台.登录】的操作
	 * ====================================================================
	 * 
	 */
	public String membersLogin(){
		boolean flag = false;
		String memberName = getRequest().getParameter("QT_chnName");
		String passWord = getRequest().getParameter("QT_passWord");
		IDaoService daoService = (IDaoService) AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,String> map=new HashMap<String,String>();
		map.put("QT_chnName", memberName);
		map.put("QT_passWord", passWord);
		List<MembersView> memberList = (List<MembersView>)daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersLoginViewDV", map);
		
		if(ObjectUtils.isNotNull(memberList)){
			MembersView membersView=memberList.get(0);
			getSession().setAttribute(RapParameter.DICTIONARY_LOGIN_INFO, membersView);	
			getSession().setAttribute("membersView",membersView);	
			getSession().setAttribute("memberName",membersView.getChnName());
			getSession().setAttribute("Login", "loginSucceed();");
			flag = true;
		}
		massgeUtils.massge(flag);
		return Action.NONE;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核平台.修改成员信息】的界面
	 * ====================================================================
	 * 
	 */
	public String editMember(){
		MembersView membersSession=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);	
	    return "editMember";
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的修改上传图片操作。
	 * ====================================================================
	 * 
	 */
	public String upload(){
		getResponse().setContentType("application/text;charset=UTF-8");
		 //获取文件路径  
		String dir = ServletActionContext.getServletContext().getRealPath("/files");
		String tempPath = ServletActionContext.getServletContext().getRealPath("/view/files");
		deletefile(dir);
		File target = new File(dir,fileName);
		File tempFile = new File(tempPath,fileName);
		boolean tag = false;
		String mass = "";
		try {
			FileUtils.copyFile(file, tempFile);
			BufferedImage buff = ImageIO.read(tempFile);
			if(tempFile.length() > 1024*2*1024){
				mass = "上传的文件太大！";
			}else if(!tempFile.getName().endsWith(".jpg") && !tempFile.getName().endsWith(".png") && !tempFile.getName().endsWith(".gif") ){
				mass = "上传的图片格式不对！";
			}else if(buff.getWidth() > 80 || buff.getHeight() > 80){
				mass = "上传的图片高度和宽度不对！";
			}else{
				FileUtils.copyFile(file, target);
				deletefile(tempPath);
				tag = true;
				mass = "";
			}
		} catch (IOException e) {
			LogUtils.error(e);
		}
		String path =null;
		if(tag){
			path = "parent.success('yes')";
		}else{
			path = "parent.success('"+mass+"')";
		}
		getRequest().setAttribute("path", path);
		return successView;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的修改密码的判断
	 * ====================================================================
	 */
	public String validatePwd() {
		MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
		String pwd = membersView.getPassWord();
		String password = getRequest().getParameter("Password");
		String flag = "";
		if(pwd.equals(password)){
			flag = "0";
		}else{
			flag = "1";
		}
		
 		try {
 			getResponse().setCharacterEncoding("UTF-8");
 			getResponse().getWriter().print(flag);
 		} catch (IOException ex) {
 			LogUtils.error("Tree json 数据转换错误。", ex);
 		} 
 		return Action.NONE;
	}
	
	/** 
	 * ===================================================================*
	 * 进行  【人工审核.成员管理】 的修改保存操作。
	 * ====================================================================
	 */
	public String edit(){
		boolean flag = false;
		try{
			IMemberService daoService = (IMemberService) AppContextUtils.getBean(IMemberService.class.getName());
			IDaoService daoServices = (IDaoService) AppContextUtils.getBean(IDaoService.class.getName());
			MembersView membersView=(MembersView)getSession().getAttribute(RapParameter.DICTIONARY_LOGIN_INFO);
			Members member =(Members) daoServices.findEntityByKey(Members.class, membersView.getMembersId());
			MembersPicture pic =(MembersPicture) daoServices.findEntityByKey(MembersPicture.class, membersView.getGroupId());
			String pwd= getRequest().getParameter("newPassword");
			member.setPassWord(pwd);
			daoService.updateMember(member, pic);
		    String dir = ServletActionContext.getServletContext().getRealPath("/files");
		    deletefile(dir);
			flag = true;
		}catch (Exception e) {
			LogUtils.error(e);
		}
		massgeUtils.massge(flag);
		return Action.NONE;
	}
	
	/**
	 * ===================================================================*
	 * 清空列表； 进行 【人工审核.成员管理】修改操作 的文件列表清空操作。
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
	
	/**
	 * ===================================================================*
	 * 列表显示； 进行 【人工审核.成员管理】 修改操作的图片展示操作。
	 * ====================================================================
	 */
	public String fileList() throws IOException{
		String dir = ServletActionContext.getServletContext().getRealPath("/files");
		List<String> files = new ArrayList<String>();
		File root = new File(dir);
		File[] fs = root.listFiles();
		
		for(File f : fs){
			if(f.isFile()){
				String fileName =f.getName();
				files.add(fileName);
			}
		}
		
		ServletOutputStream out = null;
		InputStream in = null;

		in = new FileInputStream(root+"\\"+files.get(0));
		out = getResponse().getOutputStream();

		byte[] bytes = new byte[1024*2*1024];
		while ((in.read(bytes) != -1)) {
			out.write(bytes);
		}
		out.flush();
		out.close();
		in.close();
		bytes = null;
		return null;
	}
	
	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileName;
	}
	public void setFileFileName(String fileFileName) {
		
		this.fileName = fileFileName;
	}
}
