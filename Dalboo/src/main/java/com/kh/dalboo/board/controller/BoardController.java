package com.kh.dalboo.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.dalboo.board.model.dao.BoardDAO;
import com.kh.dalboo.board.model.exception.BoardException;
import com.kh.dalboo.board.model.service.BoardService;
import com.kh.dalboo.board.model.vo.Board;
import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.board.model.vo.Reply;
import com.kh.dalboo.common.Pagination;
import com.kh.dalboo.member.model.vo.Member;




@Controller
public class BoardController {

	@Autowired
	private BoardService bService;
	
	
//  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ이벤트 게시판 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ	
	
	@RequestMapping("introduce.bo")
	public String introduce() {
		return"introduce";
	}
	
	@RequestMapping("howtofind.bo")
	public String howtofind() {
		return"howtofind";
	}
	
	
//  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ이벤트 게시판 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	
	//이벤트 게시물 조회
    @RequestMapping("event_list.bo")
    public ModelAndView  boardList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
	  int currentPage = 1; 
	  if(page !=null) {
		  currentPage = page;
	  }
	   
	  int listCount = bService.getListCount();
	  PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
	  
	  ArrayList<Board> list = bService.selectList(pi);
	  if(list !=null) {
		  mv.addObject("list", list);
		  mv.addObject("pi",pi);
		  mv.setViewName("event_list");
	  }else {
		  throw new BoardException("이벤트 게시물 조회에 실패했습니다.");
	  }
	  
      return mv;
   }
    

    //이벤트 게시물 등록폼 접근
    @RequestMapping("event_insertView.bo")
    public String boardInsertView() {
    return "event_register";
    }
    
    
    //이벤트 게시물 등록
    @RequestMapping("event_insert.bo")
    public String boardInsert(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
    	
    	
    	
    	if(uploadFile != null && !uploadFile.isEmpty()) { //첨푸파일이 있다면
    		String renameFileName = saveFile(uploadFile, request);
    		
        	
    		if(renameFileName != null) {
    			b.setRenameFileName(renameFileName);
    			b.setOriginalFileName(uploadFile.getOriginalFilename());
    		}
    	}
    	
    	int result = bService.insertBoard(b);
    	
    	if(result > 0) {
    		return "redirect:event_list.bo";
    	} else {
    		throw new BoardException("게시글 등록에 실패하였습니다.");
    	}
    	
    }
    
    //이벤트 게시물 첨부파일 
    public String saveFile(MultipartFile file, HttpServletRequest request) {
    	String root = request.getSession().getServletContext().getRealPath("resources");
    	
    	String savePath = root + "\\buploadFiles";
    	
    	
    	File folder = new File(savePath);
    	if(!folder.exists()) {
    		folder.mkdirs();
    	}
    		
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    	String originFileName = file.getOriginalFilename();
    	String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + 
    							originFileName.substring(originFileName.lastIndexOf(".") + 1);
    	
    	String renamePath = folder + "\\" + renameFileName;
    		
    	try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
    	return renameFileName;
    }
    
    
    //이벤트 게시물 상세보기
    @RequestMapping("event_detail.bo")
    //public ModelAndView boardDetail(@RequestParam("bNum") int bNum, @RequestParam("page") int page, ModelAndView mv) {
	public ModelAndView boardDetail(@RequestParam(value="bNum",required=false) int bNum, @RequestParam("page") int page, ModelAndView mv) {
    	
    	Board board = bService.selectBoard(bNum);
    	
    	if(board != null) {
    		mv.addObject("board", board)
    		.addObject("page", page)
    		.setViewName("event_detail");
    	} else {
    		throw new BoardException("게시글 상세조회에 실패하였습니다.");
    	}
    	return mv;
    }
    
    
    //이벤트 게시글 수정폼 접근
    @RequestMapping("event_updateView.bo")
    public ModelAndView boardUpdateView(@RequestParam("bNum") int bNum, @RequestParam("page")int page, ModelAndView mv) {
    //public ModelAndView boardUpdateView(@RequestParam(value="bNum",required=false) int bNum, @RequestParam("page")int page, ModelAndView mv) {
    	
    	Board board = bService.selectBoard(bNum);	
    	
    	
    	mv.addObject("board", board)
    	.addObject("page",page)
    	.setViewName("event_update");
    	
    	return mv;
    }
    
    //이벤트 게시글 수정
    @RequestMapping("event_update.bo")
    public ModelAndView boardUpdate(@ModelAttribute Board b, @RequestParam("reloadFile") MultipartFile reloadFile, @RequestParam("page") int page
    		,HttpServletRequest request, ModelAndView mv) {
    	
    	if(reloadFile != null && !reloadFile.isEmpty()) { //새로 변경할 파일이 있다면
    		if(b.getRenameFileName() != null) { //기존에 넣었던 파일이 있다면
    			deleteFile(b.getRenameFileName(), request);
    		}
    		
    		String renameFileName = saveFile(reloadFile, request);
    		
    		if(renameFileName != null) {
    			b.setOriginalFileName(reloadFile.getOriginalFilename());
    			b.setRenameFileName(renameFileName);
    		}
    	}
    	
    	int result = bService.updateBoard(b);
    	
    	mv.addObject("page", page)
    	.addObject("bNum",b.getbNum())
    	.setViewName("redirect:event_detail.bo");
    	
		return mv;
    }
    
    
    
    //이벤트 게시글 첨부파일 수정
    public void deleteFile(String fileName, HttpServletRequest request) {
    	String root = request.getSession().getServletContext().getRealPath("resources");
    	String savePath = root + "\\buploadFiles";
    	
    	File f = new File(savePath + "\\" + fileName);
    	
    	if(f.exists()) {
    		f.delete();
    	}
    }
    
    
    
    //이벤트게시물 삭제
    @RequestMapping("event_delete.bo")
    public String boardDelete(@RequestParam("bNum") int bNum) {
    //public String boardDelete(@RequestParam(value="bNum",required=false) int bNum) {
    	
    	int result = bService.boardDelete(bNum);
    	
    	if(result > 0) {
    		return "redirect:event_list.bo";
    	} else {
    		throw new BoardException("게시물 삭제에 실패하였습니다.");
    	}
    }
    
    
    
    
// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ공지사항 게시판 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 
    
    
    //공지사항 게시물 조회
    @RequestMapping("notice_list.bo")
    public ModelAndView  boardList2(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
	  int currentPage = 1; 
	  if(page !=null) {
		  currentPage = page;
	  }
	   
	  int listCount2 = bService.getListCount2();
	  PageInfo pi = Pagination.getPageInfo(currentPage, listCount2);
	  
	  ArrayList<Board> list = bService.selectList2(pi);
	  if(list !=null) {
		  mv.addObject("list", list);
		  mv.addObject("pi",pi);
		  mv.setViewName("notice_list");
	  }else {
		  throw new BoardException("이벤트 게시물 조회에 실패했습니다.");
	  }
	  
      return mv;
   }
    

    
    //공지사항 게시물 등록폼 접근
    @RequestMapping("notice_insertView.bo")
    public String boardInsertView2() {
    return "notice_register";
    }
    
    //공지사항 게시물 등록
    @RequestMapping("notice_insert.bo")
    public String boardInsert2(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
    	
    	
    	
    	if(uploadFile != null && !uploadFile.isEmpty()) { //첨푸파일이 있다면
    		String renameFileName = saveFile(uploadFile, request);
    		
        	
    		if(renameFileName != null) {
    			b.setRenameFileName(renameFileName);
    			b.setOriginalFileName(uploadFile.getOriginalFilename());
    		}
    	}
    	
    	int result = bService.insertBoard2(b);
    	
    	if(result > 0) {
    		return "redirect:notice_list.bo";
    	} else {
    		throw new BoardException("게시글 등록에 실패하였습니다.");
    	}
    	
    }
    
    //공지사항 게시물 첨부파일 등록
    public String saveFile2(MultipartFile file, HttpServletRequest request) {
    	String root = request.getSession().getServletContext().getRealPath("resources");
    	
    	String savePath = root + "\\buploadFiles";
    	
    	
    	File folder = new File(savePath);
    	if(!folder.exists()) {
    		folder.mkdirs();
    	}
    		
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    	String originFileName = file.getOriginalFilename();
    	String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + 
    							originFileName.substring(originFileName.lastIndexOf(".") + 1);
    	
    	String renamePath = folder + "\\" + renameFileName;
    		
    	try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
    	return renameFileName;
    }
    
    
    //공지사항 게시글 상세조회
    @RequestMapping("notice_detail.bo")
    //public ModelAndView boardDetail(@RequestParam("bNum") int bNum, @RequestParam("page") int page, ModelAndView mv) {
	public ModelAndView boardDetail2(@RequestParam(value="bNum",required=false) int bNum, @RequestParam("page") int page, ModelAndView mv) {
    	
    	Board board = bService.selectBoard2(bNum);
    	
    	if(board != null) {
    		mv.addObject("board", board)
    		.addObject("page", page)
    		.setViewName("notice_detail");
    	} else {
    		throw new BoardException("게시글 상세조회에 실패하였습니다.");
    	}
    	return mv;
    }
    
    
    //공지사항 게시글 수정폼 접근
    @RequestMapping("notice_updateView.bo")
    public ModelAndView boardUpdateView2(@RequestParam("bNum") int bNum, @RequestParam("page")int page, ModelAndView mv) {
    //public ModelAndView boardUpdateView(@RequestParam(value="bNum",required=false) int bNum, @RequestParam("page")int page, ModelAndView mv) {
    	
    	Board board = bService.selectBoard2(bNum);	
    	
    	
    	mv.addObject("board", board)
    	.addObject("page",page)
    	.setViewName("notice_update");
    	
    	return mv;
    }
    
    //공지사항 게시글 수정
    @RequestMapping("notice_update.bo")
    public ModelAndView boardUpdate2(@ModelAttribute Board b, @RequestParam("reloadFile") MultipartFile reloadFile, @RequestParam("page") int page
    		,HttpServletRequest request, ModelAndView mv) {
    	
    	if(reloadFile != null && !reloadFile.isEmpty()) { //새로 변경할 파일이 있다면
    		if(b.getRenameFileName() != null) { //기존에 넣었던 파일이 있다면
    			deleteFile(b.getRenameFileName(), request);
    		}
    		
    		String renameFileName = saveFile(reloadFile, request);
    		
    		if(renameFileName != null) {
    			b.setOriginalFileName(reloadFile.getOriginalFilename());
    			b.setRenameFileName(renameFileName);
    		}
    	}
    	
    	int result = bService.updateBoard2(b);
    	
    	mv.addObject("page", page)
    	.addObject("bNum",b.getbNum())
    	.setViewName("redirect:notice_detail.bo");
    	
		return mv;
    }
    
    
    
    //공지사항 게시글 첨부파일 수정
    public void deleteFile2(String fileName, HttpServletRequest request) {
    	String root = request.getSession().getServletContext().getRealPath("resources");
    	String savePath = root + "\\buploadFiles";
    	
    	File f = new File(savePath + "\\" + fileName);
    	
    	if(f.exists()) {
    		f.delete();
    	}
    }
    
    
    
    //공지사항 게시물 삭제
    @RequestMapping("notice_delete.bo")
    public String boardDelete2(@RequestParam("bNum") int bNum) {
    //public String boardDelete(@RequestParam(value="bNum",required=false) int bNum) {
    	
    	int result = bService.boardDelete2(bNum);
    	
    	if(result > 0) {
    		return "redirect:notice_list.bo";
    	} else {
    		throw new BoardException("게시물 삭제에 실패하였습니다.");
    	}
    }  
    
    
    
    
    
    
    
