package com.kh.dalboo.manager.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.manager.model.vo.CoffeeStock;
import com.kh.dalboo.owner.model.vo.StoreStock;

@Repository("maDAO")
public class ManagerDAO {


//   public int insertMaterial(SqlSessionTemplate sqlSession, CoffeeStock cs) {
//      return sqlSession.insert("managerMapper.insertMaterial",cs);
//   }

//   public ArrayList selectMaterial(SqlSessionTemplate sqlSession, CoffeeStock cs) {
//      return (ArrayList)sqlSession.selectList("managerMapper.selectMaterial",cs);
//   }

   public int insertStock(SqlSessionTemplate sqlSession, CoffeeStock c) {
      return sqlSession.insert("managerMapper.insertStock", c);
   }

   public ArrayList<CoffeeStock> selectCoffeeStock(SqlSessionTemplate sqlSession) {
//      return (ArrayList)sqlSession.selectList("managerMapper.selectCoffeeStock");
      return (ArrayList)sqlSession.selectList("ownerMapper.selectCoffeeStock");
   }

   public String chkMenu(SqlSessionTemplate sqlSession, Object setMaterialName) {
      return sqlSession.selectOne("managerMapper.selectName", setMaterialName);
   }

   public ArrayList<StoreStock> selectStoreStock(SqlSessionTemplate sqlSession) {
      return (ArrayList)sqlSession.selectList("managerMapper.selectStoreStock");
   }

   public ArrayList<Store> selectStore(SqlSessionTemplate sqlSession) {
      return (ArrayList)sqlSession.selectList("managerMapper.selectStore");
   }

   
   
   public int getListCount(SqlSessionTemplate sqlSession) {
      return sqlSession.selectOne("managerMapper.getListCount");
   }
   

   public ArrayList<StoreStock> selectDeliveryStatus(SqlSessionTemplate sqlSession, PageInfo pi) {
      int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
      RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
      return (ArrayList)sqlSession.selectList("managerMapper.selectDeliveryStatus", null, rowBounds);
   }

   public ArrayList<Store> selectStorename(SqlSessionTemplate sqlSession) {
      return (ArrayList)sqlSession.selectList("managerMapper.selectStorename");
   }
   
//   public ArrayList<StoreStock> selectDeliveryStatus(SqlSessionTemplate sqlSession) {
//      return (ArrayList)sqlSession.selectList("managerMapper.selectDeliveryStatus");
//   }
//   
//   public ArrayList<Store> selectStorename(SqlSessionTemplate sqlSession) {
//      return (ArrayList)sqlSession.selectList("managerMapper.selectStorename");
//   }

   
   
   public int updateStatus(SqlSessionTemplate sqlSession, StoreStock ss) {
      return sqlSession.update("managerMapper.updateStatus", ss);
   }
   
   public int downStock(SqlSessionTemplate sqlSession, StoreStock s) {
      return sqlSession.update("managerMapper.downStock",s);
   }

   public ArrayList<StoreStock> selectStoreStockNum(SqlSessionTemplate sqlSession, int store_num) {
      return (ArrayList)sqlSession.selectList("managerMapper.selectStoreStockNum", store_num);
   }
   
   public int updateStock(SqlSessionTemplate sqlSession, CoffeeStock cs) {
      return sqlSession.update("managerMapper.updateStock", cs);
   }




   

   



}