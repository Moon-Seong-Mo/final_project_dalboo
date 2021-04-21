package com.kh.dalboo.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.member.model.vo.Address;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.owner.model.vo.StoreStock;

@Repository("mDAO")
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//비밀번호 찾기용 하다가 바꾼거 바로밑에꺼랑 바꾸기
//	public Member selectMember(SqlSessionTemplate sqlSession, Member m) {
//		return sqlSession.selectOne("memberMapper.selectOne", m);
//	}
	public Member selectMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.selectOne", m);
	}

	public int joinMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.joinMember", m);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}
	
	public int updatePwd(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("memberMapper.updatePwd", map);
	}
	

	public int checkIdDup(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("memberMapper.checkIdDup",id);
	}

	
	//비밀번호 변경
	public int updatePwd(Member m) throws Exception{
		return sqlSession.update("memberMapper.updatePwd", m);
	}


	//회원가입된 이메일인지 확인
	public int signUpedEmail(String email) {
		return sqlSession.selectOne("memberMapper.signUpedEmail", email);
	}
	
	//메일 확인
	public int emailCertify(HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.emailCertify", map);
	}
	
	public int updatePwdemail(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updatePwdemail", m);
	}

	public int updatePwdtemp(HashMap<String, String> map) {
		return sqlSession.update("memberMapper.updatePwdtemp", map);
	}

	

	public Member findId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.findId",m);
	}
	




	
	
	
	//지원

	public int insertAddress(SqlSessionTemplate sqlSession, Address add) {
		
		int result = sqlSession.selectOne("memberMapper.selectAddressDefault", add.getId());
		if(result == 0) {
			//배송지 추가 시 배송지가 없는 상태라면 기본 배송지로 바꾼다
			result = sqlSession.insert("memberMapper.insertAddressDefault", add);
		} else {
			result = sqlSession.insert("memberMapper.insertAddress", add);
		}
		
		return result;
	}

	public ArrayList<Address> selectAddress(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList) sqlSession.selectList("memberMapper.selectAddress", id);
	}

	public int deleteAddress(SqlSessionTemplate sqlSession, Address ad) {
		return sqlSession.update("memberMapper.deleteAddress", ad);
	}

	public int updateBaseAdd(SqlSessionTemplate sqlSession, int adNum, String id) {

		int result = sqlSession.update("memberMapper.updateBaseDefault", id);

		if (result > 0) {
			result = sqlSession.update("memberMapper.updateBaseAdd", adNum);
		}

		return result;
	}

	public int insertMemberUpdatePoint(SqlSessionTemplate sqlSession, PointHistory ph) {
		return sqlSession.insert("memberMapper.insertMemberUpdatePoint", ph);
	}

	public int getPointListCount(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.selectOne("memberMapper.getPointListCount", mId);
	}

	public ArrayList<PointHistory> selectPointList(SqlSessionTemplate sqlSession, String mId, PageInfo pi) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList) sqlSession.selectList("memberMapper.pointHistoryList", mId, rowBounds);
	}
	
	
	
	
	
	
	
	public ArrayList<SirenOrder> coffee_orderList(SqlSessionTemplate sqlSession2, String id, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
				
		return (ArrayList)sqlSession.selectList("sirenMapper.coffee_orderList", id, rowBounds);
	}
	public int updateStock(SqlSessionTemplate sqlSession, StoreStock ss) {
		return sqlSession.update("ownerMapper.updateStock", ss);
	}

	public List<String> getOrderStockList(SqlSessionTemplate sqlSession, int so_num) {
		return sqlSession.selectList("sirenMapper.getOrderStockList", so_num);
	}

	public int getCoffeeListCount(SqlSessionTemplate sqlSession2, String id) {
		return sqlSession.selectOne("sirenMapper.getCoffeeListCount", id);
	}


	
	
	   public int deleteMember(SqlSessionTemplate sqlSession2, String id) {
		      return sqlSession.update("memberMapper.deleteMember", id);
		   }


	

}
