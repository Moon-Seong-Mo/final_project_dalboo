package com.kh.dalboo.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.common.Pagination;
import com.kh.dalboo.member.model.exception.MemberException;
import com.kh.dalboo.member.model.service.MemberService;
import com.kh.dalboo.member.model.vo.Address;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.owner.model.vo.StoreStock;

@SessionAttributes("loginUser")
@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	
	

	
	
	
	

	@RequestMapping("login.me")
	public void login() {
	
	}
	
	@RequestMapping("myPage.me")
	public void myPage() {
	}
	
	
	//로그인
		@RequestMapping("logingo.me")
		@ResponseBody
		public String login(@RequestParam("id") String id, @RequestParam("pwd") String pwd,  Model model) {
			
			Member m  = new Member();
			m.setId(id);
			m.setPwd(pwd);
			
			Member loginUser = mService.memberLogin(m);

			boolean b = false;
			if(loginUser != null) {
				b = bcrypt.matches(m.getPwd(), loginUser.getPwd());
			}
			
			if(b == true) {
				model.addAttribute("loginUser", loginUser);
				return "success";
			}  else {
				return "false";
			}
		}
	
	//로그아웃
	@RequestMapping("logout.me")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/home.do";
//		return "redirect:/index.jsp";
	}
	
	
	//회원가입폼 접근
	@RequestMapping("joinView.me")
	public String joinView() {
		return "join";
	}
	
	
	// 회원가입
	@RequestMapping("join.me")
	public ModelAndView memberJoin(@ModelAttribute Member m, @RequestParam("phone1") String phone1,
			@RequestParam("phone2") String phone2, @RequestParam("phone3") String phone3, ModelAndView mv) {

		String encPwd = bcrypt.encode(m.getPwd());
		m.setPwd(encPwd);

		int originPoint = m.getPoint();
		m.setPoint(100); // 100포인트 미리 적립

		// 전화번호 합치기
		m.setPhone(phone1 + phone2 + phone3);

		int result = mService.joinMember(m);

		if (result > 0) {

			// 회원가입이 잘 되었다면
			String mId = m.getId();

			// 변화된 포인트 값 넘김
			PointHistory ph = new PointHistory();
			ph.setmId(mId);
			ph.setEvent("회원가입 이벤트");
			ph.setConditions(0); // 적립은 0
			ph.setOriginPoint(originPoint); // 처음 변화가 없는 포인트
			ph.setChangePoint(m.getPoint()); // 원래는 얼마 적립인지 쓴건지 써야하는데 회원가입이니까 이렇게만쓴다!
			ph.setAfterPoint(m.getPoint()); // 적립된 포인트 가져옴

			result = mService.insertMemberUpdatePoint(ph);
		}
		
		String path = "		alert(\"회원가입 적립 100포인트! \\n감사합니다\");\r\n" + 
				"		location.href='login.me';";
		
		if (result > 0) {
			//return "redirect:home.do";
			mv.addObject("path", path).setViewName("alert");
		} else {
			throw new MemberException("회원가입에 실패했습니다");
		}
		return mv;
	}
	
	
		
	
	//내 정보 수정
	@RequestMapping("update_infoView.me")
	public String updateInfoView() {
		return "update_info";
	}
	
	//내 정보 수정
	@RequestMapping("update_info.me")
	public String memberUpdate(@ModelAttribute Member m, Model model) {
	
	int result = mService.updateMember(m);
	System.out.println(m);
	
	if(result > 0) {
		model.addAttribute("loginUser", m);
      return "myPage";
   } else {
      throw new MemberException("정보 수정에 실패했습니다");
   		}
   }
	
	//내 비밀번호 수정폼 접근
	@RequestMapping("update_pwdView.me")
	public String updatePwdView() {
		return "update_pwd";
	}
	
	//내 비밀번호 수정
	@RequestMapping("update_pwd.me")
	public String updatePwd(@RequestParam("pwd") String pwd, @RequestParam("newPwd1") String newPwd,
			HttpSession session) {
		
		Member m = mService.memberLogin((Member)session.getAttribute("loginUser"));
		
		
		
		if(bcrypt.matches(pwd,m.getPwd())) {
			
			String encNewPwd = bcrypt.encode(newPwd);
			m.setPwd(encNewPwd);
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", m.getId());
			map.put("newPwd", encNewPwd);
			
			int result = mService.updatePwd(map);
			
			if(result>0) {
				return "myPage";
			} else {
				throw new MemberException("비밀번호 수정에 실패 하였습니다.");
			}
			
		}else {
			throw new MemberException("기존 비밀번호가 일치하지 않습니다.");
		}
	}
	
	
	
	
	
	//아이디 중복검사
	@RequestMapping("dupid.me")
   public void idDuplicateCheck(@RequestParam("id") String id, HttpServletResponse response) {
      boolean isUsable = mService.checkIdDup(id) == 0 ? true : false;
      try {
         response.getWriter().print(isUsable);
         
      } catch (IOException e) {
         e.printStackTrace();
      }
   }
	
	
	
	
	
