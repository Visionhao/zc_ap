package com.mp100.risk.ap.team.domain.hibernate.hbm;

public class MembersGroup implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	private String groupId;
	private String groupName;
	private long seq;
	public MembersGroup() {
		super();
	}
	public MembersGroup(String groupId, String groupName, long seq) {
		super();
		this.groupId = groupId;
		this.groupName = groupName;
		this.seq = seq;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public long getSeq() {
		return seq;
	}
	public void setSeq(long seq) {
		this.seq = seq;
	}
	
}
