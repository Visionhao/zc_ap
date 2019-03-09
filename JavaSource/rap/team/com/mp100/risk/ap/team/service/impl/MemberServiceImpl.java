package com.mp100.risk.ap.team.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.mp100.risk.ap.seats.domain.hibernate.hbm.TaskDivide;
import com.mp100.risk.ap.seats.service.ITaskDivideService;
import com.mp100.risk.ap.seats.util.GainUuidutils;
import com.mp100.risk.ap.team.domain.hibernate.dv.MembersPictureView;
import com.mp100.risk.ap.team.domain.hibernate.dv.MembersView;
import com.mp100.risk.ap.team.domain.hibernate.hbm.Members;
import com.mp100.risk.ap.team.domain.hibernate.hbm.MembersGroup;
import com.mp100.risk.ap.team.domain.hibernate.hbm.MembersPicture;
import com.mp100.risk.ap.team.service.IMemberService;
import com.mp100.risk.ap.util.RapParameter;
import com.uap.common.utils.AppContextUtils;
import com.uap.common.utils.DateUtils;
import com.uap.common.utils.LogUtils;
import com.uap.common.utils.ObjectUtils;
import com.uap.common.utils.StringUtils;
import com.uap.core.domain.dao.IBaseDao;
import com.uap.core.service.IDaoService;


public class MemberServiceImpl implements IMemberService{
	private static Connection con=null;  
	private static PreparedStatement pstmt=null;  
	private static ResultSet rs=null; 
	
	/**
	 * 新增成员
	 * */
	public void saveMember(Members member,MembersPicture pic) {
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		member.setStateTime(DateUtils.currentDate());
		member.setCreateDate(DateUtils.currentDate());
		member.setState(RapParameter.DICTIONARY_MEMBER_STATUS_ONLINE);
		
		daoService.saveEntity(member);
		String picId = GainUuidutils.createUUID();
		String dir = ServletActionContext.getServletContext().getRealPath("/files");
		List<String> files = new ArrayList<String>();
		
		File root = new File(dir);
		File[] fs = root.listFiles();
		if(ObjectUtils.isNotNull(fs)){
			for(File f : fs){
				if(f.isFile()){
					String fileName =f.getName();
					files.add(fileName);
				}
			}
		}
		
		DriverManagerDataSource ds = (DriverManagerDataSource) AppContextUtils.getBean("dataSource");
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			String sql = "insert into X_AP_MEMBERS_PICTURE(PICTURE_ID,MEMBERS_ID,PICTURE_NAME) values(?,?,empty_blob())";
			String sql1 = "select p.PICTURE_NAME from X_AP_MEMBERS m,X_AP_MEMBERS_PICTURE p where m.MEMBERS_ID = p.MEMBERS_ID and p.PICTURE_ID='"+picId+"'";
			
			pstmt = con.prepareStatement(sql);  
			pstmt.setString(1,picId);   
			pstmt.setString(2,member.getMembersId()); 
			pstmt.executeUpdate();   
			pstmt.close(); 
			
			if(ObjectUtils.isNotNull(fs)){
				rs=con.createStatement().executeQuery(sql1);  
				while(rs.next()){  
			
				oracle.sql.BLOB  b=(oracle.sql.BLOB )rs.getBlob("PICTURE_NAME");  
				File f=new File(root+"\\"+files.get(0));  
				
				BufferedInputStream in=new BufferedInputStream(new FileInputStream(f));    
				BufferedOutputStream  out=new BufferedOutputStream(b.getBinaryOutputStream());  
				int c;     
				while ((c=in.read())!=-1)   {     
					out.write(c);     
				}
					in.close();     
					out.close();  
				}
			}
			con.commit();
			TaskDivide taskBean=new TaskDivide();
			taskBean.setWorkCategory(RapParameter.DICTIONARY_TASK_TYPE_ALL);
			taskBean.setWorkLoad(0);
			taskBean.setMembersId(member.getMembersId());
			
			daoService.saveEntity(taskBean);
			if(RapParameter.DICTIONARY_MEMBER_STATUS_ONLINE.equals(member.getState())){
				ITaskDivideService taskDivideService = (ITaskDivideService)AppContextUtils.getBean(ITaskDivideService.class.getName());
				taskDivideService.setTask();
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}  
	}
	
