package com.kh.dalboo.etc.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.Faq;
import com.kh.dalboo.etc.model.vo.StartUp;
import com.kh.dalboo.etc.model.vo.Store;

@Repository("eDAO")
public class EtcDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("etcMapper.getListCount");
	}

	public ArrayList<Store> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("etcMapper.selectList", null, rowBounds);
	}

	public ArrayList<Faq> faqList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("etcMapper.faqList");
	}

	public int insertStore(SqlSessionTemplate sqlSession, Store s) {
		return sqlSession.insert("etcMapper.insertStore", s);
	}

	public int updateStore(SqlSessionTemplate sqlSession, Store s) {
		return sqlSession.update("etcMapper.updateStore", s);
	}

	public int deleteStore(SqlSessionTemplate sqlSession, int store_num) {
		return sqlSession.update("etcMapper.deleteStore", store_num);
	}

	public Store selectStore(SqlSessionTemplate sqlSession, int store_num) {
		return sqlSession.selectOne("etcMapper.selctStore", store_num);
	}


	
	public int addStartUpApply(SqlSessionTemplate sqlSession, StartUp s) {
		
		return sqlSession.insert("etcMapper.addApply", s);
	}
	
	
	
	public ArrayList<Store> searchStoreList(SqlSessionTemplate sqlSession, HashMap<String, String> map,PageInfo pi) {
      int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
      RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
      return (ArrayList)sqlSession.selectList("etcMapper.searchStoreList", map, rowBounds);
   }

   public int getSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
      return sqlSession.selectOne("etcMapper.getSearchListCount", map);
   }
	
	
	
}
