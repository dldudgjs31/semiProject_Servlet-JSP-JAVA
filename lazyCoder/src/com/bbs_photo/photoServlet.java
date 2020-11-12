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
		  
		int rows=6;//���������� ������ �ప 10���� ����
	      int total_page = util.pageCount(rows, dataCount);//��Ż������ �� ����
	        if (current_page > total_page) {
	          current_page = total_page;//�������� ó��
	
	        }
	        int offset=(current_page-1) * rows; //�������� ��ŭ �ǳ� �پ �����ִ°�
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
			
			return; //���Ͼ����� ���� forward�� ���ٸ���Ʈ�� ���ÿ� ����
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
				//�Խù��� ���ų� ���� �ۼ��� ����� �ƴϸ�
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
			   //�ٹ������ ������ ���
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
				
				
				//���� ���� �����				����������,�����ߵǴ�����
				FileManager.doFiledelete(pathname,FileName);
				
				//���ο� �̹����� ����� ���
				String filename = map .get("saveFilename");
				dto.setfileName(filename);

			}else {
				//�̹��� ������ �������� �������
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
			//�Խñ��� �ۼ��� ����� �ƴϰų� �����ڰ� �ƴϸ�
			if(! dto.getUserId().equals(info.getUserId()) && ! info.getUserId().equals("admin")) {
				resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
				return;
			}
			//���������
			FileManager.doFiledelete(pathname,dto.getfileName());
			
			//���������
			dao.deletePhoto(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		   resp.sendRedirect(cp+"/bbs_photo/list.do?page="+page);
	   }

}
