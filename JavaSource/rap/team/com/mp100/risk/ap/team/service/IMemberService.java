package com.mp100.risk.ap.team.service;
import java.io.InputStream;
import java.util.List;

import com.mp100.risk.ap.team.domain.hibernate.dv.MembersView;
import com.mp100.risk.ap.team.domain.hibernate.hbm.Members;
import com.mp100.risk.ap.team.domain.hibernate.hbm.MembersPicture;

public interface IMemberService {
	/**新增成员保存的方法*/
	public void saveMember(Members member,MembersPicture pic);
	/**修改成员状态*/
	public void updateState(String id,String state);
	/**删除成员*/
	public void deleteMember(String id);
	/**获取成员详细资料的方法*/
	public List<MembersView> listPage(String QT_state, String QT_groupId,String QT_chnName);
	/**修改组操作*/
	public void deleteGroup(String ids);
	/**获取成员列表时头像展示*/
	public InputStream getPictureInputStrem(String id);
	/**修改成员的基本信息*/
	public void updateMember(Members member,MembersPicture pic);
}
