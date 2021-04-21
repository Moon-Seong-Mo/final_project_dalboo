package com.kh.dalboo.owner.controller;

import java.io.File;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.dalboo.board.model.exception.NewMenuException;
import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.common.Pagination;
import com.kh.dalboo.etc.model.exception.EtcException;
import com.kh.dalboo.etc.model.vo.StartUp;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.manager.model.vo.CoffeeStock;
import com.kh.dalboo.mdProduct.model.vo.MdOrder;
import com.kh.dalboo.member.model.exception.MemberException;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.owner.model.service.EmailSender;
import com.kh.dalboo.owner.model.service.OwnerService;
import com.kh.dalboo.owner.model.vo.OwnerNewMenuBoard;
import com.kh.dalboo.owner.model.vo.OwnerNewMenuFiles;
import com.kh.dalboo.owner.model.vo.OwnerNotice;
import com.kh.dalboo.owner.model.vo.Search;
import com.kh.dalboo.owner.model.vo.StoreStock;
import com.kh.dalboo.member.model.vo.Member;


@SessionAttributes("loginUser")
@Controller
public class OwnerController {
   
	   @Autowired
	   private OwnerService owService;
	   
	   @Autowired
	   private BCryptPasswordEncoder bcrypt;
	   
	   @Autowired
	   @Qualifier("emailSender")
	   private EmailSender emailSender;
		   
		   //창업신청 리스트
		   @RequestMapping("startUpList.ow")
		   public ModelAndView applyListView(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		      
		      int currentPage = 1;
		      if(page != null ) {
		         currentPage = page;
		      }
		      
		      int listCount = owService.getApplyListCount();
		      PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		      
		      ArrayList<StartUp> list = owService.selectApplyList(pi);
		      
		      
		      if(list != null) {
		         mv.addObject("list", list);
		         mv.addObject("pi", pi);
		         mv.setViewName("owner_startup_apply_list");
		      }else {
		         throw new EtcException("창업문의 전체 조회에 실패했습니다.");
		      }
		      
		      return mv;   
		   }
		 //로그인페이지
	         @RequestMapping("ownerLoginPage.ow")
	         public String ownerLoginPageView(SessionStatus status, HttpSession session) {
	            // 가맹주관리 버튼 클릭시 session 살아 있을 경우
	            if(session != null) {
	               session.invalidate(); // 메인 페이지 세션 초기화
	            }
	            // 로그인 페이지 접근시 가맹주 세션이 살아 있을 경우
	            if(!status.isComplete()) {
	               status.setComplete(); // 가맹주 페이지 세션 초기화
	            }
	            
	            return "owner_login";
	         }
		   