	/**
	 * 修改成员的状态
	 * */
	public void updateState(String id, String state) {
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		String ids[] = StringUtils.split(id, ",");
		for(int i=0;i<ids.length;i++){
			Members member  = (Members) daoService.findEntityByKey(Members.class,ids[i]);
			if(!state.equals(member.getState())){
				member.setState(state);
				member.setStateTime(DateUtils.currentDate());
				daoService.updateEntity(member);
				ITaskDivideService taskDivideService = (ITaskDivideService)AppContextUtils.getBean(ITaskDivideService.class.getName());
				taskDivideService.setTask();
			}
		}
		
	}
	
	/**
	 * 删除成员
	 * */
	public void deleteMember(String id) {
		IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
		String ids[] = StringUtils.split(id, ",");
		Members member  = null;
		for(int i=0;i<ids.length;i++){
			if(ObjectUtils.isNotNull(ids[i])){
				member = (Members) daoService.findEntityByKey(Members.class,ids[i]);
			}
			if(ObjectUtils.isNotNull(member)){
				List<TaskDivide> taskDivideList=(List<TaskDivide>) daoService.findByPropertyName(TaskDivide.class, "membersId",member.getMembersId());
				List<MembersPicture> picList=(List<MembersPicture>) daoService.findByPropertyName(MembersPicture.class, "membersId",member.getMembersId());
				if(ObjectUtils.isNotNull(taskDivideList)){
					daoService.deleteEntityById(TaskDivide.class, taskDivideList.get(0).getTaskAssignId());
				}
				if(ObjectUtils.isNotNull(picList)){
					daoService.deleteEntityById(MembersPicture.class, picList.get(0).getPictureId());
				}
				daoService.deleteEntity(member);
			}
		}
		
	}
	
