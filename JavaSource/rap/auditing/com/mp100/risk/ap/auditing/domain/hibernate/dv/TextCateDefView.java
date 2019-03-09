package com.mp100.risk.ap.auditing.domain.hibernate.dv;

import java.util.Date;

public class TextCateDefView implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String textcateId;
    private String textcateName;
    private String parentTextcateId;
    private String shortName;
    private String mnemonicCode;
    private String description;
    private String state;
    private Long seqNo;
    private String standardCode;
    private Date createDate;
    private Long level;
    private String parentTextcateName;
    
    /** default constructor */
    public TextCateDefView(){
    	
    }
    
	public String getParentTextcateName() {
		return parentTextcateName;
	}

	public void setParentTextcateName(String parentTextcateName) {
		this.parentTextcateName = parentTextcateName;
	}

	public String getId() {
		return this.textcateId;
	}
	public void setId(String id) {
		this.id = this.textcateId;
	}
	public String getTextcateId() {
		return textcateId;
	}
	public void setTextcateId(String textcateId) {
		this.textcateId = textcateId;
	}
	public String getTextcateName() {
		return textcateName;
	}
	public void setTextcateName(String textcateName) {
		this.textcateName = textcateName;
	}
	public String getParentTextcateId() {
		return parentTextcateId;
	}
	public void setParentTextcateId(String parentTextcateId) {
		this.parentTextcateId = parentTextcateId;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getMnemonicCode() {
		return mnemonicCode;
	}
	public void setMnemonicCode(String mnemonicCode) {
		this.mnemonicCode = mnemonicCode;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Long getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(Long seqNo) {
		this.seqNo = seqNo;
	}

	public String getStandardCode() {
		return standardCode;
	}

	public void setStandardCode(String standardCode) {
		this.standardCode = standardCode;
	}

	public Long getLevel() {
		return level;
	}

	public void setLevel(Long level) {
		this.level = level;
	}

   
}
