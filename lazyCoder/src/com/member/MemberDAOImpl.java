package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import com.util.DBConn;

public class MemberDAOImpl implements MemberDAO {
	private Connection conn = DBConn.getConnection();

	public int insertMember(MemberDTO dto) throws SQLException {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		// member1 ���̺�� member2 ���̺� ȸ�� ���� ����

		try {
			
			conn.setAutoCommit(false); // �ڵ� Ŀ�Ե��� �ʵ���
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

			conn.commit();// Ŀ��
		} catch (SQLIntegrityConstraintViolationException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
			} catch (Exception e2) {
			}
			e.printStackTrace();
			throw e;
		} catch (SQLDataException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
			} catch (Exception e2) {
			}
			e.printStackTrace();
			throw e;
		} catch (SQLException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
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
				conn.setAutoCommit(true);// �ڵ�Ŀ�Եǵ���(�⺻)
			} catch (Exception e2) {
			}
		}
		return result;

	}

	// userId ���ǿ� �����ϴ�
	// member1�� member2�� outer join�Ͽ� MemberDto ��ü�� ��Ƽ� ��ȯ
	// email�� email1, email2�� tel�� tel1,tel2,tel3�� ��Ƽ� �����Ѵ�.
	// email�̳� tel�� null�� ��쿡�� �ƹ��͵� ���� �ʴ´�.
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
		// member1 ���̺�� member2 ���̺� ȸ�� ���� ����

		try {
			
			conn.setAutoCommit(false); // �ڵ� Ŀ�Ե��� �ʵ���
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

			conn.commit();// Ŀ��
		} catch (SQLIntegrityConstraintViolationException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} catch (SQLDataException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} catch (SQLException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
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
				conn.setAutoCommit(true);// �ڵ�Ŀ�Եǵ���(�⺻)
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
		// member1 ���̺�� member2 ���̺� ȸ�� ���� ����

		try {
			
			conn.setAutoCommit(false); // �ڵ� Ŀ�Ե��� �ʵ���
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

			conn.commit();// Ŀ��
		} catch (SQLIntegrityConstraintViolationException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} catch (SQLDataException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
			} catch (Exception e2) {
			}
			e.printStackTrace();
		} catch (SQLException e) {
			try {
				conn.rollback();// ���ܹ߻��ϸ� �ѹ�
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
				conn.setAutoCommit(true);// �ڵ�Ŀ�Եǵ���(�⺻)
			} catch (Exception e2) {
			}
		}
		return result;
	}

}
