package com.bbs_photo;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

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
@WebServlet("/bbs_photo/*")
public class photoServlet extends MyUploadServlet {

	private static final long serialVersionUID = 1L;

	private String pathname;
	
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri =req.getRequestURI();
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		String root=session.getServletContext().getRealPath("/");
		pathname=root+"uploads"+File.separator+"photo";
		
		if(uri.indexOf("list.do")!=-1) {
			list(req, resp);
		}else if(uri.indexOf("created.do")!=-1) {
			createdForm(req,resp);
		}else if(uri.indexOf("created_ok.do")!=-1) {
			createdSubmit(req,resp);
		}else if(uri.indexOf("article.do")!=-1) {
			article(req,resp);
		}else if(uri.indexOf("update.do")!=-1) {
			updateForm(req,resp);
		}else if(uri.indexOf("update_ok.do")!=-1) {
			updateSubmit(req,resp);
		}else if(uri.indexOf("delete.do")!=-1) {
			delete(req,resp);
		}
		
	}
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PhotoDAO dao = new PhotoDAOImpl();
		MyUtil util= new MyUtil();
		String cp = req.getContextPath();
		
		String page=req.getParameter("page");
		int current_page=1;
		if(page!=null) {
			current_page =Integer.parseInt(page);
			
		}
		int dataCount = dao.dataCount();
		  
		int rows=6;//한페이지에 보여줄 행값 10으로 설정
	      int total_page = util.pageCount(rows, dataCount);//토탈페이지 값 설정
	        if (current_page > total_page) {
	          current_page = total_page;//빈페이지 처리
	
	        }
	        int offset=(current_page-1) * rows; //페이지당 얼만큼 건너 뛰어서 보여주는값
	         if (offset<0) {
	            offset=0;
	         }
	        List<PhotoDTO> list= dao.listPhoto(offset, rows);
	        String listUrl=cp+"/bbs_photo/list.do";
	         String articleUrl=cp+"/bbs_photo/article.do?page="+current_page;
	         String paging=util.paging(current_page, total_page, listUrl);
	       
	         req.setAttribute("list", list);
	         req.setAttribute("dataCount", dataCount);
	         req.setAttribute("total_page", total_page);
	         req.setAttribute("page", current_page);
	         req.setAttribute("paging", paging);
	         req.setAttribute("articleUrl", articleUrl);
	         
	         forward(req, resp, "/WEB-INF/views/bbs_photo/list.jsp");
	}

	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	      req.setAttribute("mode", "created");
	      forward(req,resp, "/WEB-INF/views/bbs_photo/created.jsp");
	}

	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	      String cp=req.getContextPath();
	      HttpSession session=req.getSession();
	      SessionInfo info=(SessionInfo)session.getAttribute("member");
	      PhotoDAO dao=new PhotoDAOImpl();
	      try {
	         PhotoDTO dto=new PhotoDTO();
	         
	         dto.setUserId(info.getUserId());
	         dto.setSubject(req.getParameter("subject"));
	         dto.setContent(req.getParameter("content"));
	         
	         String filename=null;
	         Part p =req.getPart("selectFile");
	         Map<String, String> map=doFileUpload(p, pathname);
	         if(map !=null) {
	        	 filename=map.get("saveFilename");
	            dto.setfileName(filename);
	            
	            dao.insertPhoto(dto);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	      resp.sendRedirect(cp+"/bbs_photo/list.do");
	      
	   }
	

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		  String cp =req.getContextPath();
	      PhotoDAO dao =new PhotoDAOImpl();
	      String page=req.getParameter("page");
	      
	      try {
			int num=Integer.parseInt(req.getParameter("num"));
			PhotoDTO dto = dao.readPhoto(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
				
			}
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			forward(req, resp, "/WEB-INF/views/bbs_photo/article.jsp");
			
			return; //리턴없으면 에러 forward랑 리다리렉트는 동시에 못함
		} catch (Exception e) {
			e.printStackTrace();
			}
	      resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
	      
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String cp = req.getContextPath();
		   HttpSession session =req.getSession();
		   SessionInfo info = (SessionInfo)session.getAttribute("member");
		   PhotoDAO dao =new PhotoDAOImpl();
		   String page =req.getParameter("page");
		   
		   try {
			   int num= Integer.parseInt(req.getParameter("num"));
			   PhotoDTO  dto =dao.readPhoto(num);
			   System.out.println(dto.getFileName());
			   if(dto==null || !info.getUserId().equals(dto.getUserId())) {
				//게시물이 없거나 글을 작성한 사람이 아니면
				   resp.sendRedirect(cp+"/bbs_photo/list.do?page"+page);
				   return;
				   
			   }
				   req.setAttribute("page", page);
				   req.setAttribute("dto", dto);
				   req.setAttribute("mode", "update");
				   
				   forward(req, resp, "/WEB-INF/views/bbs_photo/created.jsp");
				   return;
				   
		} catch (Exception e) {
			e.printStackTrace();
		}
		   resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		   String cp =req.getContextPath();
		   PhotoDAO dao = new PhotoDAOImpl();
		   PhotoDTO dto = new PhotoDTO();
		   
		   if(req.getMethod().equalsIgnoreCase("GET")) {
			   //겟방식으로 접근한 경우
			   resp.sendRedirect(cp+"/bbs_photo/list.do");
			   return;
		   }
		   String page = req.getParameter("page");
		   try {
			
			   String FileName = req.getParameter("fileName");
			
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			Part p =req.getPart("selectFile");
			Map<String, String> map =doFileUpload(p, pathname);
			if(map!=null) {
				
				
				//기존 파일 지우기				파일폴더명,지워야되는파일
				FileManager.doFiledelete(pathname,FileName);
				
				//새로운 이미지를 등록한 경우
				String filename = map .get("saveFilename");
				dto.setfileName(filename);

			}else {
				//이미지 파일을 변경하지 않은경우
				dto.setfileName(FileName);
			
			}
			
			
			dao.updatePhoto(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		   resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
	   }
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		  String cp = req.getContextPath();
		   PhotoDAO dao = new PhotoDAOImpl();
		   HttpSession session = req.getSession();
		   SessionInfo info = (SessionInfo)session.getAttribute("member");
		   
		   String page = req.getParameter("page");
		   
		   try {
			int num=Integer.parseInt(req.getParameter("num"));
			PhotoDTO dto = dao.readPhoto(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
				return;
			}
			//게시글을 작성한 사람이 아니거나 관리자가 아니면
			if(! dto.getUserId().equals(info.getUserId()) && ! info.getUserId().equals("admin")) {
				resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
				return;
			}
			//파일지우기
			FileManager.doFiledelete(pathname,dto.getfileName());
			
			//내용지우기
			dao.deletePhoto(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		   resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
	   }

}
