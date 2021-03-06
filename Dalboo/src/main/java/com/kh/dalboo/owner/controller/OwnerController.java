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
		   
		   //???????????? ?????????
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
		         throw new EtcException("???????????? ?????? ????????? ??????????????????.");
		      }
		      
		      return mv;   
		   }
		 //??????????????????
	         @RequestMapping("ownerLoginPage.ow")
	         public String ownerLoginPageView(SessionStatus status, HttpSession session) {
	            // ??????????????? ?????? ????????? session ?????? ?????? ??????
	            if(session != null) {
	               session.invalidate(); // ?????? ????????? ?????? ?????????
	            }
	            // ????????? ????????? ????????? ????????? ????????? ?????? ?????? ??????
	            if(!status.isComplete()) {
	               status.setComplete(); // ????????? ????????? ?????? ?????????
	            }
	            
	            return "owner_login";
	         }
		   
		   //????????????
		   @RequestMapping("logout.ow")
		   public String logout(SessionStatus status) {
		      status.setComplete();
		      return "redirect:ownerLoginPage.ow";
		   }
		   
		   
		   //???????????????  ????????? + ?????? + ???????????? ?????????
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
		
		      
		    //???????????? ??????????????? ??????????????? [???????????? ??????] ????????? ??? or ?????????????????? ???????????? ?????? ???????????? ?????????????????? ???    
			   //????????? ????????? ???????????? (????????????,????????????,?????????)
			   @RequestMapping("ownerMain.ow")
			   public ModelAndView ownerMainNotice(ModelAndView mv, HttpSession session) {
			      
			      int rank = ((Store)session.getAttribute("loginUser")).getRank_code();
			      
			      
			      int store_num = ((Store)session.getAttribute("loginUser")).getStore_num();
			      
			      List<Store> sales = null;
			      List<SirenOrder> chart = null;
			      List<MdOrder> mdSales = null;
			      List<StoreStock> chart2 = null;
			      ArrayList<OwnerNotice> onlist = null;
			      // ????????? ????????? ??????
			      if(rank == 2) {
			         sales = owService.selectSalesAll();      // ?????? ?????? ??????
			         mdSales = owService.selectMdAllSales();      // md?????? ??? ??????
			         chart = owService.selectdoughnut();      // ????????? ????????? top 5
			         onlist = owService.selectOwnerMainNoticeList(); // ???????????? ?????????
			         
			         //MD??????(????????????)
			         int mdTotalSales = 0;
//			         for(MdOrder sale : mdSales) {
//			            int salesAmount = sale.getTotalPrice();
//			            mdTotalSales += salesAmount;
//			         }
			         
			         // ?????? ??????
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
			         
			         // ????????? ????????? ??????
			      } else if(rank == 1){ 
			         sales = owService.selectSalesMyStore(store_num);   // ??? ?????? ??????
			         onlist = owService.selectOwnerMainNoticeList(); // ???????????? ?????????
			         chart2 = owService.selectBarChart(store_num); //?????? ????????? ?????? ??????
			         
			         // ?????? ????????? chart??? ??? ????????? ??????????????? or ?????? ????????????
			         
			         
			         
			         // ?????? ??????
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
			         throw new EtcException("???????????? ??????????????????.");
			      }
			      
			   }
		
		   
		   //??????????????? ??????
		   @RequestMapping("defaultPage.ow")
		   public String defaultPage(SessionStatus status) {
		      status.setComplete();  //????????????????????? ?????????????????? ????????? ??????????????????
		      return "redirect:home.do";
		   }
		   
		   
		   //???????????? ?????????
		   @RequestMapping("applydetail.ow")
		   public ModelAndView boardDetail(@RequestParam("sNum") int sNum, @RequestParam("page") int page, ModelAndView mv) {
		      StartUp s = owService.selectApplydetail(sNum);
		      if(s != null) {
		         mv.addObject("s", s)
		         .addObject("page",page)
		         .setViewName("owner_startup_apply_detail");
		      } else {
		         throw new EtcException("???????????? ??????????????? ?????????????????????.");
		      }
		      return mv;
		   }
		   
		   //???????????? ??????(???????????? ??????), ??????
		    @RequestMapping("startUpApplyChk.ow")
		    public void startUpApplyCheck(@RequestParam("sNum") int sNum, @RequestParam("chkBtn") String str, HttpServletResponse response) {
		       
		       
		       Store store = new Store();
		       StartUp s = new StartUp();
		       s.setsNum(sNum);
		       s.setsConfirm(str);
		
		       HashMap<String, String> map = new HashMap<String, String>();
		       int result = 0;
		       int result2 = 0;
		       if(str.equals("??????")) {//?????? ????????? ?????? ????????? (store?????????)????????? ?????? ???????????? ??????
		          
		          
		          StartUp startUp = owService.selectApplydetail(sNum);
		          
		          String region = startUp.getsAddress();
		          region = region.replaceAll("[0-9]", "");  //???????????? ??????????????? ?????? ??????????????? ?????? ??????
		          region = region.replaceAll(" ", "");
		          region = region.substring(0, 2);
		          String storeId  = UUID.randomUUID().toString().replaceAll("-", ""); // -??? ??????
		          storeId = storeId.substring(0, 10); //storeId??? ??????????????? 10?????? ?????????.
		          
		          
		          store.setStore_region(region.substring(0, 2));
		          store.setStore_address(startUp.getsAddress());
		          store.setStore_name(startUp.getStoreName());
		          store.setStore_phone(startUp.getsPhone());
		          
		          map.put("mail", startUp.getsEmail());
		          map.put("code", storeId);
		          
		          try {
		             emailSender.sendEmail(map); //email ????????? ?????????
		          } catch (Exception e1) {
		             e1.printStackTrace();   
		          }
		          store.setStore_login_code(bcrypt.encode(storeId));
		          
		          result2 = owService.insertStore(store); //???????????? ???????????? ???????????? ?????? ????????? ????????? ????????? ??? ??????
		          if(result2 > 0) {
		             result = owService.applyChk(s);  //?????? ?????? 
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
		                throw new EtcException("??????????????? ?????????????????????.");
		             }   
		          } else {
		             throw new EtcException("?????? ????????? ?????????????????????.");
		          }
		       }else if(str.equals("??????")) {
		          result = owService.applyChk(s);  //?????? ??????
		          
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
		             throw new EtcException("??????????????? ?????????????????????.");
		          }   
		       }   
		          
		    }
		   
		   // ???????????? ??????
		   @RequestMapping("deleteApply.ow")
		   public String deleteApplt(@RequestParam("sNum") int sNum) {
		      
		      int result = owService.deleteApply(sNum);
		      
		      if(result > 0) {
		         return "redirect:startUpList.ow";
		      }else {
		         throw new EtcException("????????? ?????????????????????.");
		      }
		      
		   }
		   
		   //???????????? ????????? ??????
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
		   
		   
		   
		   
		 //????????? ????????? ??????
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
	         
	         
		   
		   
		   
		   //????????? ????????? ??????????????????
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
		            throw new NewMenuException("????????? ?????? ????????? ??????????????????.");
		         }
		         
		         return mv;   
		      }
		      //????????? ????????? ????????? ?????? ???
		      @RequestMapping("ownerRegisterView.ow")
		      public String ownerRegisterView() {
		         
		         return "owner_newmenu_register"; 
		      }
		      //????????? ????????? ????????? ??????
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
		         
		         //?????? ??????
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
		                throw new EtcException("???????????? ??????");
		                }
		         } else {
		            throw new EtcException("????????? ?????? ??????");
		         }
		         
		      }
		      
		      //????????? ???????????????????????? ????????? ????????????
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
		            throw new EtcException("??????????????? ?????????????????????.");
		         }
		         return mv;
		      }
		      
		      
		      //????????? ????????? ??????????????? ????????? ?????? 
		      @RequestMapping("deleteOwnerNewMenu.ow")
		      public String deleteNewMenu(@RequestParam("onmNum") int onmNum) {
		         int result = owService.deleteNewMenu(onmNum);
		         
		         if(result > 0) {
		            return "redirect:owner_newmenu_list.ow";
		         }else {
		            throw new EtcException("????????? ?????? ??????");
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
		            throw new EtcException("??????????????? ????????? ?????????????????????.");
		         }
		         return mv;
		      }
		      
		      
		      //????????? ????????? ????????? ??????
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
		               
		                     //?????? ??????
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
		                  throw new EtcException("????????? ?????? ??????");
		              }
		            } else {
		               throw new EtcException("?????? ?????? ??????");
		            }
		             
		         }
		      
		      
		      //?????????????????? ????????? ?????? ??????
		      @RequestMapping("deleteNewMenuFile.ow")
		      public void deleteNewMenuFile(@RequestParam("fNum") int fNum) {
		         
		         int result = owService.deleteNewMenuFile(fNum);
		         
		         if(result < 0) {
		            throw new EtcException("????????? ????????? ?????????????????????.");
		         }
		      }
		      
		      
		      //???????????? ????????????
		      @RequestMapping("cancelUpdateRollback.ow")
		      public void cancelUpdateRollback(@RequestParam("onmNum") int onmNum) {
		         
		         int result = owService.rollbackUpdate(onmNum);
		         
		         if(result < 0) {
		            throw new EtcException("????????? ????????? ?????????????????????.");
		         }
		      }
		   
		   
		   
		   
		   
		   
		   
		   //???????????? -> ????????????(?????????) ????????? ?????? ?????? ????????? ????????????
		   @RequestMapping("owner_material_orderView.ow")
		   public ModelAndView ownerMaterialOrderView(ModelAndView mv) {
		      ArrayList<CoffeeStock> list = new ArrayList<CoffeeStock>();
		      
		      list = owService.selectCoffeeStock();
		      mv.addObject("list", list);
		      mv.setViewName("owner_material_order");
		      return mv;
		   }
		   
		   
		
		   
		   
		   //???????????? -> ????????????(?????????) ?????? ???????????? ?????? ?????? ??????
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
		            throw new MemberException("?????? ????????? ??????????????????");
		         }
		      }
		      if(result >0) {
		         return "redirect:owner_material_orderView.ow";
		      } else {
		         throw new MemberException("????????? ??????????????????");
		      }
		   }
		   
		   
		   
		   
		   
		   //???????????? -> ?????????(?????????) ?????? ????????? ????????? ?????? ?????? ????????? ??????
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
		   
		   
		   
		   
		   
		   
		   
		   //???????????? -> ????????????(?????????) ????????? ???????????? ?????? ??????[??????/??????/??????]
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
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   //??????
		   //????????? ????????????
		   @RequestMapping("owner_notice.ow")
		   public ModelAndView ownerNotice(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		      
		      int currentPage = 1;
		      
		      if(page != null) {
		         currentPage = page;
		      }
		      
		      //?????? ????????? ??????
		      int listCount = owService.getNoticeCount();
		      
		      //????????? ??????
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
		            throw new MemberException("???????????? ????????? ??????");
		        }
		      
		   }
		   private String saveFile(MultipartFile file, HttpServletRequest request) {
		      String root = request.getSession().getServletContext().getRealPath("resources");
		      String savePath = root + "\\ownerNoticeuploadFiles";
		      
		      File folder = new File(savePath);
		      if(!folder.exists()) {
		         //?????? ????????? ??? ??????
		         folder.mkdirs();
		      }
		      
		      //?????? ??? ?????? ?????? ??????
		      String originalFileName = file.getOriginalFilename();
		      String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		      UUID uuid = UUID.randomUUID();
		      String renameFileName = uuid.toString() + extension;
		      
		      
		      //?????? ??????
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
		         throw new MemberException("???????????? ???????????? ??????");
		      }
		      return mv;
		   }
		   
		   
		   //????????? ???????????? ??????
		   @RequestMapping("ownerNoticeDelete.ow")
		   public String noticeDelete(@RequestParam("onNo") int onNo) {
		      
		      int result = owService.deleteNotice(onNo);
		      
		      if(result > 0) {
		         return "redirect:owner_notice.ow";
		      } else {
		         throw new MemberException("???????????? ?????? ??????");
		      }
		      
		   }
		   
		   
		   //????????? ???????????? ??????view
		   @RequestMapping("ownerNoticeModifyView.ow")
		   public ModelAndView noticeModifyView(@RequestParam("onNo") int onNo, @RequestParam("page") int page, ModelAndView mv) {
		      
		      OwnerNotice on = owService.selectOwnerNoticeDetail(onNo);
		      
		      if(on != null) {
		         mv.addObject("on", on).addObject("page", page).setViewName("owner_noticeModifyView");
		      } else {
		         throw new MemberException("???????????? ?????? ??????");
		      }
		      
		      return mv;
		      
		   }
		   
		   
		   //????????? ???????????? ??????
		   @RequestMapping("modifyNotice.ow")
		   public ModelAndView modifyNotice(@ModelAttribute OwnerNotice on , @RequestParam("reloadFile") MultipartFile reloadFile, HttpServletRequest request
		                              ,@RequestParam("page") int page,ModelAndView mv) {
		      
		      String contents = ((String)on.getOwContent().replace("\r\n","<br>"));
		      on.setOwContent(contents);      
		      
		      
		      if(reloadFile != null && !reloadFile.isEmpty()) {//?????? ????????? ????????? ?????????
		         if(on.getRenameFileName() != null) { //?????? ????????? ?????????
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
		         throw new MemberException("???????????? ???????????? ??????");
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
		   
		   
		   
		   //?????????????????? ????????? ??????
		   @RequestMapping("noticeSearch.ow")
		   public ModelAndView noticeSearch(@RequestParam("sCate") String sCate, @RequestParam("sVal") String sVal, @RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		      
		      Search s = new Search();
		      
		      if(sCate.equals("title")) {
		         s.setTitle(sVal);
		      } else if(sCate.equals("content")){
		         s.setContent(sVal);
		      }
		      
		      //????????? ????????????
		      int currentPage = 1;
		      if(page != null) {
		         currentPage = page;
		      }
		      
		      //?????? ????????? ??????
		      int listCount = owService.getSearchResultCount(s);
		      
		      //????????? ??????
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