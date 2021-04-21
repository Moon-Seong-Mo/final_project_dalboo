package com.kh.dalboo.owner.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.StartUp;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.manager.model.vo.CoffeeStock;
import com.kh.dalboo.mdProduct.model.vo.MdOrder;
import com.kh.dalboo.member.model.exception.MemberException;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.owner.model.dao.OwnerDAO;
import com.kh.dalboo.owner.model.vo.OwnerNewMenuBoard;
import com.kh.dalboo.owner.model.vo.OwnerNewMenuFiles;
import com.kh.dalboo.owner.model.vo.OwnerNotice;
import com.kh.dalboo.owner.model.vo.Search;
import com.kh.dalboo.owner.model.vo.StoreStock;

@Service("owService")
public class OwnerServiceImpl implements OwnerService{

   @Autowired
   private OwnerDAO owDAO;
   
   @Autowired
   private SqlSessionTemplate sqlSession;
   
   @Override
   public int getApplyListCount() {
      return owDAO.getApplyListCount(sqlSession);
   }

   @Override
   public ArrayList<StartUp> selectApplyList(PageInfo pi) {
      return owDAO.selectApplyList(sqlSession, pi);
   }

   @Override
   public StartUp selectApplydetail(int sNum) {
      return owDAO.selectApplydetail(sqlSession, sNum);
   }

   @Override
   public int applyChk(StartUp s) {
      return owDAO.applyChk(sqlSession, s);
   }

   @Override
   public int deleteApply(int sNum) {
      return owDAO.deleteApply(sqlSession, sNum);
   }

   @Override
   public int insertStore(Store store) {
      return owDAO.insertStore(sqlSession, store);
   }

   @Override
   public ArrayList<StartUp> searchApplyList(HashMap<String,String> map) {
      return owDAO.searchApplyList(sqlSession, map);
   }

   @Override
   public Store ownerLogin(Store s) {
      return owDAO.ownerLogin(sqlSession, s);
   }

   
   @Override
   public int ownerinsertMaterial(StoreStock ss) {
      return owDAO.ownerinsertMaterial(sqlSession, ss);
   }

   @Override
   public ArrayList<CoffeeStock> selectCoffeeStock() {
      return owDAO.ownerselectCoffeeStock(sqlSession);
   }

   @Override
   public ArrayList<StoreStock> selectCoffeeInventory(int store_num) {
      return owDAO.ownerselectCoffeeInventory(sqlSession,store_num);
   }

   @Override
   public ArrayList<StoreStock> selectOrderStatus(int storeNum) {
      return owDAO.ownerselectOrderStatus(sqlSession, storeNum);
   }
   
   
   
   
   
   //진욱
   @Override
   public int insertOnmboard(OwnerNewMenuBoard b) {
      return owDAO.insertOnmboard(sqlSession, b);
   }

   @Override
   public int insertOnmFiles(OwnerNewMenuFiles f) {
      return owDAO.insertOnmFiles(sqlSession, f);
   }

   @Override
   public int getListCount() {
      return owDAO.getListCount(sqlSession);
   }

   @Override
   public ArrayList<OwnerNewMenuBoard> selectOwnerMenuList(PageInfo pi) {
      return owDAO.selectOwnerMenuList(sqlSession, pi);
   }

   @Override
   public OwnerNewMenuBoard selectNewMenudetail(int onmNum) {
      int result = owDAO.addViewsCount(sqlSession, onmNum);
      OwnerNewMenuBoard b = null;
      if(result > 0) {
         b = owDAO.selectNewMenuBoard(sqlSession, onmNum);
      }
      return b;
   }

   @Override
   public ArrayList<OwnerNewMenuFiles> selectNewMenuFile(int onmNum) {
      ArrayList<OwnerNewMenuFiles> f = null;
      f = owDAO.selectNewMenuFile(sqlSession, onmNum);
      return f;
   }

   @Override
   public int deleteNewMenu(int onmNum) {
      return owDAO.deleteNewMenu(sqlSession, onmNum);
   }

   @Override
   public int updateONmboard(OwnerNewMenuBoard b) {
      return owDAO.updateONmboard(sqlSession, b);
   }

   @Override
   public int updateONMfile(OwnerNewMenuFiles f) {
      return owDAO.updateONMfile(sqlSession, f);
   }

   @Override
   public int addinsertOnmFiles(OwnerNewMenuFiles fi) {
      return owDAO.addinsertOnmFiles(sqlSession,fi);
   }

   @Override
   public int deleteNewMenuFile(int fNum) {
      return owDAO.deleteNewMenuFile(sqlSession, fNum);
   }

   @Override
   public int rollbackUpdate(int onmNum) {
      return owDAO.rollbackUpdate(sqlSession, onmNum);
   }

   @Override
   public int updateOnmFilesContent(OwnerNewMenuFiles fi) {
      return owDAO.updateOnmFilesContent(sqlSession, fi);
   }   
   
   
   
   
   //지원
   @Override
   public int insertOwnerNotice(OwnerNotice on) {
      return owDAO.insertOwnerNotice(sqlSession, on);
   }

   @Override
   public int getNoticeCount() {
      return owDAO.getNoticeCount(sqlSession);
   }

   @Override
   public ArrayList<OwnerNotice> selectOwnerNoticeList(PageInfo pi) {
      return owDAO.selectOnwerNoticeList(sqlSession, pi);
   }

   @Override
   public OwnerNotice selectOwnerNoticeDetail(int onNo) {
      //조회수
      int result = owDAO.updateNoticeCount(sqlSession, onNo);
      
      if(result < 0) {
         throw new MemberException("공지사항 카운트 증가 실패");
      }
      
      return owDAO.selectOwnerNoticeDetail(sqlSession, onNo);
   }

   @Override
   public int deleteNotice(int onNo) {
      return owDAO.deleteNotice(sqlSession, onNo);
   }

   @Override
   public int modifyNotice(OwnerNotice on) {
      return owDAO.modifyNotice(sqlSession, on);
   }

   @Override
   public int getSearchResultCount(Search s) {
      return owDAO.getSearchResultCount(sqlSession, s);
   }

   @Override
   public ArrayList<OwnerNotice> selectSearchResultList(Search s, PageInfo pi) {
      return owDAO.selectSearchResultList(sqlSession, s, pi);
   }

   
   
   
   @Override
   public ArrayList<OwnerNotice> selectOwnerMainNoticeList() {
      return owDAO.selectOwnerMainNoticeList(sqlSession);
   }
   
   
   
   
   
   
   
   
   @Override
   public List<Store> selectSalesAll() {
      return owDAO.selectSalesAll(sqlSession);
   }
   
   @Override
    public List<Store> selectSalesMyStore(int store_num) {
       return owDAO.selectSalesMyStore(sqlSession, store_num);
    }

   
   @Override
   public List<SirenOrder> selectdoughnut() {
      return owDAO.selectdoughnut(sqlSession);
   }

   @Override
      public Member adminLogin(Map<String, String> map) {
         return owDAO.adminLogin(sqlSession, map);
      }

   @Override
   public List<MdOrder> selectMdAllSales() {
      return owDAO.selectMdAllSales(sqlSession);
   }

   
	@Override
	public List<StoreStock> selectBarChart(int store_num) {
		return owDAO.selectBarChart(sqlSession,store_num);
	}
	   
   
	 @Override
	   public ArrayList<StartUp> searchNewMenu(HashMap<String,String> map) {
	      return owDAO.searchNewMenu(sqlSession, map);
	   }

   
   
   
   

}