		   //로그아웃
		   @RequestMapping("logout.ow")
		   public String logout(SessionStatus status) {
		      status.setComplete();
		      return "redirect:ownerLoginPage.ow";
		   }
		   
		   
		   //오너페이지  로그인 + 매출 + 공지사항 리스트
		      @RequestMapping("ownerLogin.ow")
		      @ResponseBody
		      public String ownerLogin(@RequestParam("userCode") String userCode,
		                              @RequestParam("userName") String userName, Model model) {
		         
		        Store s = new Store();
		        s.setStore_name(userName);
		        s.setStore_login_code(userCode);
		        
		         Store loginUser = owService.ownerLogin(s);
		         boolean b = false;
		         if(loginUser != null) {
//		            b = bcrypt.matches(userCode, loginUser.getStore_login_code());
		            b = bcrypt.matches(s.getStore_login_code(), loginUser.getStore_login_code());
		         }
		         
		         
		         if(b == true) {
		            model.addAttribute("loginUser", loginUser);
		            return "success";
		         } else {
		            return "false";
		         }
		      }
		
		      
		    //관리자가 메인페이지 로그인하고 [창업신청 관리] 눌렀을 때 or 점주전용에서 가맹주가 또는 관리자가 로그인하였을 때    
			   //가맹주 페이지 메인화면 (파이차트,공지사항,총매출)
			   @RequestMapping("ownerMain.ow")
			   public ModelAndView ownerMainNotice(ModelAndView mv, HttpSession session) {
			      
			      int rank = ((Store)session.getAttribute("loginUser")).getRank_code();
			      
			      
			      int store_num = ((Store)session.getAttribute("loginUser")).getStore_num();
			      
			      List<Store> sales = null;
			      List<SirenOrder> chart = null;
			      List<MdOrder> mdSales = null;
			      List<StoreStock> chart2 = null;
			      ArrayList<OwnerNotice> onlist = null;
			      // 관리자 로그인 경우
			      if(rank == 2) {
			         sales = owService.selectSalesAll();      // 전체 매장 재고
			         mdSales = owService.selectMdAllSales();      // md상품 총 매출
			         chart = owService.selectdoughnut();      // 매장별 매출액 top 5
			         onlist = owService.selectOwnerMainNoticeList(); // 공지사항 리스트
			         
			         //MD매출(일단보류)
			         int mdTotalSales = 0;
//			         for(MdOrder sale : mdSales) {
//			            int salesAmount = sale.getTotalPrice();
//			            mdTotalSales += salesAmount;
//			         }
			         
			         // 매장 매출
			         int totalSales = 0;
			         for(Store sale : sales) {
			            int salesAmount = sale.getTotalprice();
			            totalSales += salesAmount;
			         }
			         
			         mv.addObject("onlist", onlist)
			         .addObject("totalSales", totalSales)
			         .addObject("chart", chart)
			         .addObject("mdTotalSales", mdTotalSales)
			         .setViewName("owner_main");
			         
			         return mv;
			         
			         // 가맹주 로그인 경우
			      } else if(rank == 1){ 
			         sales = owService.selectSalesMyStore(store_num);   // 내 매장 재고
			         onlist = owService.selectOwnerMainNoticeList(); // 공지사항 리스트
			         chart2 = owService.selectBarChart(store_num); //남은 재고량 막대 차트
			         
			         // 막대 그래프 chart에 값 담아서 보내주면됨 or 새로 보내도됨
			         
			         
			         
			         // 매장 매출
			         int totalSales = 0;
			         for(Store sale : sales) {
			            int salesAmount = sale.getTotalprice();
			            totalSales += salesAmount;
			         }
			         
			         
			         mv.addObject("onlist", onlist)
			         .addObject("totalSales", totalSales)
			         .addObject("chart2",chart2)
			         .setViewName("owner_main");
			         
			         
			         return mv;
			      } else {
			         throw new EtcException("로그인에 실패했습니다.");
			      }
			      
			   }
		
		   
		   //기본페이지 이동
		   @RequestMapping("defaultPage.ow")
		   public String defaultPage(SessionStatus status) {
		      status.setComplete();  //오너페이지에서 기본페이지로 이동시 로그아웃시킴
		      return "redirect:home.do";
		   }
		   
		   
		   //창업신청 디테일
		   @RequestMapping("applydetail.ow")
		   public ModelAndView boardDetail(@RequestParam("sNum") int sNum, @RequestParam("page") int page, ModelAndView mv) {
		      StartUp s = owService.selectApplydetail(sNum);
		      if(s != null) {
		         mv.addObject("s", s)
		         .addObject("page",page)
		         .setViewName("owner_startup_apply_detail");
		      } else {
		         throw new EtcException("창업문의 상세보기를 실패하였습니다.");
		      }
		      return mv;
		   }
		   