	/**
	 * 加载成员详细信息
	 */
	public List<MembersView> listPage(String QT_state, String QT_groupId,String QT_chnName) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("QT_state",QT_state);
		map.put("QT_groupId", QT_groupId);
		if(ObjectUtils.isNotNull(QT_chnName)) map.put("QT_chnName", "%"+QT_chnName+"%");
		try {
			IDaoService daoService = (IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
			if(ObjectUtils.isNotNull(QT_chnName)){
				List<MembersView> memberList = (List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersSearchViewDV", map);
				for (MembersView membersView : memberList) {
					String dates = DateUtils.formatDateByFormat(membersView.getStateTime(), "yyyy-MM-dd");
					membersView.setDates(dates);
				}
				return memberList;
			}else{
				List<MembersView> memberList = (List<MembersView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersViewDV", map);
				for (MembersView membersView : memberList) {
					String dates = DateUtils.formatDateByFormat(membersView.getStateTime(), "yyyy-MM-dd");
					membersView.setDates(dates);
				}
				return memberList;
			}
		
		} catch (Exception e) {
			LogUtils.error(e);
		}
		return null;
	}
	
	/**
	 * 删除组名称
	 */
	public void deleteGroup(String ids) {
		String[] groupIds =ids.split(",");
		if(groupIds.length > 0){
			MembersGroup group=new MembersGroup();
			Members member =new Members();
			for(String id : groupIds){
				group.setGroupId(id);
				member.setGroup(group);
				deleteG(group);
			}
		}
		
	}
	
	/**
	 * 删除关联组的成员的数据
	 */
	public void deleteG(MembersGroup group){
		IBaseDao baseDao=(IBaseDao)AppContextUtils.getBean(IBaseDao.class.getName());
 		IDaoService daoService= (IDaoService) AppContextUtils.getBean(IDaoService.class.getName());
 		List<Members> m = (List<Members>) daoService.findByPropertyName(Members.class, "group.groupId", group.getGroupId());
 		for (Members members : m) {
 			MembersGroup group1 = new MembersGroup();
 			group1.setGroupId("1000");
 			members.setGroup(group1);
 			baseDao.update(m);
 			//baseDao.delete(members);
		}
 		baseDao.delete(group);
	}
	
	/**
	 * 成员管理-读取图片
	 **/
	public InputStream getPictureInputStrem(String id) {
		InputStream	inputStream = null;
		try{
			 IDaoService daoService=(IDaoService)AppContextUtils.getBean(IDaoService.class.getName());
			 Map<String,Object> map = new HashMap<String,Object>();
			 map.put("QT_membersId", id);
			 List<MembersPictureView> list = (List<MembersPictureView>) daoService.findEntityByNamedSQLQuery("com.mp100.risk.ap.team.domain.hibernate.dv.queryMembersPictureViewDV",map);
			 for(MembersPictureView view :list){
				 Blob blob =  view.getPictureName();
				 
				 byte[] bytes = null;
				 BufferedInputStream is = new BufferedInputStream(blob.getBinaryStream());
			     bytes = new byte[(int) blob.length()];
			     int len = bytes.length;
			     int offset = 0;
			     int read = 0;
			    while (offset < len && (read = is.read(bytes, offset, len - offset)) >= 0) {
			        offset += read;
			    }
				inputStream =new ByteArrayInputStream(bytes);
				return inputStream;
			 }
			 return null;
		}catch(Exception e ){
			e.printStackTrace();
		}
		return null;
		

	}

	/**
	 * 修改成员信息
	 */
	public void updateMember(Members member, MembersPicture pic) {
		String dir = ServletActionContext.getServletContext().getRealPath("/files");
		List<String> files = new ArrayList<String>();
		DriverManagerDataSource ds = (DriverManagerDataSource) AppContextUtils.getBean("dataSource");
		try {
		File root = new File(dir);
		File[] fs = root.listFiles();
		if (ObjectUtils.isNull(fs)){
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			String sql = "update X_AP_MEMBERS_PICTURE set MEMBERS_ID=? where PICTURE_ID='"+pic.getPictureId()+"'";
			String sqls = "update X_AP_MEMBERS set PASSWORD=? where MEMBERS_ID='"+member.getMembersId()+"'";
					
			PreparedStatement pstmt = con.prepareStatement(sql);  
			PreparedStatement pstmts = con.prepareStatement(sqls);  
			pstmt.setString(1,pic.getMembersId()); 
			pstmts.setString(1,member.getPassWord()); 
			pstmt.executeUpdate();   
			pstmts.executeUpdate();   
			pstmt.close(); 
			pstmts.close(); 
		} else{
			if(ObjectUtils.isNotNull(fs)){
				for(File f : fs){
					if(f.isFile()){
						String fileName =f.getName();
						files.add(fileName);
					}
				}
				
				con = ds.getConnection();
				con.setAutoCommit(false);
				
				String sql = "update X_AP_MEMBERS_PICTURE set MEMBERS_ID=?,PICTURE_NAME=empty_blob() where PICTURE_ID='"+pic.getPictureId()+"'";
				String membersql = "update X_AP_MEMBERS set PASSWORD=? where MEMBERS_ID='"+member.getMembersId()+"'";
				String sql1 = "select p.PICTURE_NAME from X_AP_MEMBERS m,X_AP_MEMBERS_PICTURE p where m.MEMBERS_ID = p.MEMBERS_ID and p.MEMBERS_ID='"+member.getMembersId()+"'";
				
				PreparedStatement pstmt = con.prepareStatement(sql);  
				PreparedStatement pstmts = con.prepareStatement(membersql);  
				pstmt.setString(1,pic.getMembersId()); 
				pstmt.executeUpdate();   
				pstmts.setString(1,member.getPassWord()); 
				pstmts.executeUpdate();   
				pstmt.close(); 
				pstmts.close(); 
				
				if(ObjectUtils.isNotNull(fs)){
				rs=con.createStatement().executeQuery(sql1);  
					while(rs.next()){  
						oracle.sql.BLOB  b=(oracle.sql.BLOB )rs.getBlob("PICTURE_NAME");  
						File f=new File(root+"\\"+files.get(0));  
						BufferedInputStream in=new BufferedInputStream(new FileInputStream(f));    
						BufferedOutputStream  out=new BufferedOutputStream(b.getBinaryOutputStream());  
						int c;     
						while ((c=in.read())!=-1)   {     
							out.write(c);
						}
						in.close();     
						out.close();  
					}
				}
				con.commit();
			}
		}
		}catch (SQLException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
	}
}
