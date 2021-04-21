package com.kh.dalboo.menu.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dalboo.menu.model.vo.Menu;

@Repository("menuDAO")
public class MenuDAO {

	public int insertMenu(SqlSessionTemplate sqlSession, Menu m) {
		return sqlSession.insert("menuMapper.insertMenu", m);
	}
	

	public ArrayList<Menu> selectList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("menuMapper.selectList");
	}

	public ArrayList<Menu> selectList2(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("menuMapper.selectList2");
	}
	
	public ArrayList<Menu> selectList3(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("menuMapper.selectList3");
	}
	
	public ArrayList<Menu> selectList4(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("menuMapper.selectList4");
	}


	public int deleteCoffee(SqlSessionTemplate sqlSession, int mNum) {
		return sqlSession.update("menuMapper.deleteCoffee", mNum);
	}
	public int deleteAde(SqlSessionTemplate sqlSession, int mNum) {
		return sqlSession.update("menuMapper.deleteAde", mNum);
	}
	public int deleteDessert(SqlSessionTemplate sqlSession, int mNum) {
		return sqlSession.update("menuMapper.deleteDessert", mNum);
	}
	public int deleteNewmenu(SqlSessionTemplate sqlSession, int mNum) {
		return sqlSession.update("menuMapper.deleteNewmenu", mNum);
	}
	
	





	
	
}
