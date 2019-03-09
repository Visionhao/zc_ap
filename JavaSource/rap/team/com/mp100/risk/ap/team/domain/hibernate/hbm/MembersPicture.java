package com.mp100.risk.ap.team.domain.hibernate.hbm;

public class MembersPicture implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	private String  pictureId;
	private String  membersId;
	private byte[] pictureName;
	public MembersPicture() {
		super();
	}
	
	public MembersPicture(String pictureId, String membersId, byte[] pictureName) {
		super();
		this.pictureId = pictureId;
		this.membersId = membersId;
		this.pictureName = pictureName;
	}

	public String getPictureId() {
		return pictureId;
	}
	public void setPictureId(String pictureId) {
		this.pictureId = pictureId;
	}
	public String getMembersId() {
		return membersId;
	}
	public void setMembersId(String membersId) {
		this.membersId = membersId;
	}

	public byte[] getPictureName() {
		return pictureName;
	}

	public void setPictureName(byte[] pictureName) {
		this.pictureName = pictureName;
	}
	
}
