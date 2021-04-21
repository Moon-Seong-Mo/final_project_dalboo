package com.kh.dalboo.manager.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.manager.model.dao.ManagerDAO;
import com.kh.dalboo.manager.model.vo.CoffeeStock;
import com.kh.dalboo.owner.model.vo.StoreStock;

@Service("maService")
public class ManagerServiceImpl implements ManagerService{
   
   @Autowired
   private ManagerDAO maDAO;
   
   @Autowired
   private SqlSessionTemplate sqlSession;
   

//   @Override
//   public int insertMaterial(CoffeeStock cs) {
//      return maDAO.insertMaterial(sqlSession, cs);
//   }




   @Override
   public int insertStock(CoffeeStock cs) {
      return maDAO.insertStock(sqlSession, cs);
   }


   @Override
   public ArrayList<CoffeeStock> selectCoffeeStock() {
      return maDAO.selectCoffeeStock(sqlSession);
   }


//   @Override
//   public String chkMenu(Object setMaterialName) {
//      return maDAO.chkMenu(sqlSession, setMaterialName);
//   }


   @Override
   public ArrayList<StoreStock> selectStoreStock() {
      return maDAO.selectStoreStock(sqlSession);
   }


   @Override
   public ArrayList<Store> selectStore() {
      return maDAO.selectStore(sqlSession);
   }


   
   
   @Override
   public int getListCount() {
      return maDAO.getListCount(sqlSession);
   }


   @Override
   public ArrayList<StoreStock> selectDeliveryStatus(PageInfo pi) {
      return maDAO.selectDeliveryStatus(sqlSession,pi);
   }


   @Override
   public ArrayList<Store> selectStorename(PageInfo pi) {
      return maDAO.selectStorename(sqlSession);
   }

   
   @Override
   public int updateStatus(StoreStock ss) {
      return maDAO.updateStatus(sqlSession,ss);
   }

//   @Override
//   public int downStock(StoreStock ss) {
//      return maDAO.downStock(sqlSession,ss);
//   }
   @Override
   public int downStock(StoreStock s) {
      return maDAO.downStock(sqlSession,s);
   }


   @Override
   public ArrayList<StoreStock> selectStoreStockNum(int store_num) {
      return maDAO.selectStoreStockNum(sqlSession, store_num);
   }


   @Override
   public int updateStock(CoffeeStock cs) {
      return maDAO.updateStock(sqlSession,cs);
   }


   











}