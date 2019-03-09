package com.mp100.risk.ap.team.domain.hibernate.dv;

import java.sql.Blob;

public class MembersPictureView implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	private String  pictureId;
	private String  membersId;
	private Blob pictureName;
	public MembersPictureView() {
		super();
	}



	public MembersPictureView(String pictureId, String membersId,
			Blob pictureName) {
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



	public Blob getPictureName() {
		return pictureName;
	}



	public void setPictureName(Blob pictureName) {
		this.pictureName = pictureName;
	}

	
}
