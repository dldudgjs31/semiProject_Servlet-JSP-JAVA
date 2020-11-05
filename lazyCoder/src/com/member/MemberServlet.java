package com.member;

import java.io.IOException;
import java.sql.SQLDataException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/*")
public class MemberServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd=req.getRequestDispatcher(path);
		//������ �θ��� �ִ� ��ü ����
		
		rd.forward(req, resp);
	}
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		
		if(uri.indexOf("login.do")!=-1) {
			loginForm(req, resp);
		}else if (uri.indexOf("login_ok.do")!=-1) {
			loginSubmit(req, resp);
		}else if (uri.indexOf("logout.do")!=-1) {
			logout(req, resp);
		}else if (uri.indexOf("member.do")!=-1) {
			memberForm(req, resp);
		}else if (uri.indexOf("member_ok.do")!=-1) {
			memberSubmit(req, resp);
		}else if (uri.indexOf("pwd.do")!=-1) {
			pwdForm(req, resp);
		}else if (uri.indexOf("pwd_ok.do")!=-1) {
			pwdSubmit(req, resp);
		}else if (uri.indexOf("update.do")!=-1) {
			updateForm(req, resp);
		}else if (uri.indexOf("update_ok.do")!=-1) {
			updateSubmit(req, resp);
		}else if (uri.indexOf("userIdCheck.do")!=-1) {
			userIdCheck(req, resp);
		}
		
	}
	
	protected void loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//�α��� ��
		String path="/WEB-INF/views/member/login.jsp";
		forward(req, resp, path);
	}
	
	protected void loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//�α��� ó��
		
		MemberDAOImpl dao=new MemberDAOImpl();
		String cp=req.getContextPath();
		
		try {
			String userId=req.getParameter("userId");
			String userPwd=req.getParameter("userPwd");
			MemberDTO dto=dao.readMember(userId);
			if(dto!=null) {
				if(dto.getUserPwd().equals(userPwd)) {
					//�α��� ����
					HttpSession session=req.getSession();//���� ��ü
					
					//���� �����ð� 25������ ����(��Ĺ�� �⺻ 30��)
					session.setMaxInactiveInterval(25*60);
					
					//���ǿ� ������ ����
					SessionInfo info=new SessionInfo();
					info.setUserId(dto.getUserId());
					info.setUserName(dto.getUserName());
					info.setMemberClass(dto.getMemberClass());
					//���ǿ� ���� ����
					session.setAttribute("member", info);
					
					//����ȭ������
					resp.sendRedirect(cp);
					return;
					
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//�α����� ������ ���
		req.setAttribute("message", "���̵�Ǵ� �н����尡 ��ġ���� �ʽ��ϴ�");
		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}
	
	protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//�α׾ƿ�
		HttpSession session=req.getSession();
		
		//���ǿ� ����� ��� ������ ����� ������ �ʱ�ȭ
		session.invalidate();
		//Ư���� ������ ������ ���
		//session.removeAttribute("member");

		
		String cp=req.getContextPath();
		resp.sendRedirect(cp);
	}
	
	protected void memberForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//ȸ������ ��
		req.setAttribute("mode", "member");
		req.setAttribute("title", "ȸ�� ����");
		String path="/WEB-INF/views/member/member.jsp";
		forward(req, resp, path);
	}
	
	protected void memberSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//ȸ�� ���� ó��
		
		//�ڵ��ϱ�
		MemberDAO dao=new MemberDAOImpl();
		MemberDTO dto=new MemberDTO();
		
		String cp=req.getContextPath();
		
		try {
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setMemberClass(Integer.parseInt(req.getParameter("memberClass")));
			dto.setEmail(req.getParameter("email1")+"@"+req.getParameter("email2"));
			dto.setTel(req.getParameter("tel1")+"-"+req.getParameter("tel2")+"-"+req.getParameter("tel3"));
			String birth=req.getParameter("birth").replaceAll("(\\.|\\-|\\/)", "");
			dto.setBirth(birth);
			
			dao.insertMember(dto);
			
			resp.sendRedirect(cp); //�ֻ����� �ִ� ������ �ҷ����Ƿ� index.jsp�� ����ȴ�
			
			return;
			
		}catch (SQLIntegrityConstraintViolationException e) {
			req.setAttribute("message", "���̵� �ߺ� ���� ���Ἲ ���� ���� �����Դϴ�.");
		}catch (SQLDataException e) {
			req.setAttribute("message", "��¥ ���ĵ��� �߸��Ǿ����ϴ�.");
		} catch (Exception e) {
			req.setAttribute("message", "������ �߰��� �����Ͽ����ϴ�");
		}
		req.setAttribute("mode", "member");
		req.setAttribute("title", "ȸ�� ����");
		String path="/WEB-INF/views/member/member.jsp";
		forward(req, resp, path);
		
	}
	
	protected void pwdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//����, Ż�� ��� �н����� �Է� ��
	}
	
	protected void pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//�н����� �˻�
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//ȸ�� ���� ���� ��
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//ȸ�� ���� ���� ó��
	}
	
	protected void userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//ȸ�� ���̵� �ߺ� �˻�
	}
	
	
	
	
	
}