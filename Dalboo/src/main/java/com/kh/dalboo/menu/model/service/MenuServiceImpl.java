package com.kh.dalboo.menu.model.service;

import java.util.ArrayList;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dalboo.menu.model.dao.MenuDAO;
import com.kh.dalboo.menu.model.vo.Menu;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
		
		
	@Autowired
	private MenuDAO menuDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public int insertMenu(Menu m) {
		return menuDAO.insertMenu(sqlSession, m);
	}

	
	@Override
	public ArrayList<Menu> selectList() {
		return menuDAO.selectList(sqlSession);
	}



	@Override
	public ArrayList<Menu> selectList2() {
		return menuDAO.selectList2(sqlSession);
	}
	
	@Override
	public ArrayList<Menu> selectList3() {
		return menuDAO.selectList3(sqlSession);
	}
	
	@Override
	public ArrayList<Menu> selectList4() {
		return menuDAO.selectList4(sqlSession);
	}



	@Override
	public int coffeeDelete(int mNum) {
		return menuDAO.deleteCoffee(sqlSession, mNum);
	}
	@Override
	public int adeDelete(int mNum) {
		return menuDAO.deleteAde(sqlSession, mNum);
	}
	@Override
	public int dessertDelete(int mNum) {
		return menuDAO.deleteDessert(sqlSession, mNum);
	}
	@Override
	public int newmenuDelete(int mNum) {
		return menuDAO.deleteNewmenu(sqlSession, mNum);
	}
	





}
