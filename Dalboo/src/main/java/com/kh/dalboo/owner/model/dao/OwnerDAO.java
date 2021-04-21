package com.kh.dalboo.owner.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

@Repository
public class OwnerDAO {
   
   
   public int getApplyListCount(SqlSessionTemplate sqlSession) {
      return sqlSession.selectOne("managerMapper.getApplyListCount");
   }

   public ArrayList<StartUp> selectApplyList(SqlSessionTemplate sqlSession, PageInfo pi) {
      int offset = (pi.getCurrentPage() -1)* pi.getBoardLimit();
      RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
      
      return (ArrayList)sqlSession.selectList("managerMapper.selectApplyList", null, rowBounds);
   }

   public StartUp selectApplydetail(SqlSessionTemplate sqlSession, int sNum) {
      
      return sqlSession.selectOne("managerMapper.selectApplydetail", sNum);
   }

   public int applyChk(SqlSessionTemplate sqlSession, StartUp s) {
      return sqlSession.update("managerMapper.applyCheck", s);
   }

   public int deleteApply(SqlSessionTemplate sqlSession, int sNum) {
      return sqlSession.update("managerMapper.deleteApply", sNum);
   }

   public int insertStore(SqlSessionTemplate sqlSession, Store store) {
      return sqlSession.insert("managerMapper.insertStore", store);
   }

   public ArrayList<StartUp> searchApplyList(SqlSessionTemplate sqlSession, HashMap<String,String> map) {
      return (ArrayList)sqlSession.selectList("managerMapper.searchApply", map);
   }

   public Store ownerLogin(SqlSessionTemplate sqlSession, Store s) {
      return sqlSession.selectOne("managerMapper.ownerLogin", s);
   }

   public int ownerinsertMaterial(SqlSessionTemplate sqlSession, StoreStock cs) {
      return sqlSession.insert("ownerMapper.ownerinsertMaterial",cs);
   }

   public ArrayList<CoffeeStock> ownerselectCoffeeStock(SqlSessionTemplate sqlSession) {
      return (ArrayList)sqlSession.selectList("ownerMapper.selectCoffeeStock");
   }

   public ArrayList<StoreStock> ownerselectCoffeeInventory(SqlSessionTemplate sqlSession, int store_num) {
      return (ArrayList)sqlSession.selectList("ownerMapper.selectCoffeeInventory",store_num);
   }

   public ArrayList<StoreStock> ownerselectOrderStatus(SqlSessionTemplate sqlSession,int storeNum) {
      return (ArrayList)sqlSession.selectList("ownerMapper.selectOrderStatus",storeNum);
   }
   
   
   
   
   
   
   
   //진욱
   public int insertOnmboard(SqlSessionTemplate sqlSession, OwnerNewMenuBoard b) {
      return sqlSession.insert("managerMapper.insertOnmBoard", b);
   }

   public int insertOnmFiles(SqlSessionTemplate sqlSession, OwnerNewMenuFiles f) {
      return sqlSession.insert("managerMapper.insertOnmFiles", f);
   }

   public int getListCount(SqlSessionTemplate sqlSession) {
      return sqlSession.selectOne("managerMapper.getMenuListCount");
   }

   public ArrayList<OwnerNewMenuBoard> selectOwnerMenuList(SqlSessionTemplate sqlSession, PageInfo pi) {
      int offset = (pi.getCurrentPage() -1)* pi.getBoardLimit();
      RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
      
      return (ArrayList)sqlSession.selectList("managerMapper.selectOwnerMenuList", null, rowBounds);
   }

   public int addViewsCount(SqlSessionTemplate sqlSession, int onmNum) {
      return sqlSession.update("managerMapper.addViewsCount", onmNum);
   }

   public OwnerNewMenuBoard selectNewMenuBoard(SqlSessionTemplate sqlSession, int onmNum) {
      return sqlSession.selectOne("managerMapper.selectNewMenuBoard", onmNum);
   }

   public ArrayList<OwnerNewMenuFiles> selectNewMenuFile(SqlSessionTemplate sqlSession, int onmNum) {
      return (ArrayList)sqlSession.selectList("managerMapper.selectNewMenuFile", onmNum);
   }

   public int deleteNewMenu(SqlSessionTemplate sqlSession, int onmNum) {
      return sqlSession.update("managerMapper.deleteNewMenu", onmNum);
   }

   public int updateONmboard(SqlSessionTemplate sqlSession, OwnerNewMenuBoard b) {
      return sqlSession.update("managerMapper.updateONmboard", b);
   }

