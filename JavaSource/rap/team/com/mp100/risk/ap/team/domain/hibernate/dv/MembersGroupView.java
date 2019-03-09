package com.mp100.risk.ap.team.domain.hibernate.dv;

public class MembersGroupView implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	private String groupId;
	private String groupName;
	private long seq;
	private Integer count;
	public MembersGroupView() {
		super();
	}
	
	
	public MembersGroupView(String groupId, String groupName, long seq,
			Integer count) {
		super();
		this.groupId = groupId;
		this.groupName = groupName;
		this.seq = seq;
		this.count = count;
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


	public Integer getCount() {
		return count;
	}


	public void setCount(Integer count) {
		this.count = count;
	}


}
