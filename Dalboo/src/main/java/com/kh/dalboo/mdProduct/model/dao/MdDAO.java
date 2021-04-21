package com.kh.dalboo.mdProduct.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.mdProduct.model.vo.Cart;
import com.kh.dalboo.mdProduct.model.vo.Files;
import com.kh.dalboo.mdProduct.model.vo.MdOrder;
import com.kh.dalboo.mdProduct.model.vo.MdProduct;
import com.kh.dalboo.member.model.vo.Address;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;


@Repository("mdDAO")
public class MdDAO {

	public int getListCount(SqlSessionTemplate sqlSession, String mdCategory) {
		return sqlSession.selectOne("mdMapper.getListCount", mdCategory);
	}

	public ArrayList selectmdList(SqlSessionTemplate sqlSession, String mdCategory, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mdMapper.selectList", mdCategory, rowBounds);
	}
	public ArrayList selectfList(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("mdMapper.selectfList");
	}

	public int insertMdProduct(SqlSessionTemplate sqlSession, MdProduct md) {
		return sqlSession.insert("mdMapper.insertMdProduct", md);
	}

	public int insertFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.insert("mdMapper.insertFiles", f);
	}

	public MdProduct selectMdDetail(SqlSessionTemplate sqlSession, int mdNum) {
		return sqlSession.selectOne("mdMapper.selectDetail", mdNum);
	}

	public ArrayList<Files> selectMdFileDetail(SqlSessionTemplate sqlSession, int mdNum) {
		return (ArrayList)sqlSession.selectList("mdMapper.selectFileDetail", mdNum);
	}
	public int modifyMd(SqlSessionTemplate sqlSession, MdProduct md) {
		return sqlSession.update("mdMapper.updateMd", md);
	}

	public int modifyMdFile(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.update("mdMapper.updateFile", f);
	}

	public int deleteMdProduct(SqlSessionTemplate sqlSession, int mdNum) {
		return sqlSession.update("mdMapper.deleteMdProduct", mdNum);
	}

	public int deleteMdFile(SqlSessionTemplate sqlSession, int mdNum) {
		return sqlSession.update("mdMapper.deleteMdFile", mdNum);
	}


	public ArrayList<MdProduct> selectPopList(SqlSessionTemplate sqlSession, String mdCategory, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());		
		return (ArrayList)sqlSession.selectList("mdMapper.selectPopList", mdCategory, rowBounds);
	}
	
	public ArrayList<Cart> selectCartList(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("mdMapper.selectCartList", id);
	}
	
	public int insertCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.insert("mdMapper.insertCart", c);
	}

	public Cart selectCartNum(SqlSessionTemplate sqlSession, int cartNum) {
		return sqlSession.selectOne("mdMapper.selectCartNum", cartNum);
	}

	public int modifyCartRotn(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.update("mdMapper.cartRotn", c);
	}

	public int deleteCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.delete("mdMapper.deleteCart", c);
	}

	//memberMapper로 값 보내고 받아오기
	public ArrayList<Address> selectAddressList(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectAddress", id);
	}

	public ArrayList<Cart> selectCartCheckList(SqlSessionTemplate sqlSession, String chkArr) {
		return (ArrayList)sqlSession.selectList("mdMapper.selectCartCheckList", chkArr);
	}

	public int insertMdOrder(SqlSessionTemplate sqlSession, MdOrder mo, int i) {
		
		int result = 0;
		if(i == 1) {
			result = sqlSession.insert("mdMapper.insertMdOrder", mo);
		} else if(i == 2) {
			//MdOrder에 잘 들어갔으면 이제 장바구니를 비운다!, 2번이 장바구니에서 넘기는 값
			result = sqlSession.insert("mdMapper.insertMdOrder", mo);
			if(result > 0) {
				result = sqlSession.delete("mdMapper.deleteBuyCart", mo);
			}
		}
		if(result > 0) {
			//재고 줄여야함
			int amount = mo.getMdAmount();
			int mdNum = mo.getMdNum();
			
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("amount", amount);
			map.put("mdNum", mdNum);
			
			result = sqlSession.update("mdMapper.modifyDetailStock", map);
		}
		
		return result;
	}
	
	public int getMdOrderListCount(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.selectOne("mdMapper.getMdOrderListCount", mId);
	}

	public ArrayList<MdOrder> selectMdOrder(SqlSessionTemplate sqlSession, String mId, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mdMapper.selectMdOrderList", mId, rowBounds);
	}

	public ArrayList<MdProduct> selectMdOrderProduct(SqlSessionTemplate sqlSession, int mdNum) {
		return (ArrayList)sqlSession.selectList("mdMapper.selectMdOrderProduct", mdNum);
	}

	public ArrayList<Files> selectMdOrderFile(SqlSessionTemplate sqlSession, int mdNum) {
		return (ArrayList)sqlSession.selectList("mdMapper.selectMdOrderFile", mdNum);
	}

	public int getMdOrderManagementListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("mdMapper.getOrderManagement");
	}

	public ArrayList<MdOrder> selectMdShipManagement(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mdMapper.selectMdShipManagement", null , rowBounds);
	}

	
	//포인트 적립 위해 멤버로 보낸다.
	public int updateMemberPoint(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMemberPoint", m);
	}

	public int insertPointHistory(SqlSessionTemplate sqlSession, PointHistory ph) {
		return sqlSession.insert("memberMapper.insertMemberUpdatePoint", ph);
	}

	public int shipEnd(SqlSessionTemplate sqlSession, MdOrder mo) {
		return sqlSession.update("mdMapper.shipEnd", mo);
	}

	public int orderEnd(SqlSessionTemplate sqlSession, MdOrder mo) {
		return sqlSession.update("mdMapper.orderEnd", mo);
	}

	public int countMdShipStatus(SqlSessionTemplate sqlSession, String mId, int i) {
		int result = 0;
		
		if( i == 1) {
			result = sqlSession.selectOne("mdMapper.countMdShipOne", mId);
		} else {
			result = sqlSession.selectOne("mdMapper.countMdShipTwo", mId);
		}
		return result;
	}

	public ArrayList<MdOrder> selectOrderIng(SqlSessionTemplate sqlSession, int i) {
		return (ArrayList)sqlSession.selectList("mdMapper.selectOrderIngList", i);
	}

}
