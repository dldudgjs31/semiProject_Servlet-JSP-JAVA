package com.bbs_best;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

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

@WebServlet("/bbs_best/*")
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
		if(uri.indexOf("list.do")!=-1) {
			list(req,resp);
		}else if(uri.indexOf("article.do")!=-1) {
			article(req, resp);
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
		
		int rows=10;
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
			list=dao.listBoard();
		}

		int listNum, n=0;
		for(BoardDTO dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String query="";
		if(keyword.length()!=0) {
			query="condition="+condition+"&keyword="
			         +URLEncoder.encode(keyword,"utf-8");
		}
		String listUrl=cp+"/bbs_best/list.do";
		String articleUrl=cp+"/bbs_best/article.do?page="+current_page;
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
		String path="/WEB-INF/views/bbs_best/list.jsp";
		forward(req, resp, path);
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

			// 조회수
			dao.updateHitCount(num);
			//게시글
			BoardDTO dto = dao.readBoard(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/bbs_best/list.do?");
				return;
			}
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			String path="/WEB-INF/views/bbs_best/article.jsp";
			forward(req, resp, path);
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+"/bbs_best/list.do");
	}

	
}
