package com.know;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.member.SessionInfo;
import com.util.FileManager;
import com.util.MyUploadServlet;
import com.util.MyUtil;

@MultipartConfig
@WebServlet("/bbs_know/*")
public class KnowBoardServlet extends MyUploadServlet {
	private static final long serialVersionUID = 1L;
	private String pathname;
	
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
		rd.forward(req, resp);
	}

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
	      
	      String uri=req.getRequestURI();
	      String cp=req.getContextPath();
	      
	      HttpSession session=req.getSession();
	      SessionInfo info=(SessionInfo)session.getAttribute("member");
	      if(info==null) {
	         resp.sendRedirect(cp+"/member/login.do");
	         return;
	      }
	      
	      // �̹��� ���� ���
	      // �̹����� �ݵ�� ��Ʈ �Ʒ��� ������ ����� �÷��� ��
	      String root=session.getServletContext().getRealPath("/");
	      pathname=root+"uploads"+File.separator+File.separator+"photo";
	      
	      
	      
		if(uri.indexOf("list.do")!=-1) {
			list(req,resp);
		} else if(uri.indexOf("created.do")!=-1) {
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
		KnowBoardDAO dao=new KnowBoardImpl();
	      MyUtil util=new MyUtil();
	      String cp=req.getContextPath();
	      
	      String page=req.getParameter("page");
	      int current_page=2;
	      if(page!=null) {
	         current_page=Integer.parseInt(page);
	      }
	      
	      int dataCount=dao.dataCount();
	

	      int rows=9;
	      int total_page=util.pageCount(rows, dataCount);
	      if(current_page>total_page)
	         current_page=total_page;
	      
	      int offset=(current_page-1)*rows;

	      if(offset<0)
	         offset=0;
	      
	      List<KnowBoardDTO> list=dao.listKnowBoard(offset, rows);

	      String listUrl=cp+"/bbs_know/list.do";
	      String articleUrl=cp+"/bbs_know/article.do?page="+current_page;
	      String paging=util.paging(current_page, total_page, listUrl);
	      
	      req.setAttribute("list", list);
	      req.setAttribute("dataCount", dataCount);
	      req.setAttribute("total_page", total_page);
	      req.setAttribute("page", current_page);
	      req.setAttribute("paging", paging);
	      req.setAttribute("articleUrl", articleUrl);
	
	      forward(req, resp, "/WEB-INF/views/bbs_know/list.jsp");
	}	
	
	
	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 req.setAttribute("mode", "created");
	      forward(req, resp, "/WEB-INF/views/bbs_know/created.jsp");
	}
	
	
	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp=req.getContextPath();
	      HttpSession session=req.getSession();
	      SessionInfo info=(SessionInfo)session.getAttribute("member");
	      
	      KnowBoardDAO dao=new KnowBoardImpl();
	      try {
	    	  KnowBoardDTO dto=new KnowBoardDTO();
	         
	         dto.setUserId(info.getUserId());
	         dto.setBookName(req.getParameter("bookName"));
	         dto.setBookInfo(req.getParameter("bookInfo"));
	         dto.setContent(req.getParameter("content"));
	         dto.setRating(Integer.parseInt(req.getParameter("rating")));
	         
	         String filename=null;
	         Part p=req.getPart("selectFile");
	         Map<String, String> map=doFileUpload(p, pathname);
	         if(map != null) {
	            filename=map.get("saveFilename");
	            dto.setImageFilename(filename);
	            
	            dao.insertKnowBoard(dto); // �̹����� �������� ������ DB�� �������� ����
	         }
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      resp.sendRedirect(cp+"/bbs_know/list.do");
	   }
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		  String cp=req.getContextPath();
		  KnowBoardDAO dao=new KnowBoardImpl();
	      String page=req.getParameter("page");
	      
	      try {
	         int num=Integer.parseInt(req.getParameter("num"));
	         KnowBoardDTO dto=dao.readKnowBoard(num);
	         if(dto==null) {
	            resp.sendRedirect(cp+"/bbs_know/list.do?page="+page);
	            return;
	         }
	         dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
	         
	         req.setAttribute("dto", dto);
	         req.setAttribute("page", page);
	         
	         forward(req, resp, "/WEB-INF/views/bbs_know/article.jsp");      
	         return;
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp=req.getContextPath();
	      HttpSession session=req.getSession();
	      SessionInfo info=(SessionInfo)session.getAttribute("member");
	      KnowBoardDAO dao=new KnowBoardImpl();
	      String page=req.getParameter("page");
	      
	      try {
	         int num=Integer.parseInt(req.getParameter("num"));
	         KnowBoardDTO dto=dao.readKnowBoard(num);
	         
	         if(dto==null || ! info.getUserId().equals(dto.getUserId())) {
	            // �Խù��� ���ų� ���� �ۼ��� ����� �ƴϸ�
	            resp.sendRedirect(cp+"/bbs_know/list.do?page="+page);
	            return;
	         }
	         
	         req.setAttribute("page", page);
	         req.setAttribute("dto", dto);
	         req.setAttribute("mode", "update");
	         
	         forward(req, resp, "/WEB-INF/views/bbs_know/created.jsp");
	         return;
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	      resp.sendRedirect(cp+"/bbs_know/list.do?page="+page);
	   }
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String cp=req.getContextPath();
		 KnowBoardDAO dao=new KnowBoardImpl();
		 KnowBoardDTO dto=new KnowBoardDTO();
	      
	      if(req.getMethod().equalsIgnoreCase("GET")) {
	         // GET ������� ������ ���
	         resp.sendRedirect(cp+"/photo/list.do");
	         return;
	      }
	      
	      String page=req.getParameter("page");
	      
	      try {
	         String imageFilename=req.getParameter("imageFilename");
	         
	         dto.setNum(Integer.parseInt(req.getParameter("num")));
	         dto.setBookName(req.getParameter("bookName"));
	         dto.setContent(req.getParameter("content"));
	         
	         
	         Part p=req.getPart("selectFile");
	         Map<String, String> map=doFileUpload(p, pathname);
	         if(map!=null) {
	            // ���ο� �̹����� ����� ���
	            String filename=map.get("saveFilename");
	            dto.setImageFilename(filename);
	            
	            // ���� ���� �����
	            FileManager.doFiledelete(pathname, imageFilename);
	            
	         } else {
	            // �̹��� ������ �������� ���� ���
	            dto.setImageFilename(imageFilename);
	         }
	         
	         dao.updateKnowBoard(dto);
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      resp.sendRedirect(cp+"/bbs_know/list.do?page="+page);
	      
	   }
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	      String cp = req.getContextPath();
	      KnowBoardDAO dao = new KnowBoardImpl();
	      HttpSession session = req.getSession();
	      SessionInfo info = (SessionInfo) session.getAttribute("member");

	      String page = req.getParameter("page");

	      try {
	         int num = Integer.parseInt(req.getParameter("num"));
	         KnowBoardDTO dto = dao.readKnowBoard(num);
	         if (dto == null) {
	            resp.sendRedirect(cp + "/photo/list.do?page=" + page);
	            return;
	         }

	         // �Խñ��� �ۼ��� ����� �ƴϰų� �����ڰ� �ƴϸ�
	         if (!dto.getUserId().equals(info.getUserId()) && !info.getUserId().equals("admin")) {
	            resp.sendRedirect(cp + "/photo/list.do?page=" + page);
	            return;
	         }

	         // ���� �����
	         FileManager.doFiledelete(pathname, dto.getImageFilename());

	         // ���� �����
	         dao.deleteKnowBoard(num);

	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      resp.sendRedirect(cp + "/bbs_know/list.do?page=" + page);
	   }
	
}
