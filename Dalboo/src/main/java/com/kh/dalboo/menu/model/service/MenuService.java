package com.kh.dalboo.menu.model.service;

import java.util.ArrayList;

import com.kh.dalboo.menu.model.vo.Menu;

public interface MenuService {

	int insertMenu(Menu m);
	
	ArrayList<Menu> selectList();

	ArrayList<Menu> selectList2();
	
	ArrayList<Menu> selectList3();
	
	ArrayList<Menu> selectList4();





	int coffeeDelete(int mNum);
	int dessertDelete(int mNum);
	int adeDelete(int mNum);
	int newmenuDelete(int mNum);








	
}