//  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ고객센터 게시판 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
    
    //고객센터 게시글 조회
    @RequestMapping("customer_service_list.bo")
    public ModelAndView  boardList3(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
	  int currentPage = 1; 
	  if(page !=null) {
		  currentPage = page;
	  }
	   
	  int listCount3 = bService.getListCount3();
	  PageInfo pi = Pagination.getPageInfo(currentPage, listCount3);
	  
	  ArrayList<Board> list = bService.selectList3(pi);
	  if(list !=null) {
		  mv.addObject("list", list);
		  mv.addObject("pi",pi);
		  mv.setViewName("customer_service_list");
	  }else {
		  throw new BoardException("고객센터 게시판 조회에 실패했습니다.");
	  }
	  
      return mv;
   }
    
    //고객센터 게시글 등록폼 접근
    @RequestMapping("customer_service_insertView.bo")
    public String boardInsertView3() {
    return "customer_service_register";
    }
    
    
    //고객센터 게시글 등록
    @RequestMapping("customer_service_insert.bo")
    public String boardInsert3(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
    	
    	
    	
    	if(uploadFile != null && !uploadFile.isEmpty()) { //첨푸파일이 있다면
    		String renameFileName = saveFile(uploadFile, request);
    		
        	
    		if(renameFileName != null) {
    			b.setRenameFileName(renameFileName);
    			b.setOriginalFileName(uploadFile.getOriginalFilename());
    		}
    	}
    	
    	int result = bService.insertBoard3(b);
    	
    	if(result > 0) {
    		return "redirect:customer_service_list.bo";
    	} else {
    		throw new BoardException("문의 등록에 실패하였습니다.");
    	}
    	
    }
    
    
    //고객센터 게시글 첨부파일 등록
    public String saveFile3(MultipartFile file, HttpServletRequest request) {
    	String root = request.getSession().getServletContext().getRealPath("resources");
    	
    	String savePath = root + "\\buploadFiles";
    	
    	
    	File folder = new File(savePath);
    	if(!folder.exists()) {
    		folder.mkdirs();
    	}
    		
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    	String originFileName = file.getOriginalFilename();
    	String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + 
    							originFileName.substring(originFileName.lastIndexOf(".") + 1);
    	
    	String renamePath = folder + "\\" + renameFileName;
    		
    	try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
    	return renameFileName;
    }
    
    //고객센터 게시물 상세조회
    @RequestMapping("customer_service_detail.bo")
	public ModelAndView boardDetail3(@RequestParam(value="bNum",required=false) int bNum, @RequestParam("page") int page, ModelAndView mv) {
    	
    	Board board = bService.selectBoard3(bNum);
    	
    	if(board != null) {
    		mv.addObject("board", board)
    		.addObject("page", page)
    		.setViewName("customer_service_detail");
    	} else {
    		throw new BoardException("문의 상세조회에 실패하였습니다.");
    	}
    	return mv;
    }
    
    
    //고객센터 게시글 수정폼 접근
    @RequestMapping("customer_service_updateView.bo")
    public ModelAndView boardUpdateView3(@RequestParam("bNum") int bNum, @RequestParam("page")int page, ModelAndView mv) {
    	
    	Board board = bService.selectBoard3(bNum);	
    	
    	
    	mv.addObject("board", board)
    	.addObject("page",page)
    	.setViewName("customer_service_update");
    	
    	return mv;
    }
    
    //고객센터 게시글 수정
    @RequestMapping("customer_service_update.bo")
    public ModelAndView boardUpdate3(@ModelAttribute Board b, @RequestParam("reloadFile") MultipartFile reloadFile, @RequestParam("page") int page
    		,HttpServletRequest request, ModelAndView mv) {
    	
    	if(reloadFile != null && !reloadFile.isEmpty()) { //새로 변경할 파일이 있다면
    		if(b.getRenameFileName() != null) { //기존에 넣었던 파일이 있다면
    			deleteFile(b.getRenameFileName(), request);
    		}
    		
    		String renameFileName = saveFile(reloadFile, request);
    		
    		if(renameFileName != null) {
    			b.setOriginalFileName(reloadFile.getOriginalFilename());
    			b.setRenameFileName(renameFileName);
    		}
    	}
    	
    	int result = bService.updateBoard3(b);
    	
    	mv.addObject("page", page)
    	.addObject("bNum",b.getbNum())
    	.setViewName("redirect:customer_service_detail.bo");
    	
		return mv;
    }
    
    
    
    //고객센터 첨부파일 수정
    public void deleteFile3(String fileName, HttpServletRequest request) {
    	String root = request.getSession().getServletContext().getRealPath("resources");
    	String savePath = root + "\\buploadFiles";
    	
    	File f = new File(savePath + "\\" + fileName);
    	
    	if(f.exists()) {
    		f.delete();
    	}
    }
    
    
    
    //고객센터 게시물 삭제
    @RequestMapping("customer_service_delete.bo")
    public String boardDelete3(@RequestParam("bNum") int bNum) {
    	
    	int result = bService.boardDelete3(bNum);
    	
    	if(result > 0) {
    		return "redirect:customer_service_list.bo";
    	} else {
    		throw new BoardException("문의 게시물 삭제에 실패하였습니다.");
    	}
    }
    
