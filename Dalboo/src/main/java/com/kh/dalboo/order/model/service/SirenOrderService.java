package com.kh.dalboo.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.order.model.vo.SirenOrderCart;
import com.kh.dalboo.owner.model.vo.StoreStock;

public interface SirenOrderService {

	int getListCount();

	ArrayList<Store> selectList(PageInfo pi);

	int insertSOCart(SirenOrderCart soc);

	ArrayList<SirenOrderCart> selectCartList(SirenOrderCart soc);

	Store selectStoreList(int store_num);

	SirenOrderCart selectCart(int so_cartNum);

	int soDelete(int so_cartNum);

	int minusAmount(int so_cartNum);

	int plusAmount(int so_cartNum);

	int insertSirenOrder(SirenOrder so, List<Integer> stock_num);

	
	
	
	ArrayList<StoreStock> choiceCoffee(int store_num);

	ArrayList<StoreStock> choiceAde(int store_num);

	ArrayList<StoreStock> choiceDessert(int store_num);

	ArrayList<StoreStock> choiceNewMenu(int store_num);
	
	ArrayList<StoreStock> AllMenuList(int store_num);

	
	int makeEmptyCart(String m_id);

	List<Integer> sameStockCheck(Map<String, Object> map);

	int updateAmountSOCart(Map<String, Object> map2);

	int getSearchListCount(HashMap<String, String> map);

	ArrayList<Store> searchStoreList(HashMap<String, String> map, PageInfo pi);

	
	
	
	
	int insertPointHistory(PointHistory ph);

	int updateMemberPoint(Member member);

	int storeSalesUpdate(Map<String, Integer> map);
	
	
}
