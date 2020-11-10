package com.member;

import java.sql.SQLException;

public interface MemberDAO {

	public int insertMember(MemberDTO dto) throws SQLException;
	
	public MemberDTO readMember(String userId);
	
	public int updateMember(String userId,MemberDTO dto);
	
	public int deleteMember(String userId);
	
	
	
}
