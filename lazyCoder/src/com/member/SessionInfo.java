package com.member;

//세션에 정보를 저장할 클래스
public class SessionInfo {
	private String userId;
	private String userName;
	private int memberClass;
	
	public int getMemberClass() {
		return memberClass;
	}
	public void setMemberClass(int memberClass) {
		this.memberClass = memberClass;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName; 
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	
	
	
}