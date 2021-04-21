package com.kh.dalboo.etc.controller;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.common.Pagination;
import com.kh.dalboo.etc.model.exception.EtcException;
import com.kh.dalboo.etc.model.service.EtcService;
import com.kh.dalboo.etc.model.vo.Faq;
import com.kh.dalboo.etc.model.vo.StartUp;
import com.kh.dalboo.etc.model.vo.Store;



@Controller
public class EtcController {

	@Autowired
	private EtcService eService;
	
	
	//매장 리스트
	@RequestMapping("store.etc")
	public ModelAndView storeList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = eService.getListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Store> list = eService.selectList(pi);
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("store_list");
		} else {
			throw new EtcException("매장 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	//매장 추가(?)쓰이나
	@RequestMapping("insertstore.etc")
	public String insertStore(@ModelAttribute Store s) {
		
		int result = eService.insertStore(s);
		
		if(result > 0) {
			return "redirect:store.etc";
		} else {
			throw new EtcException("매장 등록에 실패하였습니다.");
		}
	}
	
	
	
	//매장 선택
	@RequestMapping("selectstore.etc")
	public void selectStore(int store_num, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8;");
		
		Store s = eService.selectStore(store_num);
		
		JSONObject selectObj = new JSONObject();
		selectObj.put("store_num", s.getStore_num());
		selectObj.put("store_region", s.getStore_region());
		selectObj.put("store_name", s.getStore_name());
		selectObj.put("store_address", s.getStore_address());
		selectObj.put("store_phone", s.getStore_phone());
		
		try {
			PrintWriter out = response.getWriter();
			out.println(selectObj);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	//매장 수정
	@RequestMapping("updatestore.etc")
	public ModelAndView updateStore(Store s, int page, ModelAndView mv) {
		int result = eService.updateStore(s);
		
		if(result > 0) {
			mv.addObject("page", page)
				.addObject("store_num", s.getStore_num())
				.setViewName("redirect:store.etc");
			return mv;
		} else {
			throw new EtcException("매장 수정에 실패하였습니다.");
		}
		
	}
	
	
	
	//매장 삭제
	@RequestMapping("deletestore.etc")
	public String stoDelete(@RequestParam("deleteNum") int store_num) {
		
		int result = eService.deleteStore(store_num);
		
		if(result > 0) {
			return "redirect:store.etc";
		} else {
			throw new EtcException("매장 삭제에 실패하였습니다.");
		}
	}
	
	
	
	//매장 검색
	@RequestMapping("search.etc")
	   public ModelAndView searchStore(@RequestParam(value="currentPage", required = false) Integer currentPage,
	                     @RequestParam(value="option", required = false) String option,
	                     @RequestParam(value="searchText", required = false) String searchText, ModelAndView mv) {
	      
	      HashMap<String, String> map = new HashMap<String, String>();
	      map.put("option", option);
	      map.put("Text", searchText);
	      
	      if(currentPage == null) {
	         currentPage = 1;
	      }
	         int listCount = eService.getSearchListCount(map);
	         PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
	         ArrayList<Store> list = eService.searchStoreList(map, pi);
	         
	            if(list != null) {
	               mv.addObject("list", list);
	               mv.addObject("pi", pi);
	               mv.setViewName("store_list");
	            } else {
	               throw new EtcException("매장 조회에 실패하였습니다.");
	            }
	            
	         return mv;
	   }
	
	
	
	//자주묻는 질문 리스트
	@RequestMapping("faqList.etc")
	public ModelAndView faqList(ModelAndView mv) {
		
		ArrayList<Faq> list = eService.faqList();
		
		if(list != null) {
			mv.addObject("list", list);
			mv.setViewName("faq");
		} else {
			throw new EtcException("FAQ 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	
	
	//창업 절차 뷰
	@RequestMapping("startUpProcedureView.etc")
	public String startUpProcedureView() {
		return "startup_procedure";
	}
	
	//창업 신청 뷰
	@RequestMapping("startupApplyView.etc")
	public String startUpApplyView() {
		return "startup_apply";
	}
	
	
	//창업신청페이지에서 신청
	@RequestMapping("startupApply.etc")
	   public String startUpApply(@ModelAttribute StartUp s,
	                        @RequestParam("address1") String address1) {
	      
	      s.setsAddress(address1);
	      
	      int result = eService.addStartUpApply(s);
	      
	      if(result > 0) {
	         return "redirect:home.do";
	      }else {
	         throw new EtcException("창업문의 신청에 실패하였습니다.");
	      }
	         
	   }
}
