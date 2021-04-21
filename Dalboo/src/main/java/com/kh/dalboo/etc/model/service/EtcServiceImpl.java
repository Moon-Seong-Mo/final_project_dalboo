package com.kh.dalboo.etc.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.dao.EtcDAO;
import com.kh.dalboo.etc.model.vo.Faq;
import com.kh.dalboo.etc.model.vo.StartUp;
import com.kh.dalboo.etc.model.vo.Store;


@Service("eService")
public class EtcServiceImpl implements EtcService{

	@Autowired
	private EtcDAO eDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int getListCount() {
		return eDAO.getListCount(sqlSession);
	}

	@Override
	public ArrayList<Store> selectList(PageInfo pi) {
		return eDAO.selectList(sqlSession, pi);
	}

	@Override
	public ArrayList<Faq> faqList() {
		return eDAO.faqList(sqlSession);
	}

	@Override
	public int insertStore(Store s) {
		return eDAO.insertStore(sqlSession, s);
	}

	@Override
	public int updateStore(Store s) {
		return eDAO.updateStore(sqlSession, s);
	}

	@Override
	public int deleteStore(int store_num) {
		return eDAO.deleteStore(sqlSession, store_num);
	}

	@Override
	public Store selectStore(int store_num) {
		return eDAO.selectStore(sqlSession, store_num);
	}

	
	@Override
	public int addStartUpApply(StartUp s) {
		return eDAO.addStartUpApply(sqlSession, s);
	}
	
	
	
	@Override
   public ArrayList<Store> searchStoreList(HashMap<String, String> map,PageInfo pi) {
      return eDAO.searchStoreList(sqlSession, map,pi);
   }

   @Override
   public int getSearchListCount(HashMap<String, String> map) {
      return eDAO.getSearchListCount(sqlSession,map);
   }
	
	
}