		   //창업신청 승인(로그인키 발급), 거절
		    @RequestMapping("startUpApplyChk.ow")
		    public void startUpApplyCheck(@RequestParam("sNum") int sNum, @RequestParam("chkBtn") String str, HttpServletResponse response) {
		       
		       
		       Store store = new Store();
		       StartUp s = new StartUp();
		       s.setsNum(sNum);
		       s.setsConfirm(str);
		
		       HashMap<String, String> map = new HashMap<String, String>();
		       int result = 0;
		       int result2 = 0;
		       if(str.equals("승인")) {//승인 버튼을 클릭 했을때 (store테이블)로그인 코드 발급하는 로직
		          
		          
		          StartUp startUp = owService.selectApplydetail(sNum);
		          
		          String region = startUp.getsAddress();
		          region = region.replaceAll("[0-9]", "");  //지역명만 따오기위해 앞에 우편번호와 공백 제거
		          region = region.replaceAll(" ", "");
		          region = region.substring(0, 2);
		          String storeId  = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거
		          storeId = storeId.substring(0, 10); //storeId를 앞에서부터 10자리 잘라줌.
		          
		          
		          store.setStore_region(region.substring(0, 2));
		          store.setStore_address(startUp.getsAddress());
		          store.setStore_name(startUp.getStoreName());
		          store.setStore_phone(startUp.getsPhone());
		          
		          map.put("mail", startUp.getsEmail());
		          map.put("code", storeId);
		          
		          try {
		             emailSender.sendEmail(map); //email 보내는 메소드
		          } catch (Exception e1) {
		             e1.printStackTrace();   
		          }
		          store.setStore_login_code(bcrypt.encode(storeId));
		          
		          result2 = owService.insertStore(store); //관리자가 승인하면 게시글에 담긴 정보로 매장과 로그인 키 발급
		          if(result2 > 0) {
		             result = owService.applyChk(s);  //승인 처리 
		             if(result > 0) {
		                PrintWriter out;
		                try {
		                   out = response.getWriter();
		                   out.append("ok");
		                   out.flush();
		                } catch (IOException e) {
		                   e.printStackTrace();
		                }         
		             }else {
		                throw new EtcException("상태변경에 실패하였습니다.");
		             }   
		          } else {
		             throw new EtcException("코드 발급에 실패하였습니다.");
		          }
		       }else if(str.equals("거절")) {
		          result = owService.applyChk(s);  //거절 처리
		          
		          if(result > 0) {
		             PrintWriter out;
		             try {
		                out = response.getWriter();
		                out.append("ok");
		                out.flush();
		             } catch (IOException e) {
		                e.printStackTrace();
		             }         
		          }else {
		             throw new EtcException("상태변경에 실패하였습니다.");
		          }   
		       }   
		          
		    }
		   
		   // 창업신청 삭제
		   @RequestMapping("deleteApply.ow")
		   public String deleteApplt(@RequestParam("sNum") int sNum) {
		      
		      int result = owService.deleteApply(sNum);
		      
		      if(result > 0) {
		         return "redirect:startUpList.ow";
		      }else {
		         throw new EtcException("삭제에 실패하였습니다.");
		      }
		      
		   }
		   
		   //창업신청 리스트 검색
		   @RequestMapping("searchApply.ow")
		   public void searchApplyList(@RequestParam("title") String title,@RequestParam("option") String option, HttpServletResponse response){
		      HashMap<String,String> map = new HashMap<String, String>();
		      map.put("text", title);
		      map.put("option", option);
		      ArrayList<StartUp> list = owService.searchApplyList(map);
		      
		      response.setContentType("application/json; charset=UTF-8");
		      Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		      
		      try {
		         gson.toJson(list, response.getWriter());
		      } catch (JsonIOException e) {
		         e.printStackTrace();
		      } catch (IOException e) {
		         e.printStackTrace();
		      }
		      
		   }
		   
		   
		   
		   
		 //신메뉴 리스트 검색
	         @RequestMapping("searchNewMenu.ow")
	         public void searchNewMenu(@RequestParam("title") String title,@RequestParam("option") String option, HttpServletResponse response){
	            HashMap<String,String> map = new HashMap<String, String>();
	            map.put("text", title);
	            map.put("option", option);
	            ArrayList<StartUp> list = owService.searchNewMenu(map);
	            response.setContentType("application/json; charset=UTF-8");
	            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
	            
	            try {
	               gson.toJson(list, response.getWriter());
	            } catch (JsonIOException e) {
	               e.printStackTrace();
	            } catch (IOException e) {
	               e.printStackTrace();
	            }
	            
	         }
	         
	         
		   
		   
		   
