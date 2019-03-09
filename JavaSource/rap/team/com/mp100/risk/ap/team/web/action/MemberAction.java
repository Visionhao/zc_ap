package com.mp100.risk.ap.team.web.action;
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

import com.mp100.risk.ap.team.domain.hibernate.dv.MembersGroupView;
import com.mp100.risk.ap.team.domain.hibernate.dv.MembersView;
import com.mp100.risk.ap.team.domain.hibernate.hbm.Members;
import com.mp100.risk.ap.team.domain.hibernate.hbm.MembersGroup;
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
/**
 * Company: 北京众成联信信息技术有限公司 
 * Title: 	人工审核平台 v1.0 
 * 类描述 : 	人工审批-成员管理Action类
 * @version 1.0
 * @since: 	2015-04-15
 * @author 	吴文浩
 * @serial:	2015-04-15
 */
public class MemberAction  extends BaseJmesaAction{

	private static final long serialVersionUID = 1L;
	private List<MembersView> list=new ArrayList<MembersView>();
	private List<MembersGroup> groupList=new ArrayList<MembersGroup>();
	private MembersView membersView;
	private MembersGroup group;
	private File file;
	/* 需要上传的文件的文件名  */
	private String fileName;
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的主页面。
	 * ====================================================================
	 */
	public String main(){
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		//查询组的名称和数量
		List<MembersGroupView> group = (List<MembersGroupView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersGroupCountDV", new HashMap());
		//查询新增时组的名称
		List<MembersGroupView> groupList = (List<MembersGroupView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersGroupListDV", new HashMap());
		//查询成员总数量
		List<MembersView> allCount = (List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersViewDV", new HashMap());
		
		getRequest().setAttribute("group", group);
		getRequest().setAttribute("groupList",groupList);
		getRequest().setAttribute("allCount",allCount.size());
		
		return "main";
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的成员列表显示界面。
	 * ====================================================================
	 */
	public String list(){
		ServletActionContext.getResponse().setContentType("application/text;charset=UTF-8");
		String QT_state = membersView.getState();
		String QT_groupId = membersView.getGroupId();
		String QT_chnName = membersView.getChnName();
		IMemberService memberService = (IMemberService) AppContextUtils.getBean(IMemberService.class.getName());
		this.list =memberService.listPage(QT_state,QT_groupId,QT_chnName);
		return "list";
	}

	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的新增成员时工号的唯一校验。
	 * ====================================================================
	 */
	public String validates(){
		boolean flag = false;
		String id=getRequest().getParameter("resId");
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,String> map=new HashMap<String,String>();
		map.put("QT_jobNumber", id);
		
		List<MembersView> list=(List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersValidateViewDV", map);
		if(ObjectUtils.isNotNull(list)){
			flag = true;
		}
		massgeUtils.massge(flag);
		return Action.NONE;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的新增成员时姓名的唯一校验。
	 * ====================================================================
	 */
	public String validateName(){
		boolean flag = false;
		String id=getRequest().getParameter("resId");
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,String> map=new HashMap<String,String>();
		map.put("QT_chnName", id);
		
		List<MembersView> list=(List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersValidateViewDV", map);
		if(ObjectUtils.isNotNull(list)){
			flag = true;
		}
		massgeUtils.massge(flag);
		return Action.NONE;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的新增组时组名的唯一校验。
	 * ====================================================================
	 */
	public String validateGroup(){
		boolean flag = false;
		String id=getRequest().getParameter("resId");
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Map<String,String> map=new HashMap<String,String>();
		map.put("QT_groupName", id);
		
		List<MembersGroupView> list=(List<MembersGroupView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersValidateGroupDV", map);
		if(ObjectUtils.isNotNull(list)){
			flag = true;
		}
		massgeUtils.massge(flag);
		return Action.NONE;
	}
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的新增成员的保存操作。
	 * ====================================================================
	 */
	public String save(){
		boolean flag = false;
		try {
			Members member = (Members) getModel(Members.class);
			MembersPicture pic = new MembersPicture();
			MembersGroup group = (MembersGroup) getModel(MembersGroup.class);
			member.setGroup(group);
			IMemberService daoService = (IMemberService) AppContextUtils.getBean(IMemberService.class.getName());
		    daoService.saveMember(member,pic);
		    String dir = ServletActionContext.getServletContext().getRealPath("/files");
		    deletefile(dir);
			flag = true;
		} catch (Exception e) {
			LogUtils.error("添加成员时出现错误", e);
			e.printStackTrace();
		}finally{
			massgeUtils.massge(flag);
		}
		return Action.NONE;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的新增成员的保存并新增操作。
	 * ====================================================================
	 */
	public String saveToAdd(){
		boolean flag = false;
		try {
			Members member = (Members) getModel(Members.class);
			MembersPicture pic = new MembersPicture();
			MembersGroup group = (MembersGroup) getModel(MembersGroup.class);
			member.setGroup(group);
			IMemberService daoService = (IMemberService) AppContextUtils.getBean(IMemberService.class.getName());
		    daoService.saveMember(member,pic);
		    String dir = ServletActionContext.getServletContext().getRealPath("/files");
		    deletefile(dir);
			flag = true;
		} catch (Exception e) {
			LogUtils.error("添加成员时出现错误", e);
		}finally{
			massgeUtils.saveMassge(flag);
		}
		return Action.NONE;
	}
	

	/**
	 * ===================================================================*
	 * 列表显示； 
     * 进行 【人工审核.成员管理】 的列表展示加载成员头像操作。
	 * ====================================================================
	 */
	public String readPicture() throws Exception {
		String id = getRequest().getParameter("id");
		IMemberService daoService = (IMemberService) AppContextUtils.getBean(IMemberService.class.getName());
		ServletOutputStream out = null;
		InputStream in = null;
		in = daoService.getPictureInputStrem(id);
		out = getResponse().getOutputStream();
		byte[] bytes = new byte[10240];
		while ((in.read(bytes) != -1)) {
			out.write(bytes);
		}
		out.flush();
		out.close();
		in.close();
		bytes = null;
		return null;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的成员小组的修改操作。
	 * ====================================================================
	 */
	public String editGroup(){
		String id = getRequest().getParameter("id");
		String name = getRequest().getParameter("name");
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		MembersGroup groupVO = new MembersGroup();
		groupVO.setGroupId(id);
		groupVO.setGroupName(name);
		MembersGroup groupPO = (MembersGroup) daoService.findEntityByKey(MembersGroup.class,groupVO.getGroupId());
		try {
			ObjectUtils.copyProperties(groupVO, groupPO);
			daoService.updateEntity(groupPO);
		} catch (Exception e) {
			LogUtils.error(e);
		}
		return Action.NONE;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的成员小组的修改操作。
	 * ====================================================================
	 */
	public String editGroupName(){
		MembersGroup groupVo = new MembersGroup();
		groupVo.setGroupId(membersView.getGroupId());
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		Members membersVO = new Members();
		membersVO.setMembersId(membersView.getMembersId());
		membersVO.setGroup(groupVo);
		Members membersPO = (Members) daoService.findEntityByKey(Members.class,membersVO.getMembersId());
		try {
			ObjectUtils.copyProperties(membersVO, membersPO);
			daoService.updateEntity(membersPO);
		} catch (Exception e) {
			LogUtils.error(e);
		}
		return Action.NONE;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的修改状态的操作。
	 * ====================================================================
	 */
	public String changeState(){
		boolean flag = false;
		String id = getRequest().getParameter("id");
		Map<String,String> map=new HashMap<String,String>();
		String tag = getRequest().getParameter("tag");
		if(ObjectUtils.isNotNull(id)) map.put("QT_membersId", id);
		
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		List<MembersView> list=(List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersChangeStateDV", map);
		
		IMemberService memberService = (IMemberService)AppContextUtils.getBean(IMemberService.class.getName());
		if(ObjectUtils.isNotNull(list)){
			if(tag.equals("pauseMember")){
				memberService.updateState(getRequest().getParameter("id"), RapParameter.DICTIONARY_MEMBER_STATUS_LEAVE);
				flag = true;
			}else if(tag.equals("joinMember")){
				memberService.updateState(getRequest().getParameter("id"), RapParameter.DICTIONARY_MEMBER_STATUS_ONLINE);
				flag = true;
			}else if(tag.equals("exitMember")){
				memberService.updateState(getRequest().getParameter("id"), RapParameter.DICTIONARY_MEMBER_STATUS_NOJOIN);
				flag = true;
			}else{
				memberService.deleteMember(getRequest().getParameter("id"));
				flag = true;
			}
		}
		massgeUtils.massge(flag);
		return Action.NONE;
	}
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的新增组操作。
	 * ====================================================================
	 */
	public String addGroup(){
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		daoService.saveEntity(this.group);
		return "addGroup";
	}
	
	/** ===================================================================*
	 * 【人工审核.成员管理】模块的删除组操作。
	 * =====================================================================*/
	public String delete(){
		String id=getRequest().getParameter("id");
		IMemberService memberService = (IMemberService)AppContextUtils.getBean(IMemberService.class.getName());
		memberService.deleteGroup(id);
		return Action.NONE;
	}
	
	
	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块的成员组排序操作。
	 * ====================================================================
	 */
	public String sortGroup(){
		IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		daoService.updateEntity(groupList);
		return "sortGroup";
	}

	/**
	 * ===================================================================* 
	 * 进入 【人工审核.成员管理】模块新增用户的上传图片操作。
	 * ====================================================================
	 */
	public String upload(){
		getResponse().setContentType("application/text;charset=UTF-8");
		/* 获取文件路径  */
		String dir = ServletActionContext.getServletContext().getRealPath("/files");
		String uploadTempPath = ServletActionContext.getServletContext().getRealPath("/view/rap/files");
		deletefile(dir);
		File target = new File(dir,fileName);
		File uploadTempFile = new File(uploadTempPath,fileName);
		boolean tag = false;
		String messagePictrue = "";
		try {
			FileUtils.copyFile(file, uploadTempFile);
			BufferedImage buff = ImageIO.read(uploadTempFile);
			if(uploadTempFile.length() > 1024*2*1024){
				messagePictrue = "上传的文件太大！";
			}else if(!uploadTempFile.getName().endsWith(".jpg") && !uploadTempFile.getName().endsWith(".png") && !uploadTempFile.getName().endsWith(".gif") ){
				messagePictrue = "上传的图片格式不对！";
			}else if(buff.getWidth() > 80 || buff.getHeight() > 80){
				messagePictrue = "上传的图片高度和宽度不对！";
			}else{
				FileUtils.copyFile(file, target);
				deletefile(uploadTempPath);
				tag = true;
				messagePictrue = "";
			}
		} catch (IOException e) {
			LogUtils.error(e);
		}
		String uploadPathName =null;
		if(tag){
			uploadPathName = "parent.success('yes')";
		}else{
			uploadPathName = "parent.success('"+messagePictrue+"')";
		}
		getRequest().setAttribute("uploadPathName", uploadPathName);
		return successView;
	}
	
	/**
	 * ===================================================================*
	 * 清空列表； 进行 【人工审核.成员管理】 的文件列表清空操作。
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
	 * 列表显示； 进行 【人工审核.成员管理】 的图片展示操作。
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
	
	public List<MembersView> getList() {
		return list;
	}
	public void setList(List<MembersView> list) {
		this.list = list;
	}
	public MembersView getMembersView() {
		return membersView;
	}
	public void setMembersView(MembersView membersView) {
		this.membersView = membersView;
	}

	public MembersGroup getGroup() {
		return group;
	}

	public void setGroup(MembersGroup group) {
		this.group = group;
	}

	public List<MembersGroup> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<MembersGroup> groupList) {
		this.groupList = groupList;
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
