package com.kh.dalboo.mdProduct.model.service;

import java.util.ArrayList;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.mdProduct.model.vo.Cart;
import com.kh.dalboo.mdProduct.model.vo.Files;
import com.kh.dalboo.mdProduct.model.vo.MdOrder;
import com.kh.dalboo.mdProduct.model.vo.MdProduct;
import com.kh.dalboo.member.model.vo.Address;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;



public interface MdService {

	int getListCount(String mdCategory);

	int insertMD(MdProduct md, ArrayList<Files> files);

	ArrayList selectList(int i, String mdCategory, PageInfo pi);

	MdProduct selectMdDetail(int mdNum);

	ArrayList<Files> selecMdFileDetial(int mdNum);

	int modifyMd(MdProduct md);

	int modifyMdFile(MdProduct md, ArrayList<Files> files, int[] fileNum);

	int deleteMD(int mdNum);

	ArrayList<MdProduct> selectPopList(String mdCategory, PageInfo pi);

	ArrayList<Cart> selectCartList(String id);

	int insertCart(Cart c);

	Cart selectCartNum(int cartNum);

	int modifyCartRotn(Cart c);

	int deleteCart(Cart c);

	ArrayList<Address> selectAddressList(String mId);

	ArrayList<Cart> selectCartCheckList(String chkArr);

	int insertMdOrder(MdOrder mo, int i);

	int getMdOrderListCount(String mId);

	ArrayList<MdOrder> selectMdOrder(String mId, PageInfo pi);

	ArrayList<MdProduct> selectMdOrderProduct(int mdNum);

	ArrayList<Files> selectMdOrderFiles(int mdNum);

	int getMdOrderManagementListCount();
	
	ArrayList<MdOrder> selectMdShipManagement(PageInfo pi);

	int updateMemberPoint(Member m);

	int insertPointHistory(PointHistory ph);

	int shipEnd(MdOrder mo);

	int orderEnd(MdOrder mo);

	int countMdShipStatus(String mId, int i);

	ArrayList<MdOrder> selectOrderIng(int i);




}
