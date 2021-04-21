package com.kh.dalboo.manager.model.service;

import java.util.ArrayList;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.etc.model.vo.Store;
import com.kh.dalboo.manager.model.vo.CoffeeStock;
import com.kh.dalboo.owner.model.vo.StoreStock;

public interface ManagerService {


   int insertStock(CoffeeStock cs);

   ArrayList<CoffeeStock> selectCoffeeStock();

   
   
   ArrayList<StoreStock> selectStoreStock();

   ArrayList<Store> selectStore();

   

   
   int getListCount();
   
   ArrayList<StoreStock> selectDeliveryStatus(PageInfo pi);

   ArrayList<Store> selectStorename(PageInfo pi);

   
   int updateStatus(StoreStock ss);
   
   int downStock(StoreStock s);

   ArrayList<StoreStock> selectStoreStockNum(int store_num);

   int updateStock(CoffeeStock cs);


   
   




}