   public int updateONMfile(SqlSessionTemplate sqlSession, OwnerNewMenuFiles f) {
      return sqlSession.update("managerMapper.updateONMfile", f);
   }

   public int addinsertOnmFiles(SqlSessionTemplate sqlSession, OwnerNewMenuFiles f) {
      return sqlSession.insert("managerMapper.addinsertOnmFiles", f);
   }

   public int deleteNewMenuFile(SqlSessionTemplate sqlSession, int fNum) {
      return sqlSession.update("managerMapper.deleteNewMenuFile", fNum);
   }

   public int rollbackUpdate(SqlSessionTemplate sqlSession, int onmNum) {
      return sqlSession.update("managerMapper.rollbackUpdate", onmNum);
   }

   public int updateOnmFilesContent(SqlSessionTemplate sqlSession, OwnerNewMenuFiles fi) {
      return sqlSession.update("managerMapper.updateOnmFilesContent", fi);
   }

   
   
   
   
   
   
   
   //지원
   public int insertOwnerNotice(SqlSessionTemplate sqlSession, OwnerNotice on) {
      return sqlSession.insert("ownerMapper.insertOwnerNotice", on);
   }

   public int getNoticeCount(SqlSessionTemplate sqlSession) {
      return sqlSession.selectOne("ownerMapper.selectNoticeCount");
   }

   public ArrayList<OwnerNotice> selectOnwerNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
      
      int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
      
      RowBounds rowBounds  = new RowBounds(offset, pi.getBoardLimit());
      
      return (ArrayList)sqlSession.selectList("ownerMapper.selectOnwerNoticeList", null, rowBounds);
   }

   public int updateNoticeCount(SqlSessionTemplate sqlSession, int onNo) {
      return sqlSession.update("ownerMapper.updateNoticeCount", onNo);
   }
   
   public OwnerNotice selectOwnerNoticeDetail(SqlSessionTemplate sqlSession, int onNo) {
      return sqlSession.selectOne("ownerMapper.selectOwnerNoticeDetail", onNo);
   }

   public int deleteNotice(SqlSessionTemplate sqlSession, int onNo) {
      return sqlSession.update("ownerMapper.deleteNotice", onNo);
   }

   public int modifyNotice(SqlSessionTemplate sqlSession, OwnerNotice on) {
      return sqlSession.update("ownerMapper.modifyNotice", on);
   }

   public int getSearchResultCount(SqlSessionTemplate sqlSession, Search s) {
      return sqlSession.selectOne("ownerMapper.getSearchResultCount", s);
   }

   public ArrayList<OwnerNotice> selectSearchResultList(SqlSessionTemplate sqlSession, Search s, PageInfo pi) {
      int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
      
      RowBounds rowBounds  = new RowBounds(offset, pi.getBoardLimit());      
      return (ArrayList)sqlSession.selectList("ownerMapper.selectSearchResultList", s, rowBounds);
   }

   public ArrayList<OwnerNotice> selectOwnerMainNoticeList(SqlSessionTemplate sqlSession) {
      return (ArrayList)sqlSession.selectList("ownerMapper.selectOwnerMainNoticeList");
   }
   
   
   
   
   
   
   public List<Store> selectSalesAll(SqlSessionTemplate sqlSession) {
	      return sqlSession.selectList("ownerMapper.selectSalesAll");
	   }

   public List<Store> selectSalesMyStore(SqlSessionTemplate sqlSession, int store_num) {
	      return sqlSession.selectList("ownerMapper.selectSalesStore", store_num);
	   }

   public List<SirenOrder> selectdoughnut(SqlSessionTemplate sqlSession) {
      return sqlSession.selectList("ownerMapper.selectdoughnut");
   }

   public Member adminLogin(SqlSessionTemplate sqlSession, Map<String, String> map) {
         return sqlSession.selectOne("ownerMapper.adminLogin", map);
   }

   public List<MdOrder> selectMdAllSales(SqlSessionTemplate sqlSession) {
      return sqlSession.selectList("mdMapper.selectMdAllSales");
   }

	public List<StoreStock> selectBarChart(SqlSessionTemplate sqlSession,int store_num) {
		return sqlSession.selectList("ownerMapper.selectBarChart",store_num);
	}
	
	
	
	public ArrayList<StartUp> searchNewMenu(SqlSessionTemplate sqlSession, HashMap<String,String> map) {
      return (ArrayList)sqlSession.selectList("managerMapper.searchNewMenu", map);
   }
	
	
	
   
   
}