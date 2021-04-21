package com.kh.dalboo.owner.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.StartUp;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.manager.model.vo.CoffeeStock;
import com.kh.dalboo.mdProduct.model.vo.MdOrder;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.owner.model.vo.OwnerNewMenuBoard;
import com.kh.dalboo.owner.model.vo.OwnerNewMenuFiles;
import com.kh.dalboo.owner.model.vo.OwnerNotice;
import com.kh.dalboo.owner.model.vo.Search;
import com.kh.dalboo.owner.model.vo.StoreStock;

public interface OwnerService {
   
   //재훈
   int getApplyListCount();

   ArrayList<StartUp> selectApplyList(PageInfo pi);

   StartUp selectApplydetail(int sNum);

   int applyChk(StartUp s);

   int deleteApply(int sNum);

   int insertStore(Store store);

   ArrayList<StartUp> searchApplyList(HashMap<String,String> map);

   Store ownerLogin(Store s);
   
   int ownerinsertMaterial(StoreStock ss);

   ArrayList<CoffeeStock> selectCoffeeStock();

   ArrayList<StoreStock> selectCoffeeInventory(int store_num);

   ArrayList<StoreStock> selectOrderStatus(int storeNum);
   
   
   
   
   //진욱
   int insertOnmboard(OwnerNewMenuBoard b);

   int insertOnmFiles(OwnerNewMenuFiles f);

   int getListCount();

   ArrayList<OwnerNewMenuBoard> selectOwnerMenuList(PageInfo pi);

   OwnerNewMenuBoard selectNewMenudetail(int onmNum);

   ArrayList<OwnerNewMenuFiles> selectNewMenuFile(int onmNum);

   int deleteNewMenu(int onmNum);

   int updateONmboard(OwnerNewMenuBoard b);

   int updateONMfile(OwnerNewMenuFiles f);

   int addinsertOnmFiles(OwnerNewMenuFiles fi);

   int deleteNewMenuFile(int fNum);

   int rollbackUpdate(int onmNum);

   int updateOnmFilesContent(OwnerNewMenuFiles fi);


   
   //지원
   int insertOwnerNotice(OwnerNotice on);

   int getNoticeCount();

   ArrayList<OwnerNotice> selectOwnerNoticeList(PageInfo pi);

   OwnerNotice selectOwnerNoticeDetail(int onNo);

   int deleteNotice(int onNo);

   int modifyNotice(OwnerNotice on);

   int getSearchResultCount(Search s);

   ArrayList<OwnerNotice> selectSearchResultList(Search s, PageInfo pi);

   
   
   
   
   
   ArrayList<OwnerNotice> selectOwnerMainNoticeList();
   
   
   
   
   
   
   
   List<Store> selectSalesAll();

   List<Store> selectSalesMyStore(int store_num);

   List<SirenOrder> selectdoughnut();

   Member adminLogin(Map<String, String> map);

   List<MdOrder> selectMdAllSales();

   
   List<StoreStock> selectBarChart(int store_num);

ArrayList<StartUp> searchNewMenu(HashMap<String, String> map);

   
   
   
   
}