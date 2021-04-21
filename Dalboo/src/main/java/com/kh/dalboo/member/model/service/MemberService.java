package com.kh.dalboo.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.member.model.vo.Address;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.owner.model.vo.StoreStock;

public interface MemberService {

	Member memberLogin(Member m);
	int joinMember(Member m);
	int updateMember(Member m);
	int updatePwd(HashMap<String, String> map);
	int checkIdDup(String id);
	
	
	
	
	public abstract int signUpedEmail(String email) throws Exception;
	
	public abstract int emailCertify(HashMap<String, String> map) throws Exception;
	
	
	int updatePwdemail(Member m);
	
	
	
	int updatePwdtemp(HashMap<String, String> map);
	

//	ArrayList<Member> findId(Member m);
	
	
	
	//지원
	int insertAddress(Address add);

	ArrayList<Address> selectAddress(String id);

	int deleteAddress(Address ad);

	int updateBaseAdd(int adNum, String id);

	int insertMemberUpdatePoint(PointHistory ph);

	int getpointListCount(String mId);

	ArrayList<PointHistory> selectPointList(String mId, PageInfo pi);
	
	
	
	Member findId(Member m);
	
	
	
	
	List<SirenOrder> coffee_orderList(String id, PageInfo pi);
	int updateStock(StoreStock ss);
	int getCoffeeListCount(String id);
	int deleteMember(String id);

	
	
	
	

	
	

	

	
	
	
	
	


}
