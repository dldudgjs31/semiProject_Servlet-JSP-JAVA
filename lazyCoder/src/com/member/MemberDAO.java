package com.member;

import java.sql.SQLException;
import java.util.List;

public interface MemberDAO {

	public int insertMember(MemberDTO dto) throws SQLException;
	
	public MemberDTO readMember(String userId);
	
	public int updateMember(String userId,MemberDTO dto);
	
	public int deleteMember(String userId);
	
	public List<String> listmember();
	
	public List<MemberDTO> listMember(int offset, int rows);
	public List<MemberDTO> listMember(int offset, int rows, String condition, String keyword);
	
	public int dataCount();
	
}
