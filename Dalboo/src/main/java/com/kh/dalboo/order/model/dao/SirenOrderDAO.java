package com.kh.dalboo.order.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.order.model.vo.SirenOrderCart;
import com.kh.dalboo.owner.model.vo.StoreStock;

@Repository("soDAO")
public class SirenOrderDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("etcMapper.getListCount");
	}

	public ArrayList<Store> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("etcMapper.selectList", null, rowBounds);
	}

	public int insertSOCart(SqlSessionTemplate sqlSession, SirenOrderCart soc) {
		return sqlSession.insert("sirenMapper.insertSOCart", soc);
	}

	public ArrayList<SirenOrderCart> selectCartList(SqlSessionTemplate sqlSession, SirenOrderCart soc) {
		return (ArrayList)sqlSession.selectList("sirenMapper.selectCartList", soc);
	}

	public Store selectStoreList(SqlSessionTemplate sqlSession, int store_num) {
		return sqlSession.selectOne("etcMapper.selctStore", store_num);
	}

	public SirenOrderCart SirenOrderCart(SqlSessionTemplate sqlSession, int so_cartNum) {
		return sqlSession.selectOne("sirenMapper.SirenOrderCart", so_cartNum);
	}
	
	public int soDelete(SqlSessionTemplate sqlSession, int so_cartNum) {
		return sqlSession.delete("sirenMapper.soDelete", so_cartNum);
	}

	public int minusAmount(SqlSessionTemplate sqlSession, int so_cartNum) {
		return sqlSession.update("sirenMapper.minusAmount", so_cartNum);
	}

	public int plusAmount(SqlSessionTemplate sqlSession, int so_cartNum) {
		return sqlSession.update("sirenMapper.plusAmount", so_cartNum);
	}

	public int insertSirenOrder(SqlSessionTemplate sqlSession, SirenOrder so) {
		return sqlSession.insert("sirenMapper.insertSirenOrder", so);
	}

	
	
	
	public ArrayList<StoreStock> choiceCoffee(SqlSessionTemplate sqlSession, int store_num) {
		return (ArrayList)sqlSession.selectList("sirenMapper.choiceCoffee", store_num);
	}

	public ArrayList<StoreStock> choiceAde(SqlSessionTemplate sqlSession, int store_num) {
		return (ArrayList)sqlSession.selectList("sirenMapper.choiceAde", store_num);
	}

	public ArrayList<StoreStock> choiceDessert(SqlSessionTemplate sqlSession, int store_num) {
		return (ArrayList)sqlSession.selectList("sirenMapper.choiceDessert", store_num);
	}

	public ArrayList<StoreStock> choiceNewMenu(SqlSessionTemplate sqlSession, int store_num) {
		return (ArrayList)sqlSession.selectList("sirenMapper.choiceNewMenu", store_num);
	}
	

	public int makeEmptyCart(SqlSessionTemplate sqlSession, String m_id) {
		return sqlSession.delete("sirenMapper.makeEmptyCart", m_id);
	}

	public int getOrderKey(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("sirenMapper.getOrderKey");
	}

	public int insertOrderStock(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.insert("sirenMapper.insertOrderStock", map);
	}

	public int updateAmountSOCart(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("sirenMapper.updateAmountSOCart", map);
	}

	public List<Integer> sameStockCheck(SqlSessionTemplate sqlSession, Map<String, Object> map2) {
		return sqlSession.selectList("sirenMapper.sameStockCheck", map2);
	}
	public ArrayList<StoreStock> NewMenuList(SqlSessionTemplate sqlSession, int store_num) {
		return (ArrayList)sqlSession.selectList("sirenMapper.NewMenuList", store_num);
	}

	public ArrayList<StoreStock> CoffeeList(SqlSessionTemplate sqlSession, int store_num) {
		return (ArrayList)sqlSession.selectList("sirenMapper.CoffeeList", store_num);
	}
	public ArrayList<StoreStock> AdeList(SqlSessionTemplate sqlSession, int store_num) {
		return (ArrayList)sqlSession.selectList("sirenMapper.AdeList", store_num);
	}
	public ArrayList<StoreStock> DessertList(SqlSessionTemplate sqlSession, int store_num) {
		return (ArrayList)sqlSession.selectList("sirenMapper.DessertList", store_num);
	}
	
	
	
	
	
	public ArrayList<Store> searchStoreList(SqlSessionTemplate sqlSession, HashMap<String, String> map,PageInfo pi) {
      int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
      RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
      return (ArrayList)sqlSession.selectList("etcMapper.searchStoreList", map, rowBounds);
   }

   public int getSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
      return sqlSession.selectOne("etcMapper.getSearchListCount", map);
   }
	
   
   
   
   public int insertPointHistory(SqlSessionTemplate sqlSession, PointHistory ph) {
		return sqlSession.insert("memberMapper.insertMemberUpdatePoint", ph);
	}

	public int updateMemberPoint(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.update("memberMapper.updateMemberPoint", member);
	}
   
	// 매장 매출 갱신
		public int storeSalesUpdate(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
			return sqlSession.update("sirenMapper.storeSalesUpdate", map);
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
