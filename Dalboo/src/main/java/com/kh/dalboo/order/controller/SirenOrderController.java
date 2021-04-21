package com.kh.dalboo.order.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.common.Pagination;
import com.kh.dalboo.etc.model.exception.EtcException;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;
import com.kh.dalboo.menu.model.exception.MenuException;
import com.kh.dalboo.order.model.service.SirenOrderService;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.order.model.vo.SirenOrderCart;
import com.kh.dalboo.owner.model.vo.StoreStock;

@SessionAttributes("loginUser")
@Controller
public class SirenOrderController {

	@Autowired
	private SirenOrderService soService;
	
	// 사이렌오더
    @RequestMapping("siren_order.cf")
    public ModelAndView siren_orderView(@RequestParam("store_num") int store_num ,ModelAndView mv) {
       
       ArrayList<StoreStock> AllMenuList = soService.AllMenuList(store_num);
       
       if(AllMenuList != null) {
          mv.addObject("store_num", store_num);
          mv.addObject("list", AllMenuList);
          mv.setViewName("sirenorder_list");
       } else {
          throw new MenuException("사이렌 오더 접근에 실패하였습니다.");
       }
       return mv;
    }
	
    
    //커피선택
	@RequestMapping("choiceCoffee.cf")
	public void choiceCoffee(HttpServletResponse resp, String imgPath,@RequestParam("store_num") int store_num) {
		resp.setContentType("application/json; charset=UTF-8;");
		ArrayList<StoreStock> coffee = soService.choiceCoffee(store_num);
		
		Gson gson = new Gson();
		
		try {
			gson.toJson(coffee, resp.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	
	//음료선택
	@RequestMapping("choiceAde.cf")
	public void choiceAde(HttpServletResponse resp, String imgPath, @RequestParam("store_num") int store_num) {
		resp.setContentType("application/json; charset=UTF-8;");
		ArrayList<StoreStock> ade = soService.choiceAde(store_num);
		
		Gson gson = new Gson();
		
		try {
			gson.toJson(ade, resp.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	
	//디저트선택
	@RequestMapping("choiceDessert.cf")
	public void choiceDessert(HttpServletResponse resp, String imgPath, @RequestParam("store_num") int store_num) {
		resp.setContentType("application/json; charset=UTF-8;");
		ArrayList<StoreStock> dessert = soService.choiceDessert(store_num);
		
		Gson gson = new Gson();
		
		try {
			gson.toJson(dessert, resp.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	//신메뉴 선택
	@RequestMapping("choiceNewMenu.cf")
	public void choiceNewMenu(HttpServletResponse resp, String imgPath, @RequestParam("store_num") int store_num) {
		resp.setContentType("application/json; charset=UTF-8;");
		ArrayList<StoreStock> newMenu = soService.choiceNewMenu(store_num);
		
		Gson gson = new Gson();
		
		try {
			gson.toJson(newMenu, resp.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
		
	}
	// 매장 조회
	@RequestMapping("siren.cf")
	public ModelAndView sirenStore(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = soService.getListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Store> list = soService.selectList(pi);
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("sirenorder_store");
		} else {
			throw new EtcException("매장 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	
	
	//사이렌오더 매장 검색
	   @RequestMapping("search.cf")
	   public ModelAndView searchStore(@RequestParam(value="currentPage", required = false) Integer currentPage,
	                     @RequestParam(value="option", required = false) String option,
	                     @RequestParam(value="searchText", required = false) String searchText, ModelAndView mv) {
	      
	      HashMap<String, String> map = new HashMap<String, String>();
	      map.put("option", option);
	      map.put("Text", searchText);
	      
	      if(currentPage == null) {
	         currentPage = 1;
	      }
	         int listCount = soService.getSearchListCount(map);
	         PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
	         ArrayList<Store> list = soService.searchStoreList(map, pi);
	         
	            if(list != null) {
	               mv.addObject("list", list);
	               mv.addObject("pi", pi);
	               mv.setViewName("sirenorder_store");
	            } else {
	               throw new EtcException("매장 조회에 실패하였습니다.");
	            }
	            
	         return mv;
	   }
	   
	
	
	
	
	
	
	
	
	
	
	
	
	//담기한거 조회
	@RequestMapping("soCartList.cf")
	public ModelAndView soCartList(@RequestParam("m_id") String m_id, @RequestParam("store_num") int store_num , ModelAndView mv) {
		
		SirenOrderCart soc = new SirenOrderCart();
		soc.setM_id(m_id);
		soc.setStore_num(store_num);
		
		ArrayList<SirenOrderCart> socList = soService.selectCartList(soc);
				
		int totalPrice = 0;
		
		for(SirenOrderCart cart : socList) {
			int amount = cart.getMaterialprice();
			int price = cart.getSo_cartAmount();
			totalPrice += amount * price;
		}
		// 매장명 받아오기
		Store s = soService.selectStoreList(store_num);
		
		mv.addObject("socList", socList);
		mv.addObject("s", s);
		mv.addObject("totalPrice", totalPrice);
		mv.setViewName("sirenorder_order");
		
		return mv;
	}
	
	
	//장바구니 담기
	@RequestMapping("soCartInsertGo.cf")
	public String soCartInsertGo(@RequestParam("select_stockNum") int [] select_stockNum, @RequestParam("m_id") String m_id,
									@RequestParam("store_num") int store_num) {
		
		int result = 0;
		for(int i = 0; i< select_stockNum.length; i++) {
			SirenOrderCart soc = new SirenOrderCart();
			soc.setStock_num(select_stockNum[i]);
			soc.setM_id(m_id);
			soc.setStore_num(store_num);
			result = soService.insertSOCart(soc);
		}
		
		
		if(result > 0) {
			return "redirect:soCartList.cf?store_num=" + store_num + "&m_id=" + m_id;
		} else {
			throw new EtcException("담기에 실패하였습니다.");
		}
	}
	
	
	
	//장바구니 담기 취소?
	@RequestMapping("soCartInsertBack.cf")
	public String soCartInsertBack(@RequestParam("select_stockNum") int[] select_stockNum, @RequestParam("m_id") String m_id,
								@RequestParam("store_num") int store_num) {
		
		int result = 0;
		SirenOrderCart soc = new SirenOrderCart();
		for(int i = 0; i< select_stockNum.length; i++) {
			soc.setStock_num(select_stockNum[i]);
			soc.setM_id(m_id);
			soc.setStore_num(store_num);
			
			result = soService.insertSOCart(soc);
		}
		
		if(result > 0) {
			return "redirect:siren_order.cf?store_num=" + store_num;
		} else {
			throw new EtcException("담기에 실패하였습니다.");
		}
	}
	
	
	
	// 담은거 수량 감소시키기
	@RequestMapping("minus.cf")
	public String minusAmount(@RequestParam("so_cartNum") int so_cartNum) {
		
		SirenOrderCart soc = soService.selectCart(so_cartNum);
		int store_num = soc.getStore_num();
		String m_id = soc.getM_id();
		
		int result = soService.minusAmount(so_cartNum);
		
		if(result > 0) {
			return "redirect:soCartList.cf?store_num=" + store_num + "&m_id=" + m_id;
		} else {
			throw new EtcException("수량 감소에 실패하였습니다.");
		}
	}
	
	
	//담은거 수량 증가
	@RequestMapping("plus.cf")
	public String plusAmount(@RequestParam("so_cartNum") int so_cartNum) {
		
		SirenOrderCart soc = soService.selectCart(so_cartNum);
		int store_num = soc.getStore_num();
		String m_id = soc.getM_id();
		
		int result = soService.plusAmount(so_cartNum);
		
		if(result > 0) {
			return "redirect:soCartList.cf?store_num=" + store_num + "&m_id=" + m_id;
		} else {
			throw new EtcException("수량 증가에 실패하였습니다.");
		}
	}
	
	
	
	// 담은거 상품 삭제
	@RequestMapping("deleteCart.cf")
	public String soDelete(@RequestParam("so_cartNum") int so_cartNum) {
		
		SirenOrderCart soc = soService.selectCart(so_cartNum);
		int store_num = soc.getStore_num();
		String m_id = soc.getM_id();
		
		int result = soService.soDelete(so_cartNum);
		
		if(result > 0) {
			return "redirect:soCartList.cf?store_num=" + store_num + "&m_id=" + m_id;
		} else {
			throw new EtcException("목록 삭제에 실패하였습니다.");
		}
	}
	
	
	//포인트적립
		@RequestMapping("insertSirenOrder.cf")
		@ResponseBody
		public void insertSirenOrder(@RequestParam("store_num") int store_num, @RequestParam("totalprice") int totalprice, @RequestParam("usingPoint") int usingPoint,
				@RequestParam(value="stock_num[]") List<Integer> stock_num, HttpServletResponse resp, HttpSession session, Model model) {
			
			resp.setContentType("application/json; charset=UTF-8;");
			
			Member member = (Member)session.getAttribute("loginUser");
			String m_id = member.getId();
			int originPoint = member.getPoint();			//기존 포인트
			int changePoint = usingPoint;				//사용 포인트
			
			//포인트 적립 
			int discountPoint = (int)(totalprice * 0.1);		//적립 포인트 (10%적립)
			int afterPoint2 = (originPoint - usingPoint) + discountPoint;	// 기존 포인트 - 사용 포인트 + 적립 포인트
			
			
			SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
			String so_time = timeFormat.format(new Date(System.currentTimeMillis()));
			
			SirenOrder so = new SirenOrder();
			so.setM_id(m_id);
			so.setStore_num(store_num);
			so.setSo_total_price(totalprice);
			so.setSo_time(so_time);
			
			int result = soService.insertSirenOrder(so, stock_num);
			int result2 = soService.makeEmptyCart(m_id);
			
			// 매장 매출 갱신
			Map<String , Integer> map = new HashMap<>();
			map.put("totalprice", totalprice);
			map.put("store_num", store_num);
			int storeSalesUpdate = soService.storeSalesUpdate(map);
			
			
			//먼저 사용한 내역 추가
			PointHistory ph = new PointHistory();
			int result3 = 0;
			
			if(usingPoint > 0) {
				ph.setmId(m_id);
				ph.setEvent("사이렌오더 결제 시 사용");
				ph.setConditions(1);
				ph.setOriginPoint(originPoint);					//기존 포인트
				ph.setChangePoint(changePoint);					//사용 포인트
				ph.setAfterPoint(originPoint - changePoint);	//기존 - 사용
						
				result2 = soService.insertPointHistory(ph);
			}
			
			//적립된 내역 추가
			PointHistory phSaving = new PointHistory();
			int result4 = 0;
			if(discountPoint > 0) {
				phSaving.setmId(m_id);							
				phSaving.setEvent("사이렌 오더 구매 적립");				//적립 이벤트 내용
				phSaving.setConditions(0);						//0:추가 / 1: 사용
				phSaving.setOriginPoint(ph.getAfterPoint());	//기존 포인트
				phSaving.setChangePoint(discountPoint);			//변화한 포인트 (= 적립 내역)
				phSaving.setAfterPoint(afterPoint2);
				
				result3 = soService.insertPointHistory(phSaving);
				
			}
			
			member.setId(m_id);
			member.setPoint(afterPoint2);
			result3 = soService.updateMemberPoint(member);	
			model.addAttribute("loginUser", member);
			
			JSONObject a_yo = new JSONObject();
			a_yo.put("result", result);
			
			try {
				PrintWriter out = resp.getWriter();
				out.println(a_yo);
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
}