		   //관리자 신메뉴 게시판리스트
		      @RequestMapping("owner_newmenu_list.ow")
		      public ModelAndView ownerNewMenuListView(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		         int currentPage = 1;
		         if(page != null ) {
		            currentPage = page;
		         }
		         
		         int listCount = owService.getListCount();
		         PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		         
		         ArrayList<OwnerNewMenuBoard> list = owService.selectOwnerMenuList(pi);
		         
		         if(list != null) {
		            mv.addObject("list", list);
		            mv.addObject("pi", pi);
		            mv.setViewName("owner_newmenu_list");
		         }else {
		            throw new NewMenuException("게시글 전체 조회에 실패했습니다.");
		         }
		         
		         return mv;   
		      }
		      //관리자 신메쥬 게시글 작성 폼
		      @RequestMapping("ownerRegisterView.ow")
		      public String ownerRegisterView() {
		         
		         return "owner_newmenu_register"; 
		      }
		      //가맹주 신메뉴 게시글 작성
		      @RequestMapping("owner_newmenu_insert.ow")
		        public String ownerNewMenuInsert(@ModelAttribute OwnerNewMenuBoard b, @RequestParam("uploadFile") MultipartFile[] upFile,
		                @RequestParam("contentText") String[] contentText, HttpServletRequest request) {
		
		         ArrayList<OwnerNewMenuFiles> files = new ArrayList<OwnerNewMenuFiles>();
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
		         
		         OwnerNewMenuFiles fi = new OwnerNewMenuFiles();
		         fi.setContentText(contentText[i]);
		         fi.setChangeName(renameFileName);
		         fi.setOriginalName(originalFileName);
		         fi.setFilePath(renamePath);
		         
		         
		         files.add(fi);
		         }
		         int result2 = 0; 
		         int result1 = owService.insertOnmboard(b);
		         if(result1 > 0) {
		         for(OwnerNewMenuFiles f : files) {
		             result2 = owService.insertOnmFiles(f);
		         }
		         if(result2 > 0) {
		                return "redirect:owner_newmenu_list.ow";
		         } else {
		                throw new EtcException("파일저장 실패");
		                }
		         } else {
		            throw new EtcException("게시글 저장 실패");
		         }
		         
		      }
		      
		      //가맹주 신메뉴개발게시판 게시물 상세조회
		      @RequestMapping("onmdetail.ow")
		      public ModelAndView ownerNewMenuDetail(@RequestParam("onmNum") int onmNum, @RequestParam("page") int page, ModelAndView mv) {
		         
		         OwnerNewMenuBoard s = owService.selectNewMenudetail(onmNum);
		         ArrayList<OwnerNewMenuFiles> f = owService.selectNewMenuFile(onmNum);
		         if(s != null) {
		            mv.addObject("s", s)
		            .addObject("f", f)
		            .addObject("page",page)
		            .setViewName("owner_newmenu_detail");
		         } else {
		            throw new EtcException("상세보기에 실패하였습니다.");
		         }
		         return mv;
		      }
		      
		      
		      //가맹주 신메뉴 개발게시판 게시물 삭제 
		      @RequestMapping("deleteOwnerNewMenu.ow")
		      public String deleteNewMenu(@RequestParam("onmNum") int onmNum) {
		         int result = owService.deleteNewMenu(onmNum);
		         
		         if(result > 0) {
		            return "redirect:owner_newmenu_list.ow";
		         }else {
		            throw new EtcException("게시물 삭제 실패");
		         }
		      }
		      @RequestMapping("ownerNewMenuUpdateView.ow")
		      public ModelAndView NemMenuUpdateView(@RequestParam("onmNum") int onmNum, ModelAndView mv) {
		         
		         OwnerNewMenuBoard s = owService.selectNewMenudetail(onmNum);
		         ArrayList<OwnerNewMenuFiles> f = owService.selectNewMenuFile(onmNum);
		         if(s != null) {
		            mv.addObject("s", s)
		            .addObject("f", f)
		            .setViewName("owner_newmenu_update");
		         } else {
		            throw new EtcException("수정페이지 이동에 실패하였습니다.");
		         }
		         return mv;
		      }
		      
		      
		      //신메뉴 게시판 게시물 수정
		      @RequestMapping("owner_newmenu_update.ow")
		         public String ownerNewMenuUpdate(@ModelAttribute OwnerNewMenuBoard b, @RequestParam("fileNum") int[] fileNum, @RequestParam("reuploadFile") MultipartFile[] reuploadFile,
		               @RequestParam("contentText") String[] contentText, HttpServletRequest request) {
		               
		              int result2 = 0;
		              
		              for(int i=0; i < contentText.length; i++) {
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
		                  
		                        OwnerNewMenuFiles fi = new OwnerNewMenuFiles();
		                      fi.setContentText(contentText[i]);
		                      fi.setChangeName(renameFileName);
		                      fi.setOriginalName(originalFileName);
		                      fi.setFilePath(renamePath);
		                      fi.setOwFileNum(fileNum[i]);
		                      fi.setOnmNum(b.getOnmNum());
		                      
		                       if(fi.getOwFileNum() == 0) {
		                            result2 = owService.addinsertOnmFiles(fi);
		                       }else {
		                            result2 = owService.updateONMfile(fi);
		                       }   
		                  }else{
		                        OwnerNewMenuFiles fi = new OwnerNewMenuFiles();
		                      fi.setContentText(contentText[i]);
		                      fi.setOwFileNum(fileNum[i]);
		                      
		                      result2 = owService.updateOnmFilesContent(fi);
		                  }
		                 
		            }
		              
		            
		            if(result2 > 0) {
		               int result1 = owService.updateONmboard(b);
		               if(result1 > 0) {
		                  return "redirect:owner_newmenu_list.ow";
		              } else {
		                  throw new EtcException("게시글 수정 실패");
		              }
		            } else {
		               throw new EtcException("파일 수정 실패");
		            }
		             
		         }
		      
		      
		      //신메뉴게시판 게시물 파일 삭제
		      @RequestMapping("deleteNewMenuFile.ow")
		      public void deleteNewMenuFile(@RequestParam("fNum") int fNum) {
		         
		         int result = owService.deleteNewMenuFile(fNum);
		         
		         if(result < 0) {
		            throw new EtcException("이미지 삭제에 실패하였습니다.");
		         }
		      }
		      
		      
		      //취소된거 되돌리기
		      @RequestMapping("cancelUpdateRollback.ow")
		      public void cancelUpdateRollback(@RequestParam("onmNum") int onmNum) {
		         
		         int result = owService.rollbackUpdate(onmNum);
		         
		         if(result < 0) {
		            throw new EtcException("이미지 삭제에 실패하였습니다.");
		         }
		      }
		   
		   
		   
		   
		   
		   
		   
		   //생산관리 -> 주문하기(가맹주) 본사에 있는 재료 리스트 나열해줌
		   @RequestMapping("owner_material_orderView.ow")
		   public ModelAndView ownerMaterialOrderView(ModelAndView mv) {
		      ArrayList<CoffeeStock> list = new ArrayList<CoffeeStock>();
		      
		      list = owService.selectCoffeeStock();
		      mv.addObject("list", list);
		      mv.setViewName("owner_material_order");
		      return mv;
		   }
		   
		   
		
		   
		   
		   //생산관리 -> 주문하기(가맹주) 내가 발주하고 싶은 재료 주문
		   @RequestMapping("owner_material_order.ow")
		   public String ownerMaterialOrder(@RequestParam("materialName") String[] name, @RequestParam("materialAmount") int[] amount, @RequestParam("allStockNum") int[] allStockNum,  HttpSession session ) {
		      StoreStock ss = new StoreStock();
		      Store loginUser = (Store)session.getAttribute("loginUser");
		      int storeNum  = loginUser.getStore_num();
		      
		      int result=0;
		      for(int i=0; i<name.length; i++ ){
		         
		         ss.setStore_num(storeNum);
		         ss.setMaterialName(name[i]);
		         ss.setMaterialAmount(amount[i]);
		         ss.setAllStockNum(allStockNum[i]);
		         result = owService.ownerinsertMaterial(ss);
		         
		         
		         if(result < 0) {
		            throw new MemberException("재고 수정에 실패했습니다");
		         }
		      }
		      if(result >0) {
		         return "redirect:owner_material_orderView.ow";
		      } else {
		         throw new MemberException("발주에 실패했습니다");
		      }
		   }
		   
		   
		   
		   
		   
		   //생산관리 -> 현재고(가맹주) 나의 매장에 가지고 있는 재료 리스트 나열
		   @RequestMapping("owner_inventory.ow")
		   public ModelAndView ownerMaterialInventory(ModelAndView mv ,HttpSession session){
		      ArrayList<StoreStock> list = new ArrayList<StoreStock>();
		      StoreStock ss = new StoreStock();
		      Store loginUser = (Store)session.getAttribute("loginUser");
		      int store_num  = loginUser.getStore_num();
		      list = owService.selectCoffeeInventory(store_num);
		      mv.addObject("list", list);
		      mv.setViewName("owner_inventory_list");
		      return mv;
		   }
		   
		   
		   
		   
		   
		   
		   
		   //생산관리 -> 발주현황(가맹주) 발주한 재료들의 상태 확인[승인/대기/거절]
		   @RequestMapping("owner_order_status.ow")
		   public ModelAndView ownerOrderStatus(ModelAndView mv,HttpSession session ) {
		      
		      StoreStock ss = new StoreStock();
		      Store loginUser = (Store)session.getAttribute("loginUser");
		      int storeNum  = loginUser.getStore_num();
		      
		      ArrayList<StoreStock> list = new ArrayList<StoreStock>();
		      
		      list = owService.selectOrderStatus(storeNum);
		      
		      mv.addObject("list", list);
		      mv.setViewName("owner_order_status");
		      return mv;
		   }
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   //지원
		   //가맹주 공지사항
		   @RequestMapping("owner_notice.ow")
		   public ModelAndView ownerNotice(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		      
		      int currentPage = 1;
		      
		      if(page != null) {
		         currentPage = page;
		      }
		      
		      //전체 개시물 개수
		      int listCount = owService.getNoticeCount();
		      
		      //페이징 계산
		      PageInfo pi = Pagination.getPageInfo(currentPage, listCount);   
		      
		      
		      ArrayList<OwnerNotice> onlist = owService.selectOwnerNoticeList(pi); 
		      
		      mv.addObject("onlist", onlist).addObject("pi", pi).setViewName("owner_notice");
		      
		      return mv;
		   }
		   
		   @RequestMapping("owner_notice_registerView.ow")
		   public void ownerNoticeRegister() { }
		   
		   @RequestMapping("insertNotice.ow")
		   public String insertNotice(@ModelAttribute OwnerNotice on , @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
		      
		      String contents = ((String)on.getOwContent().replace("\r\n","<br>"));
		      on.setOwContent(contents);
		      
		      if(uploadFile != null && !uploadFile.isEmpty()) {
		         String renameFileName = saveFile(uploadFile, request);
		         
		         if(renameFileName != null) {
		            on.setRenameFileName(renameFileName);
		            on.setOriginFileName(uploadFile.getOriginalFilename());
		         }
		      }
		      
		      int result = owService.insertOwnerNotice(on);
		      
		      if(result > 0) {
		         return "redirect:owner_notice.ow";
		      } else {
		            throw new MemberException("공지사항 등록에 실패");
		        }
		      
		   }
		   private String saveFile(MultipartFile file, HttpServletRequest request) {
		      String root = request.getSession().getServletContext().getRealPath("resources");
		      String savePath = root + "\\ownerNoticeuploadFiles";
		      
		      File folder = new File(savePath);
		      if(!folder.exists()) {
		         //폴더 없으면 새 폴더
		         folder.mkdirs();
		      }
		      
		      //저장 시 바뀐 이름 넣기
		      String originalFileName = file.getOriginalFilename();
		      String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		      UUID uuid = UUID.randomUUID();
		      String renameFileName = uuid.toString() + extension;
		      
		      
		      //완성 경로
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
		   
		   
		   //detail
		   @RequestMapping("ownerNoticeDetail.ow")
		   public ModelAndView ownerNoticeDetail(@RequestParam("onNo") int onNo, @RequestParam("page") int page, ModelAndView mv ) {
		      
		      OwnerNotice on = owService.selectOwnerNoticeDetail(onNo);
		
		      int img = 0;
		      if(on.getOriginFileName() != null) {
		         String extension = on.getRenameFileName().substring(on.getRenameFileName().lastIndexOf("."));
		         if(extension.equals(".png") ||extension.equals(".PNG") ||extension.equals(".jpg") ||extension.equals(".JPG")) {
		            img = 1;
		         } else {
		            img = 2;
		         }
		      }
		      if (on != null) {
		         mv.addObject("on", on).addObject("page", page).addObject("img", img).setViewName("owner_notice_detail");
		      } else {
		         throw new MemberException("공지사항 상세보기 실패");
		      }
		      return mv;
		   }
		   
		   
		   //가맹주 공지사항 삭제
		   @RequestMapping("ownerNoticeDelete.ow")
		   public String noticeDelete(@RequestParam("onNo") int onNo) {
		      
		      int result = owService.deleteNotice(onNo);
		      
		      if(result > 0) {
		         return "redirect:owner_notice.ow";
		      } else {
		         throw new MemberException("공지사항 삭제 실패");
		      }
		      
		   }
		   
		   
		   //가맹주 공지사항 수정view
		   @RequestMapping("ownerNoticeModifyView.ow")
		   public ModelAndView noticeModifyView(@RequestParam("onNo") int onNo, @RequestParam("page") int page, ModelAndView mv) {
		      
		      OwnerNotice on = owService.selectOwnerNoticeDetail(onNo);
		      
		      if(on != null) {
		         mv.addObject("on", on).addObject("page", page).setViewName("owner_noticeModifyView");
		      } else {
		         throw new MemberException("공지사항 삭제 실패");
		      }
		      
		      return mv;
		      
		   }
		   
		   
		   //가맹주 공지사항 수정
		   @RequestMapping("modifyNotice.ow")
		   public ModelAndView modifyNotice(@ModelAttribute OwnerNotice on , @RequestParam("reloadFile") MultipartFile reloadFile, HttpServletRequest request
		                              ,@RequestParam("page") int page,ModelAndView mv) {
		      
		      String contents = ((String)on.getOwContent().replace("\r\n","<br>"));
		      on.setOwContent(contents);      
		      
		      
		      if(reloadFile != null && !reloadFile.isEmpty()) {//새로 변경할 파일이 있다면
		         if(on.getRenameFileName() != null) { //기존 파일이 있다면
		            deleteFile(on.getRenameFileName(), request);
		         }
		         
		         String renameFileName = saveFile(reloadFile, request);
		         
		         if(renameFileName != null) {
		            on.setOriginFileName(reloadFile.getOriginalFilename());
		            on.setRenameFileName(renameFileName);
		         }
		      }
		      
		      int result = owService.modifyNotice(on);
		      
		      if(result > 0) {
		         mv.addObject("onNo", on.getOnNo()).addObject("page", page).setViewName("redirect:ownerNoticeDetail.ow");
		      } else {
		         throw new MemberException("공지사항 상세보기 실패");
		      }
		      return mv;
		   }
		   
		   
		   private void deleteFile(String fileName, HttpServletRequest request) {
		      String root = request.getSession().getServletContext().getRealPath("resources");
		      String savePath = root + "\\ownerNoticeuploadFiles";
		      
		      File f = new File(savePath + "\\" + fileName);
		      
		      if(f.exists()) {
		         f.delete();
		      }
		   }
		   
		   
		   
		   //공지사항에서 게시물 검색
		   @RequestMapping("noticeSearch.ow")
		   public ModelAndView noticeSearch(@RequestParam("sCate") String sCate, @RequestParam("sVal") String sVal, @RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		      
		      Search s = new Search();
		      
		      if(sCate.equals("title")) {
		         s.setTitle(sVal);
		      } else if(sCate.equals("content")){
		         s.setContent(sVal);
		      }
		      
		      //페이징 같이하기
		      int currentPage = 1;
		      if(page != null) {
		         currentPage = page;
		      }
		      
		      //전체 개시물 개수
		      int listCount = owService.getSearchResultCount(s);
		      
		      //페이징 계산
		      PageInfo pi = Pagination.getPageInfo(currentPage, listCount);   
		      
		      
		      ArrayList<OwnerNotice> onlist = owService.selectSearchResultList(s, pi);
		      
		      int searchResult = 0;
		      if(onlist.isEmpty()) {
		         searchResult = 1;
		      }
		      
		      mv.addObject("onlist", onlist).addObject("pi", pi).addObject("sCate", sCate).addObject("sVal", sVal).addObject("searchResult", searchResult).setViewName("owner_notice");
		      
		      return mv;
		      
		   }
		
		   
		   
		   
		}