//	ㅡㅡㅡㅡㅡㅡㅡ아이디 찾기 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	//아이디 찾기 폼 접근
	@RequestMapping("findIdView.me")
	public String findIdView() {
		return "findId";
	}
	
	
	

	
	
	@RequestMapping("findId.me")
	   public ModelAndView findId(Member m, @RequestParam("phone1") String phone1, @RequestParam("phone2") String phone2,  @RequestParam("phone3") String phone3, ModelAndView mv) {
	      
	      m.setPhone(phone1 + phone2 + phone3);

	      Member member = mService.findId(m);

	      if (member != null) {
	         mv.addObject("member", member).setViewName("findIdResult");
	      } else {
	         mv.addObject("msg", "일치하는 아이디가 존재하지 않습니다.").setViewName("findIdResult");
	      }
	      return mv;
	   }

	
	
//	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ비밀번호 찾기(이메일) 및 임시 비밀번호 발급 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	//비밀번호 찾기 폼 접근
		@RequestMapping("findpwdView.me")
		public String findpwdView() {
			return "findPwd";
		}
	
	
		// 가입된 이메일인지 확인
		@RequestMapping("signUpedEmail")
		@ResponseBody
		public int signUpedEmail(String email) {
			
			int result = 0;
			try {
				result = mService.signUpedEmail(email);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return result;
		}
		//이메일 확인
		@RequestMapping("emailCertify")
		@ResponseBody
		public String emailCertify(HashMap<String, String> map) throws Exception{
			int result = 0;
			
			result = mService.emailCertify(map);
			
			
			return Integer.toString(result);
			
		}
		
		// 비밀번호 찾기(임시 비밀번호 전송)
		@RequestMapping("findPwd.me")
		public String findPwd(String id,String email, Model model, RedirectAttributes rdAttr) {
			
			try {
				HashMap<String,String> map = new HashMap<String,String>();
				map.put("id", id);
				map.put("email", email);
				int result = mService.emailCertify(map);
		
				
				if(result > 0) {
					model.addAttribute("msg","메일전송에 성공하였습니다.");
					model.addAttribute("url","login.me");
					
				}else {
					model.addAttribute("msg","아이디와 이메일이 불일치하여 메일 전송에 실패하였습니다.");
					model.addAttribute("url", "findpwdView.me");
				}
				
				return "redirect";
				
			}catch(Exception e) {
				e.printStackTrace();
				model.addAttribute("message", "비밀번호 찾기 과정 중 오류 발생");
				return "/../common/errorPage";
			}
		}

		
		
		
		//이메일 인증을 통한 비번 변경창
		@RequestMapping("update_pwd_email.me")
		public String findpwdemialView() {
			return "update_pwd_email";
		}
		
		
		
		//지원
		
		
		@RequestMapping("addressList.me")
		public ModelAndView my_address(HttpSession session, ModelAndView mv) {
			
			Member loginUser = (Member)session.getAttribute("loginUser");
			String id = loginUser.getId();
			
			ArrayList<Address> adlist = mService.selectAddress(id);
			
			mv.addObject("adlist", adlist).addObject("id", id).setViewName("my_address");
			
			return mv;
		}
		
		
		@RequestMapping("insertAddressView.me")
		public void insertAddressView() {
		}
		
		@RequestMapping("insertAddress.me")
		public ModelAndView insertAddress(@ModelAttribute Address add, @RequestParam("postal") String postal,
				@RequestParam("address1") String address1, @RequestParam("address2") String address2,
				@RequestParam("phone1") String phone1, @RequestParam("phone2") String phone2,
				@RequestParam("phone3") String phone3, HttpSession session, ModelAndView mv) {

			String adAddress = postal + address1 + address2;
			String adPhone = phone1 + phone2 + phone3;

			Member loginUser = (Member) session.getAttribute("loginUser");
			String id = loginUser.getId();

			add.setAdAddress(adAddress);
			add.setAdPhone(adPhone);
			add.setId(id);

			int result = mService.insertAddress(add);

			String path = "window.close();";

			if (result > 0) {
				mv.addObject("path", path).setViewName("alert");
			} else {
				throw new MemberException("배송지 추가 실패");
			}
			return mv;
		}

		@RequestMapping("deleteAddress.me")
		public ModelAndView deleteAddress(@RequestParam("chkArr") int[] chkArr, ModelAndView mv) {

			Address ad = new Address();

			int result = 0;
			for (int i = 0; i < chkArr.length; i++) {
				ad.setAdNum(chkArr[i]);
				result = mService.deleteAddress(ad);
			}

			String path = "	alert(\"배송지를 삭제하였습니다.\");\r\n" + "location.href='addressList.me';";

			if (result > 0) {
				mv.addObject("path", path).setViewName("alert");
				return mv;
			} else {
				throw new MemberException("배송지 삭제 실패");
			}
		}

		@RequestMapping("updateBaseAdd.me")
		public String baseAddInsert(@RequestParam("adNum") int adNum, HttpSession session) {

			// 기본 한 번 더 누르면 기본이 다 사라지도록 한다음 내가 받아온 것만 기본으로 만든다!. 아이디 넘기기
			Member loginUser = (Member) session.getAttribute("loginUser");
			String id = loginUser.getId();

			int result = mService.updateBaseAdd(adNum, id);

			if (result > 0) {
				return "redirect:addressList.me";
			} else {
				throw new MemberException();
			}
		}

		@RequestMapping("myPointList.me")
		public ModelAndView myPointList(@RequestParam(value = "page", required = false) Integer page, HttpSession session,
				ModelAndView mv) {

			String mId = ((Member) session.getAttribute("loginUser")).getId();

			int currentPage = 1;

			if (page != null) {
				currentPage = page;
			}

			// 전체 개시물 개수
			int listCount = mService.getpointListCount(mId);

			// 페이징 계산
			PageInfo pi = Pagination.getFivePageInfo(currentPage, listCount);

			ArrayList<PointHistory> phList = mService.selectPointList(mId, pi);
			
			mv.addObject("phList", phList).addObject("pi", pi).setViewName("my_point");
			return mv;
		}
		
		
		
		
		
		
		
		
		
		
		
		//성모
	// 커피 주문 목록
	@RequestMapping("coffeeOrderView.me")
	public ModelAndView coffee_orderList(@RequestParam(value="page", required=false) Integer page,HttpSession session, ModelAndView mv) {
		
		String id = ((Member)session.getAttribute("loginUser")).getId();
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
					
		
		//전체 개시물 개수
		int listCount = mService.getCoffeeListCount(id);
		//페이징 계산
		PageInfo pi = Pagination.getPageEightInfo(currentPage, listCount);
		
		
		List<SirenOrder> soList = mService.coffee_orderList(id, pi);
		
		if(soList != null) {
			mv.addObject("soList", soList).addObject("pi", pi).setViewName("my_coffee_order_list");
		} else {
			throw new MemberException("주문 내역 조회 실패");
		}
		return mv;
	}
	// 주문완료 시 재고 감소
	@RequestMapping("updateStock.me")
	public String updateStock(@RequestParam("stock_num") int[] stock_num, 
								@RequestParam("so_cartAmount") int [] so_cartAmount) {
		
		StoreStock ss = new StoreStock();
		int result = 0;
		
		for(int i = 0; i < stock_num.length; i++) {
			ss.setStock_num(stock_num[i]);
			ss.setMaterialAmount(so_cartAmount[i]);
			result = mService.updateStock(ss);
		}
		
		
		if(result > 0) {
			return "redirect:coffeeOrderView.me";
		} else {
			throw new MemberException();
		}
	}
		
	
	
	
	
	
	
	

	   @RequestMapping("memberDelete.me")
	   @ResponseBody
	   public String MemberDelete(@RequestParam("id") String id, @RequestParam("pwd") String pwd, HttpSession session,
	         HttpServletResponse response) {

	      // 아이디와 세션의 아이디가 일치하며 비밀번호가 일치할 때 회원탈퇴가 된다.
	      Member loginUser = (Member) session.getAttribute("loginUser");

	      int result = 0;
	      if (loginUser.getId().equals(id)) {
	         if (bcrypt.matches(pwd, loginUser.getPwd())) {
	            result = mService.deleteMember(id);
	         }
	      }
	      if (result > 0) {
	         return "success";
	      } else {
	         return "false";
	      }

	   }
	
	
	
	
	
	
		

}
