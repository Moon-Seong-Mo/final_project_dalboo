package com.kh.dalboo.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;
import com.kh.dalboo.order.model.dao.SirenOrderDAO;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.order.model.vo.SirenOrderCart;
import com.kh.dalboo.owner.model.vo.StoreStock;

@Service("soService")
public class SirenOrderServiceImpl implements SirenOrderService{

	@Autowired
	private SirenOrderDAO soDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int getListCount() {
		return soDAO.getListCount(sqlSession);
	}

	@Override
	public ArrayList<Store> selectList(PageInfo pi) {
		return soDAO.selectList(sqlSession, pi);
	}

	
	@Override
	public int insertSOCart(SirenOrderCart soc) {
		return soDAO.insertSOCart(sqlSession, soc);
	}

	
	@Override
	public ArrayList<SirenOrderCart> selectCartList(SirenOrderCart soc) {
		return soDAO.selectCartList(sqlSession, soc);
	}

	@Override
	public Store selectStoreList(int store_num) {
		return soDAO.selectStoreList(sqlSession, store_num);
	}

	@Override
	public SirenOrderCart selectCart(int so_cartNum) {
		return soDAO.SirenOrderCart(sqlSession, so_cartNum);
	}

	@Override
	public int soDelete(int so_cartNum) {
		return soDAO.soDelete(sqlSession, so_cartNum);
	}

	@Override
	public int minusAmount(int so_cartNum) {
		return soDAO.minusAmount(sqlSession, so_cartNum);
	}

	@Override
	public int plusAmount(int so_cartNum) {
		return soDAO.plusAmount(sqlSession, so_cartNum);
	}

	@Override
	public int insertSirenOrder(SirenOrder so, List<Integer> stock_num) {
		
		int pk = soDAO.getOrderKey(sqlSession);
		
		so.setSo_num(pk);
		
		int result = soDAO.insertSirenOrder(sqlSession, so);
		int result2 = 0;
		
		if(result > 0) {
			for(int stockKey : stock_num) {
				Map<String, Object> map = new HashMap<>();
				map.put("pk", pk);
				map.put("stockKey", stockKey);
				
				result2 = soDAO.insertOrderStock(sqlSession, map);
				if(result2 < 0) {
					break;
				}
			}
		}
		return result2;
	}

	
	
	@Override
	public ArrayList<StoreStock> choiceCoffee(int store_num) {
		return soDAO.choiceCoffee(sqlSession, store_num);
	}

	@Override
	public ArrayList<StoreStock> choiceAde(int store_num) {
		return soDAO.choiceAde(sqlSession, store_num);
	}

	@Override
	public ArrayList<StoreStock> choiceDessert(int store_num) {
		return soDAO.choiceDessert(sqlSession, store_num);
	}

	@Override
	public ArrayList<StoreStock> choiceNewMenu(int store_num) {
		return soDAO.choiceNewMenu(sqlSession, store_num);
	}
	
	@Override
	   public ArrayList<StoreStock> AllMenuList(int store_num) {
		
		ArrayList<StoreStock> list = new ArrayList<>();
		
		ArrayList<StoreStock> newMenu = soDAO.NewMenuList(sqlSession, store_num);
		ArrayList<StoreStock> coffee = soDAO.CoffeeList(sqlSession, store_num);
		ArrayList<StoreStock> ade = soDAO.AdeList(sqlSession, store_num);
		ArrayList<StoreStock> dessert = soDAO.DessertList(sqlSession, store_num);
		list.addAll(newMenu);
		list.addAll(coffee);
		list.addAll(ade);
		list.addAll(dessert);
	      return list;
	   }

	// 주문 완료 후 카트 목록 삭제
	@Override
	public int makeEmptyCart(String m_id) {
		return soDAO.makeEmptyCart(sqlSession, m_id);
	}

	
	
	
	@Override
	public List<Integer> sameStockCheck(Map<String, Object> map) {
		return soDAO.sameStockCheck(sqlSession, map);
	}

	@Override
	public int updateAmountSOCart(Map<String, Object> map2) {
		return soDAO.updateAmountSOCart(sqlSession, map2);
	}
	
	
	
	
	
	
	@Override
   public ArrayList<Store> searchStoreList(HashMap<String, String> map,PageInfo pi) {
      return soDAO.searchStoreList(sqlSession, map,pi);
   }

   @Override
   public int getSearchListCount(HashMap<String, String> map) {
      return soDAO.getSearchListCount(sqlSession,map);
   }
   
   
   @Override
	public int insertPointHistory(PointHistory ph) {
		return soDAO.insertPointHistory(sqlSession, ph);
	}

	@Override
	public int updateMemberPoint(Member member) {
		return soDAO.updateMemberPoint(sqlSession, member);
	}

	// 매장 매출 갱신
		@Override
		public int storeSalesUpdate(Map<String, Integer> map) {
			return soDAO.storeSalesUpdate(sqlSession, map);
		}
   
   
   

}
	
	
	