//------------------고객센터 댓글 ------------------------------
    
    //고객센터 게시판 댓글 등록
    @RequestMapping("addReply.bo")
    @ResponseBody
    public String addReply(@ModelAttribute Reply r, HttpSession session) {
       Member loginUser = (Member)session.getAttribute("loginUser");
       String rWriter = loginUser.getId();
       
       r.setrWriter(rWriter);
       
       int result = bService.insertReply(r);
       
       if(result > 0) {
          return "success";
       } else {
          throw new BoardException("댓글 등록에 실패했습니다.");
       }
    }
    
    
    
    //고객센터 게시판 댓글 삭제
    @RequestMapping("deleteReply.bo")
    public void delReply(@RequestParam("rNum")int rNum, HttpSession session) {
       Member loginUser = (Member)session.getAttribute("loginUser");
       Reply r = new Reply();
       r.setrId(rNum);
       r.setrWriter(loginUser.getId());
       bService.deleteReply(r);
    }       
    
    //고객센터 댓글 리스트 조회
    
    @RequestMapping("rList.bo")
    public void getReplyList(@RequestParam("bNum") int bNum, HttpServletResponse response) {
       ArrayList<Reply> rList = bService.selectReplyList(bNum);
       
       response.setContentType("application/json; charset=UTF-8");
       Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
       try {
         gson.toJson(rList, response.getWriter());
      } catch (JsonIOException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      }
    }
    
    
    
}