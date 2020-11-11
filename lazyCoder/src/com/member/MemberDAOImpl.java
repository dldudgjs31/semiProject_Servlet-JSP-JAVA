package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class MemberDAOImpl implements MemberDAO {
	private Connection conn = DBConn.getConnection();

	public int insertMember(MemberDTO dto) throws SQLException {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		// member1 테이블과 member2 테이블에 회원 정보 저장

		try {
			
			conn.setAutoCommit(false); // 자동 커밋되지 않도록
			sql = "INSERT ALL INTO member1(userId, userName, userPwd, created_date, modify_date,memberClass ) "
					+ " VALUES (?,?,?,SYSDATE,SYSDATE,?) " 
					+ " INTO member2(userId, birth, email, tel) "
					+ " VALUES (?,TO_DATE(?,'YYYYMMDD'),?,?) SELECT * FROM DUAL";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserName());
			pstmt.setString(3, dto.getUserPwd());
			pstmt.setInt(4, dto.getMemberClass());

			pstmt.setString(5, dto.getUserId());
			pstmt.setString(6, dto.getBirth());

			String email;
			email = dto.getEmail();
			pstmt.setString(7, email);

			String tel;
			tel=dto.getTel();
			pstmt.setString(8, tel);

			result = pstmt.executeUpdate();

			conn.commit();// 커밋
		} catch (SQLIntegrityConstraintViolationException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
			throw e;
		} catch (SQLDataException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
			throw e;
		} catch (SQLException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
				}
			}
			try {
				conn.setAutoCommit(true);// 자동커밋되도록(기본)
			} catch (Exception e2) {
			}
		}
		return result;

	}

	// userId 조건에 만족하는
	// member1과 member2를 outer join하여 MemberDto 객체에 담아서 반환
	// email은 email1, email2에 tel은 tel1,tel2,tel3에 담아서 저장한다.
	// email이나 tel이 null인 경우에는 아무것도 담지 않는다.
	public MemberDTO readMember(String userId) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append("SELECT m1.userId, userName, userPwd,");
			sb.append("      created_date, modify_date, memberClass, ");
			sb.append("      TO_CHAR(birth, 'YYYY-MM-DD') birth,");
			sb.append("      email, tel");
			sb.append("      FROM member1 m1");
			sb.append("      LEFT OUTER JOIN member2 m2");
			sb.append("      ON m1.userId=m2.userId");
			sb.append("      WHERE m1.userId=?");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new MemberDTO();
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setCreated_date(rs.getString("created_date"));
				dto.setModify_date(rs.getString("modify_date"));
				dto.setMemberClass(rs.getInt("memberClass"));
				dto.setBirth(rs.getString("birth"));
				dto.setTel(rs.getString("tel"));
				if (dto.getTel() != null) {
					String[] ss = dto.getTel().split("-");
					if (ss.length == 3) {
						dto.setTel1(ss[0]);
						dto.setTel2(ss[1]);
						dto.setTel3(ss[2]);
					}
				}
				dto.setEmail(rs.getString("email"));
				if (dto.getEmail() != null) {
					String[] ss = dto.getEmail().split("@");
					if (ss.length == 2) {
						dto.setEmail1(ss[0]);
						dto.setEmail2(ss[1]);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			}
		}

		return dto;

	}

	@Override
	public int updateMember(String userId,MemberDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		// member1 테이블과 member2 테이블에 회원 정보 저장

		try {
			
			conn.setAutoCommit(false); // 자동 커밋되지 않도록
			sql = "UPDATE member1 SET userPwd=?, modify_date=SYSDATE, memberClass=? "
					+ "  WHERE userId=? ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserPwd());
			pstmt.setInt(2, dto.getMemberClass());

			pstmt.setString(3, userId);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			sql="";
			sql="UPDATE member2 SET tel=?, birth=?, email=? WHERE userId=?";
			
			pstmt=conn.prepareStatement(sql);
			
			
			pstmt.setString(1, dto.getTel());

			pstmt.setString(2, dto.getBirth());
			
			pstmt.setString(3, dto.getEmail());
			
			pstmt.setString(4, userId);

			result = pstmt.executeUpdate();

			conn.commit();// 커밋
		} catch (SQLIntegrityConstraintViolationException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} catch (SQLDataException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} catch (SQLException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
				}
			}
			try {
				conn.setAutoCommit(true);// 자동커밋되도록(기본)
			} catch (Exception e2) {
			}
		}
		return result;
	}

	@Override
	public int deleteMember(String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		// member1 테이블과 member2 테이블에 회원 정보 저장

		try {
			
			conn.setAutoCommit(false); // 자동 커밋되지 않도록
			sql = "DELETE FROM member2 WHERE userId=?";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);

			result=pstmt.executeUpdate();
			
			pstmt.close();
			result=0;
			sql="";
			sql="DELETE FROM member1 WHERE userId=?";
			
			pstmt=conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			result = pstmt.executeUpdate();

			conn.commit();// 커밋
		} catch (SQLIntegrityConstraintViolationException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} catch (SQLDataException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} catch (SQLException e) {
			try {
				conn.rollback();// 예외발생하면 롤백
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
				}
			}
			try {
				conn.setAutoCommit(true);// 자동커밋되도록(기본)
			} catch (Exception e2) {
			}
		}
		return result;
	}

	@Override
	public List<String> listmember() {
		List<String> list=new ArrayList<String>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuilder sb=new StringBuilder();
		String userId;
		
		try {
			sb.append("SELECT userId FROM member1 ");
			
			
			pstmt=conn.prepareStatement(sb.toString());

			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				userId=rs.getString("userId");
				
				list.add(userId);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e2) {
				}
			}
			
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
				}
			}
		}
		return list;
	}

}
