package com.kh.dalboo.manager.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.common.Pagination;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.manager.model.exception.ManagerException;
import com.kh.dalboo.manager.model.service.ManagerService;
import com.kh.dalboo.manager.model.vo.CoffeeStock;
import com.kh.dalboo.member.model.exception.MemberException;
import com.kh.dalboo.owner.model.vo.StoreStock;


@SessionAttributes("loginUser")
@Controller
public class ManagerController {
   
   @Autowired
   private ManagerService maService;

   
   
   //생산관리 -> 전체 재고(관리자) 본사에 있는 재료와재고 리스트
   @RequestMapping("admin_inventory.ow")
   public ModelAndView adminInventoryList(ModelAndView mv) {
      
      ArrayList<CoffeeStock> list = new ArrayList<CoffeeStock>();
      
      list = maService.selectCoffeeStock();
      mv.addObject("list", list);
      mv.setViewName("admin_material_manage");
      return mv;
   }
   

   
   
   //생산관리 -> 현재 전체 재고(관리자) 재료 및 재고 추가
   @RequestMapping("admin_material_order.ow")
   public String adminInventoryList(@ModelAttribute CoffeeStock c, 
   @RequestParam("reuploadFile") MultipartFile reuploadFile, HttpServletRequest request) {
      
      int result = 0;
      
        
         if(reuploadFile != null && !reuploadFile.isEmpty()) { //첨푸파일이 있다면
             String renameFileName = saveFile(reuploadFile, request);
              
             if(renameFileName != null) {
                c.setRenameFileName(renameFileName);
                c.setOriginalFileName(reuploadFile.getOriginalFilename());
             }
          }
   
         if(c.getAllStockNum() > 0) {
             result = maService.updateStock(c);
         }else if(c.getAllStockNum()  == 0) {
            
             result = maService.insertStock(c);
         }
      
         
         
         if(result < 0) {
             throw new MemberException("재고 수정에 실패했습니다");
         }
       if(result > 0) {
            return "redirect:admin_inventory.ow";
        } else {
            throw new MemberException("재고 수정에 실패했습니다");
        }            
   }
   
   
   
   
   

   
   //재료 추가하는데 필요한 첨부파일 사진
   public String saveFile(MultipartFile file, HttpServletRequest request) {
      String root = request.getSession().getServletContext().getRealPath("resources");
      
      String savePath = root + "\\materialuploadFiles";
      
      
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

   
   
   
   //생산관리 -> 발주 관리(관리자) 각 매장의 가맹주가 발주한 재료와 수량 리스트
   @RequestMapping("admin_delivery.ow")
   public ModelAndView adminDeliveryManage(ModelAndView mv) {
      
      ArrayList<StoreStock> list = new ArrayList<StoreStock>();
      ArrayList<Store> list2 = new ArrayList<Store>();
      
      list = maService.selectStoreStock(); 
      list2 = maService.selectStore();       
      

      
      mv.addObject("list", list);
      mv.addObject("list2", list2);
      mv.setViewName("admin_delivery_manage");
      return mv;
   }
   
   
   
   
   //생산관리 -> 발주 관리(관리자) 가맹주가 발주한 재료를 관리자가 [수락 / 거절] 해주고, 수락할 시 매장의 전체재고 수량 변경 
   @RequestMapping("delivery_yesorno.ow")
   public String deliveryStatus(@RequestParam("store_num")int store_num, @RequestParam("btn") String btn) {
      
      StoreStock ss = new StoreStock();
      
      
      ss.setStore_num(store_num);
      ss.setStatus(btn);
      int result2 = 0;
      if(btn.equals("승인")) {
         ArrayList<StoreStock> ss2 = maService.selectStoreStockNum(store_num); 
            for(StoreStock s : ss2) {
               result2 = maService.downStock(s);
            }
         if(result2 < 0) {
            throw new MemberException("재고 수정에 실패했습니다");
         }            
      }
            
      int result1 = maService.updateStatus(ss); //승인처리      
      if(result1 > 0) {
         return "redirect:admin_delivery.ow";   
      }else {
         throw new MemberException("승인 거절에 실패했습니다.");
      }   
   }

   
   
   
   
   //생산관리 -> 납품 현황(관리자) 각 매장별 납품 현황(수락한 것만) 리스트 + 페이징처리
   @RequestMapping("admin_delivery_status.ow")
   public ModelAndView adminDeliveryStatus(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
      
      int currentPage = 1; 
      if(page !=null) {
         currentPage = page;
      }
         
      int listCount = maService.getListCount();
      PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
      
      
      
      
      ArrayList<StoreStock> list = new ArrayList<StoreStock>();
      ArrayList<Store> list2 = new ArrayList<Store>();
      
      
      list = maService.selectDeliveryStatus(pi);
      list2 = maService.selectStorename(pi);
      if(list !=null && list2 !=null) {
         mv.addObject("pi", pi);
         mv.addObject("list", list);
         mv.addObject("list2", list2);
         mv.setViewName("admin_delivery_status");
      }else {
         throw new ManagerException("납품 현황 조회에 실패하였습니다.");
      }
      return mv;
   }
   
   
}