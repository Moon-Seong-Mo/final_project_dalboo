package com.kh.dalboo.mdProduct.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.mdProduct.model.dao.MdDAO;
import com.kh.dalboo.mdProduct.model.vo.Cart;
import com.kh.dalboo.mdProduct.model.vo.Files;
import com.kh.dalboo.mdProduct.model.vo.MdOrder;
import com.kh.dalboo.mdProduct.model.vo.MdProduct;
import com.kh.dalboo.member.model.vo.Address;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;

@Service("mdService")
public class MdServiceImpl implements MdService{
	
	@Autowired
	private MdDAO mdDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	

	@Override
	public int getListCount(String mdCategory) {
		return mdDAO.getListCount(sqlSession, mdCategory);
	}

	@Override
	public int insertMD(MdProduct md, ArrayList<Files> files) {
		
		int result = 0;
		
		result = mdDAO.insertMdProduct(sqlSession, md);
		
		
		if(result > 0) {
			for(Files f : files) {
				result = mdDAO.insertFiles(sqlSession, f);
			}
		}
		
		return result;
	}

	@Override
	public ArrayList selectList(int i, String mdCategory, PageInfo pi) {
		ArrayList list = null;
		
		if(i == 1) {
			list = mdDAO.selectmdList(sqlSession, mdCategory, pi);
		} else {
			list = mdDAO.selectfList(sqlSession);
		}
		
		return list;
	}

	@Override
	public MdProduct selectMdDetail(int mdNum) {
		return mdDAO.selectMdDetail(sqlSession, mdNum);
	}

	
	@Override
	public ArrayList<Files> selecMdFileDetial(int mdNum) {
		return mdDAO.selectMdFileDetail(sqlSession, mdNum);
	}

	
	@Override
	public int modifyMd(MdProduct md) {
		return mdDAO.modifyMd(sqlSession, md);
	}

	@Override
	public int modifyMdFile(MdProduct md, ArrayList<Files> files, int[] fileNum) {
		
		int result = 0;
		
		result = mdDAO.modifyMd(sqlSession, md);
		
		if(result > 0) {
			for(Files f : files) {
				result = mdDAO.modifyMdFile(sqlSession, f);
			}
		}
		
		return result;
	}

	@Override
	public int deleteMD(int mdNum) {
		
		int result = 0;
		
		result = mdDAO.deleteMdProduct(sqlSession, mdNum);
		
		if(result > 0) {
			result = mdDAO.deleteMdFile(sqlSession, mdNum);
		}
		
		return result;
	}


	@Override
	public ArrayList<MdProduct> selectPopList(String mdCategory, PageInfo pi) {
		return mdDAO.selectPopList(sqlSession, mdCategory, pi);
	}
	
	@Override
	public ArrayList<Cart> selectCartList(String id) {
		return mdDAO.selectCartList(sqlSession, id);
	}
 
	@Override
	public int insertCart(Cart c) {	
		return mdDAO.insertCart(sqlSession, c);
	}

	@Override
	public Cart selectCartNum(int cartNum) {
		return mdDAO.selectCartNum(sqlSession, cartNum);
	}

	@Override
	public int modifyCartRotn(Cart c) {
		return mdDAO.modifyCartRotn(sqlSession,c);
	}

	@Override
	public int deleteCart(Cart c) {
		return mdDAO.deleteCart(sqlSession, c);
	}

	@Override
	public ArrayList<Address> selectAddressList(String mId) {
		return mdDAO.selectAddressList(sqlSession, mId);
	}

	@Override
	public ArrayList<Cart> selectCartCheckList(String chkArr) {
		return mdDAO.selectCartCheckList(sqlSession, chkArr);
	}

	@Override
	public int insertMdOrder(MdOrder mo, int i) {
		return mdDAO.insertMdOrder(sqlSession, mo, i);
	}
	
	@Override
	public int getMdOrderListCount(String mId) {
		return mdDAO.getMdOrderListCount(sqlSession, mId);
	}

	@Override
	public ArrayList<MdOrder> selectMdOrder(String mId, PageInfo pi) {
		return mdDAO.selectMdOrder(sqlSession, mId, pi);
	}

	@Override
	public ArrayList<MdProduct> selectMdOrderProduct(int mdNum) {
		return mdDAO.selectMdOrderProduct(sqlSession, mdNum);
	}

	@Override
	public ArrayList<Files> selectMdOrderFiles(int mdNum) {
		return mdDAO.selectMdOrderFile(sqlSession, mdNum);
	}

	@Override
	public int getMdOrderManagementListCount() {
		return mdDAO.getMdOrderManagementListCount(sqlSession);
	}

	@Override
	public ArrayList<MdOrder> selectMdShipManagement(PageInfo pi) {
		return mdDAO.selectMdShipManagement(sqlSession, pi);
	}

	@Override
	public int updateMemberPoint(Member m) {
		return mdDAO.updateMemberPoint(sqlSession, m);
	}

	@Override
	public int insertPointHistory(PointHistory ph) {
		return mdDAO.insertPointHistory(sqlSession, ph);
	}

	@Override
	public int shipEnd(MdOrder mo) {
		return mdDAO.shipEnd(sqlSession, mo);
	}

	@Override
	public int orderEnd(MdOrder mo) {
		return mdDAO.orderEnd(sqlSession, mo);
	}

	@Override
	public int countMdShipStatus(String mId, int i) {
		return mdDAO.countMdShipStatus(sqlSession, mId, i);
	}

	@Override
	public ArrayList<MdOrder> selectOrderIng(int i) {
		return mdDAO.selectOrderIng(sqlSession, i);
	}

}
