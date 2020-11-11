package com.member;

import java.sql.SQLException;
import java.util.List;

public interface MemberDAO {

	public int insertMember(MemberDTO dto) throws SQLException;
	
	public MemberDTO readMember(String userId);
	
	public int updateMember(String userId,MemberDTO dto);
	
	public int deleteMember(String userId);
	
	public List<String> listmember();
	
	
	
}
