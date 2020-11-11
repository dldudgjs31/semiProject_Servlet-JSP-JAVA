package com.member;

import java.io.IOException;
import java.sql.SQLDataException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

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
		//포워드 부를수 있는 객체 생성
		
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
		}else if (uri.indexOf("delete.do")!=-1) {
			deleteMember(req, resp);
		}
		
	}
	
	protected void loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//로그인 폼
		String path="/WEB-INF/views/member/login.jsp";
		forward(req, resp, path);
	}
	
	protected void loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//로그인 처리
		
		MemberDAOImpl dao=new MemberDAOImpl();
		String cp=req.getContextPath();
		
		try {
			String userId=req.getParameter("userId");
			String userPwd=req.getParameter("userPwd");
			MemberDTO dto=dao.readMember(userId);
			if(dto!=null) {
				if(dto.getUserPwd().equals(userPwd)) {
					//로그인 성공
					HttpSession session=req.getSession();//세션 객체
					
					//세션 유지시간 25분으로 설정(톰캣은 기본 30분)
					session.setMaxInactiveInterval(25*60);
					
					//세션에 저장할 정보
					SessionInfo info=new SessionInfo();
					info.setUserId(dto.getUserId());
					info.setUserName(dto.getUserName());
					info.setMemberClass(dto.getMemberClass());
					//세션에 정보 저장
					session.setAttribute("member", info);
					
					//메인화면으로
					resp.sendRedirect(cp);
					return;
					
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//로그인을 실패한 경우
		req.setAttribute("message", "아이디또는 패스워드가 일치하지 않습니다");
		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}
	
	protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//로그아웃
		HttpSession session=req.getSession();
		
		//세션에 저장된 모든 정보를 지우기 세션을 초기화
		session.invalidate();
		//특정한 정보만 삭제할 경우
		//session.removeAttribute("member");

		
		String cp=req.getContextPath();
		resp.sendRedirect(cp);
	}
	
	protected void memberForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회원가입 폼
		req.setAttribute("mode", "member");
		req.setAttribute("title", "회원 가입");
		String path="/WEB-INF/views/member/member.jsp";
		forward(req, resp, path);
	}
	
	protected void memberSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회원 가입 처리
		
		//코딩하기
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
			
			resp.sendRedirect(cp); //최상위에 있는 파일을 불러오므로 index.jsp가 실행된다
			
			return;
			
		}catch (SQLIntegrityConstraintViolationException e) {
			req.setAttribute("message", "아이디 중복 등의 무결성 제약 조건 위반입니다.");
		}catch (SQLDataException e) {
			req.setAttribute("message", "날짜 형식등이 잘못되었습니다.");
		} catch (Exception e) {
			req.setAttribute("message", "데이터 추가가 실패하였습니다");
		}
		req.setAttribute("mode", "member");
		req.setAttribute("title", "회원 가입");
		String path="/WEB-INF/views/member/member.jsp";
		forward(req, resp, path);
		
	}
	
	protected void pwdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 탈퇴 등에서 패스워드 입력 폼
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		try {
			req.setAttribute("mode", "delete");
			req.setAttribute("userId", info.getUserId());
			req.setAttribute("title", "회원 탈퇴");
			String path="/WEB-INF/views/member/pwd.jsp";
			forward(req, resp, path);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	protected void pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//패스워드 검사
		MemberDAO dao=new MemberDAOImpl();
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		int result=0;
		
		try {
			
			MemberDTO dto=dao.readMember(info.getUserId());
			String pwd=req.getParameter("pwd");
			req.setAttribute("mode", "delete");
			req.setAttribute("title", "회원 탈퇴");
			
			
			if(dto.getUserPwd().equals(pwd)) {
				result=dao.deleteMember(dto.getUserId());
			}
			if(result==0) {
				req.setAttribute("message", "탈퇴에 실패하였습니다");
				String path="/WEB-INF/views/member/pwd.jsp";
				forward(req, resp, path);
				return;
			}
			
			resp.sendRedirect("${pageContext.request.contextPath}/member/logout.do"); //최상위에 있는 파일을 불러오므로 index.jsp가 실행된다
			
			return;
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회원 정보 수정 폼
		req.setAttribute("mode", "update");
		req.setAttribute("title", "회원 정보 수정");
		String path="/WEB-INF/views/member/member.jsp";
		forward(req, resp, path);
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회원 정보 수정 처리
		
		MemberDAO dao=new MemberDAOImpl();
		
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		MemberDTO dto=dao.readMember(info.getUserId());
		
		String cp=req.getContextPath();
		
		try {
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setMemberClass(Integer.parseInt(req.getParameter("memberClass")));
			
			dto.setEmail(req.getParameter("email1")+"@"+req.getParameter("email2"));
			dto.setTel(req.getParameter("tel1")+"-"+req.getParameter("tel2")+"-"+req.getParameter("tel3"));
			String birth=req.getParameter("birth").replaceAll("(\\.|\\-|\\/)", "");
			dto.setBirth(birth);
			
			dao.updateMember(info.getUserId(), dto);
			
			resp.sendRedirect(cp); //최상위에 있는 파일을 불러오므로 index.jsp가 실행된다
			
			return;
			
		}/*catch (SQLIntegrityConstraintViolationException e) {
			req.setAttribute("message", "아이디 중복 등의 무결성 제약 조건 위반입니다.");
		}catch (SQLDataException e) {
			req.setAttribute("message", "날짜 형식등이 잘못되었습니다.");
		}*/ catch (Exception e) {
			req.setAttribute("message", "데이터 추가가 실패하였습니다");
		}
		req.setAttribute("mode", "update");
		req.setAttribute("title", "회원 정보 수정");
		String path="/WEB-INF/views/member/created.jsp";
		forward(req, resp, path);
		
		
	}
	
	protected void userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회원 아이디 중복 검사
		MemberDAO dao=new MemberDAOImpl();
		String cp=req.getContextPath();
		List<String> list=dao.listmember();
		try {
			String userId=req.getParameter("userId");
			
			for(String s : list) {
				if(s.equals(userId)) {
					req.setAttribute("message", "아이디가 중복 됩니다.");
					req.setAttribute("mode", "member");
					req.setAttribute("title", "회원 가입");
					String path="/WEB-INF/views/member/member.jsp";
					forward(req, resp, path);
					return;
				}
			}
				req.setAttribute("mode", "member");
				req.setAttribute("userId", userId);
				req.setAttribute("title", "회원 가입");
				req.setAttribute("message", "사용 가능한 아이디입니다.");
				String path="/WEB-INF/views/member/member.jsp";
				forward(req, resp, path);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
		
	}
	protected void deleteMember(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		
	}
	
	
	
	
}