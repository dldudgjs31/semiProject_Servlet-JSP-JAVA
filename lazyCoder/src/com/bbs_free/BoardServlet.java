package com.bbs_free;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyUtil;
@WebServlet("/bbs_free/*")
public class BoardServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp,String path) throws ServletException, IOException {
		RequestDispatcher rd=req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			String cp=req.getContextPath();
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		String uri=req.getRequestURI();
		if(uri.indexOf("list_free.do")!=-1) {
			list(req,resp);
		}else if(uri.indexOf("created.do")!=-1) {
			createdForm(req, resp);
		} else if(uri.indexOf("created_ok.do")!=-1) {
			createdSubmit(req, resp);
		} else if(uri.indexOf("article.do")!=-1) {
			article(req, resp);
		} else if(uri.indexOf("update.do")!=-1) {
			updateForm(req, resp);
		} else if(uri.indexOf("update_ok.do")!=-1) {
			updateSubmit(req, resp);
		} else if(uri.indexOf("delete.do")!=-1) {
			delete(req, resp);
		}
	}
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao = new BoardDAOImpl();
		MyUtil util = new MyUtil();
		String cp =req.getContextPath();
		
		String page = req.getParameter("page");
		int current_page=1;
		if(page!=null) {
			current_page=Integer.parseInt(page);
		}
		
		String condition=req.getParameter("condition");
		String keyword=req.getParameter("keyword");
		if(condition==null) {
			condition="all";
			keyword="";
		}
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "utf-8");
		}
		
		int dataCount;
		if(keyword.length()==0) {
			dataCount=dao.dataCount();
		} else {
			dataCount=dao.dataCount(condition, keyword);
		}
		
		int rows=9;
		int total_page=util.pageCount(rows, dataCount);
		if(current_page>total_page) 
			current_page=total_page;
		
		int offset=(current_page-1)*rows;
		if(offset<0)
			offset=0;
		List<BoardDTO> list;
		if(keyword.length()==0) {
			list =dao.listBoard(offset, rows);
		}else {
			list=dao.listBoard(offset, rows, condition, keyword);
		}
		Date curDate = new Date();
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		int listNum, n=0;
		long gap;
		for(BoardDTO dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			
			try {
				Date date = sdf.parse(dto.getCreated());
				gap=(curDate.getTime() - date.getTime()) / (1000*60*60);
				dto.setGap(gap);
				
			} catch (Exception e) {
			}
			dto.setCreated(dto.getCreated().substring(0, 10));
			//날짜 잘라서 가져오기 
			n++;
		}
		String query="";
		if(keyword.length()!=0) {
			query="condition="+condition+"&keyword="
			         +URLEncoder.encode(keyword,"utf-8");
		}
		String listUrl=cp+"/bbs_free/list_free.do";
		String articleUrl=cp+"/bbs_free/article.do?page="+current_page;
		if(query.length()!=0) {
			listUrl+="?"+query;
			articleUrl+="&"+query;
		}
		String paging=util.paging(current_page, total_page, listUrl);
		
		req.setAttribute("list", list);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("total_page", total_page);
		req.setAttribute("page", current_page);
		req.setAttribute("paging", paging);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("condition", condition);
		req.setAttribute("keyword", keyword);
		
		// JSP로 포워딩
		String path="/WEB-INF/views/bbs_free/list_free.jsp";
		forward(req, resp, path);
		}
	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path="/WEB-INF/views/bbs_free/created.jsp";
		req.setAttribute("mode", "created");
		forward(req, resp, path);
	}
	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao=new BoardDAOImpl();
		BoardDTO dto=new BoardDTO();
		String cp=req.getContextPath();
		
		try {
			HttpSession session=req.getSession();
			SessionInfo info=(SessionInfo)session.getAttribute("member");

			dto.setUserId(info.getUserId()); // 글을 등록한 사람(로그인한 사람)
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			dao.insertBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/bbs_free/list_free.do");
	
	}

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao=new BoardDAOImpl();
		String cp=req.getContextPath();
		
		try {
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			
			String condition=req.getParameter("condition");
			String keyword=req.getParameter("keyword");
			if(condition==null) {
				condition="all";
				keyword="";
			}
			keyword=URLDecoder.decode(keyword,"utf-8");
			
			String query="page="+page;
			if(keyword.length()!=0) {
				query+="&condition="+condition+"&keyword="+
			         URLEncoder.encode(keyword,"utf-8");
			}
			
			// 조회수
			dao.updateHitCount(num);
			
			// 게시글
			BoardDTO dto=dao.readBoard(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/bbs_free/list_free.do?"+query);
				return;
			}
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			// 이전/다음 글
			BoardDTO preReadDto=dao.preReadBoard(num, condition, keyword);
			BoardDTO nextReadDto=dao.nextReadBoard(num, condition, keyword);
			
			req.setAttribute("dto", dto);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);
			req.setAttribute("query", query);
			req.setAttribute("page", page);
			
			String path="/WEB-INF/views/bbs_free/article.jsp";
			forward(req, resp, path);
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+"/bbs_free/list_free.do");
	}

	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao = new BoardDAOImpl();
		String cp =req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String page =req.getParameter("page");
		
		try {
			int num=Integer.parseInt(req.getParameter("num"));
			
			BoardDTO dto = dao.readBoard(num);
			if(dto==null || ! dto.getUserId().equals(info.getUserId())){
				resp.sendRedirect(cp+"/free_bbs/list_free.do?page="+page);
				return;
			}
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");
			String path="/WEB-INF/views/bbs_free/created.jsp";
			forward(req, resp, path);
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+"bbs_free/list_free.do?page="+page);
		}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao =new BoardDAOImpl();
		String cp= req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String page=req.getParameter("page");
		
		try {
			BoardDTO dto = new BoardDTO();
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setUserId(info.getUserId());
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			dao.updateBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+"/bbs_free/list_free.do?page="+page);
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao=new BoardDAOImpl();
		String cp=req.getContextPath();
		
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String page=req.getParameter("page");
		String query="page="+page;
		
		try {
			int num=Integer.parseInt(req.getParameter("num"));
			
			dao.deleteBoard(num, info.getUserId());
			
			String condition=req.getParameter("condition");
			String keyword=req.getParameter("keyword");
			if(condition==null) {
				condition="all";
				keyword="";
			}
			keyword=URLDecoder.decode(keyword,"utf-8");
			
			if(keyword.length()!=0) {
				query+="&condition="+condition+"&keyword="+
			         URLEncoder.encode(keyword,"utf-8");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/bbs_free/list_free.do?"+query);
	
	}
}
