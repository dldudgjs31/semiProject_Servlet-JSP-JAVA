package com.bbs_best;

public class BoardDTO {
private int num;
private int listNum;
private String userId;
private String subject;
private String userName;
private String content;
private String created;
private int hitCount;
private int memberClass;


public int getMemberClass() {
	return memberClass;
}
public void setMemberClass(int memberClass) {
	this.memberClass = memberClass;
}
public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
public int getListNum() {
	return listNum;
}
public void setListNum(int listNum) {
	this.listNum = listNum;
}
public String getUserId() {
	return userId;
}
public void setUserId(String userId) {
	this.userId = userId;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getUserName() {
	return userName;
}
public void setUserName(String userName) {
	this.userName = userName;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getCreated() {
	return created;
}
public void setCreated(String created) {
	this.created = created;
}
public int getHitCount() {
	return hitCount;
}
public void setHitCount(int hitCount) {
	this.hitCount = hitCount;
}

}
