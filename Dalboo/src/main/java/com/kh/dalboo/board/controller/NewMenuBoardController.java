package com.kh.dalboo.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.dalboo.board.model.exception.NewMenuException;
import com.kh.dalboo.board.model.service.NewMenuService;
import com.kh.dalboo.board.model.vo.NewMenuBoard;
import com.kh.dalboo.board.model.vo.NewMenuFiles;
import com.kh.dalboo.board.model.vo.Vote;
import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.common.Pagination;
import com.kh.dalboo.member.model.vo.Member;

@Controller
public class NewMenuBoardController {

	@Autowired
	private NewMenuService nmService;
	
	
	
	//신메뉴 리스트 조회
	@RequestMapping("nList.bo")
	public ModelAndView newMenuList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null ) {
			currentPage = page;
		}
		
		int listCount = nmService.getListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<NewMenuBoard> list = nmService.selectList(pi);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("newmenu_list");
		}else {
			throw new NewMenuException("게시글 전체 조회에 실패했습니다.");
		}
		
		return mv;	
	}
	
	
	
	//신메뉴 작성폼view
	@RequestMapping("menuWrite.bo")
	public String menuInsert() {
		return "newmenu_register";
	}
	
	
	//신메뉴 작성
	@RequestMapping("newMenuinsert.bo")
	   public String newMenuInsert(@ModelAttribute NewMenuBoard b, @RequestParam("uploadFile") MultipartFile[] upFile,
			   				@RequestParam("contentText") String[] contentText, @RequestParam("menuName") String[] menuName, HttpServletRequest request) {
	        ArrayList<NewMenuFiles> files = new ArrayList<NewMenuFiles>();
	        
	        for(int i=0; i < upFile.length; i++) {
	         String root = request.getSession().getServletContext().getRealPath("resources");
	         String savePath = root + "\\nMUploadFiles";
	         
	         File folder = new File(savePath);
		 		if(!folder.exists()) {
		 			folder.getParentFile().mkdirs();
		 		}
	        
	         
	         String originalFileName = upFile[i].getOriginalFilename();
	       
	         String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
	         
	         UUID uuid = UUID.randomUUID();
	         String renameFileName = uuid.toString() + extension;
		
	 			
	        
	         //완성 경로
	         String renamePath = folder + "\\" + renameFileName;
	         try {
	        	 upFile[i].transferTo(new File(renamePath));
	         } catch (IllegalStateException e) {
	            e.printStackTrace();
	         } catch (IOException e) { 
	            e.printStackTrace();
	         }
	      
	         NewMenuFiles fi = new NewMenuFiles();
	         fi.setMenuName(menuName[i]);
	         fi.setContentText(contentText[i]);
	         fi.setChangName(renameFileName);
	         fi.setOriginalName(originalFileName);
	         fi.setFilePath(renamePath);

	         
	         files.add(fi);
	        
	      }
	      int result2 = 0; 
	      int result1 = nmService.insertNmboard(b);
	      if(result1 > 0) {
	    	  for(NewMenuFiles f : files) {
	    		 result2 = nmService.insertNfile(f);
	    	  }
	    	  if(result2 > 0) {
			         return "redirect:nList.bo";
			      } else {
			         throw new NewMenuException("파일저장 실패");
			      }
	      } else {
	         throw new NewMenuException("게시글 저장 실패");
	      }
	       
	   }
	
	
	
	//신메뉴 게시물 상세조회
	   @RequestMapping("nmdetail.bo")
	   public ModelAndView newMenuboardDetail(@RequestParam("nNum") int nNum, @RequestParam("page") int page, ModelAndView mv, HttpSession session) throws ParseException {
	      
	      NewMenuBoard board = nmService.selectBoard(nNum);      
	      String from = board.getVotEndDate();
	      SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
	      Member loginUser = (Member)session.getAttribute("loginUser");
	      String mId  = loginUser.getId();
	      
	      Date to = null;
	      Date today =  new Date();
	      Date endTime = null;      
	      to = fm.parse(from);
	      endTime = to;
	      
	      int compare = today.compareTo(endTime);
	      if(compare > 0) {
	         nmService.voteStatusEnd(nNum);
	      }
	      String status = nmService.BoardvoteStatus(nNum);
	      ArrayList<NewMenuFiles> f = nmService.selectFile(nNum);
	      
	      
	      Vote v = new Vote();
	      v.setmId(mId);
	      v.setnNum(nNum);
	      
	      int voteStatus = nmService.voteStatus(v);
	      if(board != null) {
	         if(status.equals("Y")) {
	            mv.addObject("board", board)
	            .addObject("page", page)
	            .addObject("f", f)
	            .addObject("v", voteStatus)
	            .setViewName("newmenu_detail");
	         }else if(status.equals("N")) {
	            Vote vote = nmService.voteTotalCount(nNum); //투표 결과값 가져오고 거기안에 있는 file 번호로 jsp에서 일치하는 상품 보여주기
	            int fNum = vote.getFileNum();
	            NewMenuFiles file = nmService.voteFileSelect(fNum);
	            mv.addObject("board", board)
	            .addObject("f", file)
	            .addObject("voteResult",vote)
	            .setViewName("newmenu_vote_result");
	         }
	         
	      } else {
	         throw new NewMenuException("게시글 상세보기를 실패하였습니다.");
	      }
	      return mv;
	   }
	
	
	
	//신메뉴 게시물 수정view
	@RequestMapping("newMenuUpdateView.bo")
	public ModelAndView newMenuboardUpdateView(@RequestParam("nNum") int nNum, @RequestParam("page") int page, ModelAndView mv) {
		
		NewMenuBoard board = nmService.selectBoard(nNum);
		ArrayList<NewMenuFiles> f = nmService.selectFile(nNum);
		if(board != null) {
			mv.addObject("board", board)
			.addObject("page", page)
			.addObject("f", f)
			.setViewName("newmenu_update");
		} else {
			throw new NewMenuException("게시글 수정 페이지를 불러오는데 실패하였습니다.");
		}
		return mv;
	}
	
	
	
	//신메뉴 게시물 수정
	@RequestMapping("newMenuUpdate.bo")
	   public String newMenuUpdate(@ModelAttribute NewMenuBoard b, @RequestParam("fileNum") int[] fileNum,
			   				@RequestParam("contentText") String[] contentText, @RequestParam("menuName") String[] menuName, @RequestParam("reuploadFile") MultipartFile[] reuploadFile, HttpServletRequest request) {
	      	
	        int result2 = 0; 
	        for(int i=0; i < menuName.length; i++) {
	        	 if(reuploadFile != null && reuploadFile[i].getSize() > 0) {
	       	         String root = request.getSession().getServletContext().getRealPath("resources");
	       	         String savePath = root + "\\nMUploadFiles";
	       	         
	       	         File folder = new File(savePath);
	       	       
	       		 		if(!folder.exists()) {
	       		 			folder.getParentFile().mkdirs();
	       		 		}
	       	        
	       	         String originalFileName = reuploadFile[i].getOriginalFilename();
	       	         
	       	        	 String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
	       	        
	       	         
	       	         UUID uuid = UUID.randomUUID();
	       	         String renameFileName = uuid.toString() + extension;
	       		
	       	         //완성 경로
	       	         String renamePath = folder + "\\" + renameFileName;
	       	         try {
	       	        	 reuploadFile[i].transferTo(new File(renamePath));
	       	         } catch (IllegalStateException e) {
	       	            e.printStackTrace();
	       	         } catch (IOException e) { 
	       	            e.printStackTrace();
	       	         }
	       	         NewMenuFiles fi = new NewMenuFiles();
	       	         fi.setMenuName(menuName[i]);
	       	         fi.setContentText(contentText[i]);
	       	         fi.setChangName(renameFileName);
	       	         fi.setOriginalName(originalFileName);
	       	         fi.setFilePath(renamePath);
	       	         fi.setFileNum(fileNum[i]);
	       	         fi.setnNum(b.getnNum());
	       	         
		       	      if(fi.getFileNum() == 0) {
		    			result2 = nmService.addinsertNfile(fi);
		    		  }else {
		    			result2 = nmService.updateNfile(fi); 
		    		  }	
	        	}else{
	       	         NewMenuFiles fi = new NewMenuFiles();
	       	         fi.setMenuName(menuName[i]);
	       	         fi.setContentText(contentText[i]);
	       	         fi.setFileNum(fileNum[i]);
	       	         
	       	         result2 = nmService.updateNmFilesContent(fi);
	        	}
	        }
	       
	     
	      if(result2 > 0) {
	    	  int result1 = nmService.updateNmboard(b);
	    	  if(result1 > 0) {
	    		  return "redirect:nList.bo";
	    	  }else {
	    		  throw new NewMenuException("게시글 수정 실패");
	    	  }
	      } else {
	         throw new NewMenuException("파일 수정 실패");
	      }
	       
	   }
	
	
	//신메뉴 게시판 게시물 삭제
	@RequestMapping("deleteNewMenu.bo")
	public String newMenuboardDetail(@RequestParam("nNum") int nNum) {
	
		int result = nmService.deleteNewMenuBoard(nNum);
			
		if(result > 0) {
			return "redirect:nList.bo";
		} else {
			throw new NewMenuException("게시글 삭제에 실패하였습니다.");
		}
	}
	
	
	//투표하기
	@RequestMapping("voteInsert.bo")
	public void VoteCount(@ModelAttribute Vote v, HttpServletResponse response, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String mId  = loginUser.getId();
		v.setmId(mId);
		int result = nmService.voteCount(v);
		
		if(result > 0) {
			try {
				PrintWriter out = response.getWriter();
				out.append("ok");
				out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			throw new NewMenuException("신메뉴 투표에 실패하였습니다.");
		}
	}
	
	
	
	//투표 삭제
	@RequestMapping("deleteVoteMenu.bo")
	public void deleteVoteMenu(@RequestParam("fNum") int fNum) {
		
		int result = nmService.voteMenuDelete(fNum);
		
		if(result < 0) {
			throw new NewMenuException("이미지 삭제에 실패하였습니다.");
		}
	}
	
	
	//취소버튼 누르면 삭제되었던 파일들 복구
	@RequestMapping("cancelUpdateRollback.bo")
	public void cancelUpdateRollback(@RequestParam("nNum") int nNum) {
		
		int result = nmService.rollbackUpdate(nNum);
		
		if(result < 0) {
			throw new NewMenuException("이미지 삭제에 실패하였습니다.");
		}
	}
	
	
	

}