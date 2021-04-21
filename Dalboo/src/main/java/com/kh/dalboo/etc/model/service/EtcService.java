package com.kh.dalboo.etc.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.Faq;
import com.kh.dalboo.etc.model.vo.StartUp;
import com.kh.dalboo.etc.model.vo.Store;




public interface EtcService {

	int getListCount();

	ArrayList<Store> selectList(PageInfo pi);

	ArrayList<Faq> faqList();

	int insertStore(Store s);

	int updateStore(Store s);

	int deleteStore(int store_num);

	Store selectStore(int store_num);


	int addStartUpApply(StartUp s);
	
	
	ArrayList<Store> searchStoreList(HashMap<String, String> map,PageInfo pi);

   int getSearchListCount(HashMap<String, String> map);
	
}
