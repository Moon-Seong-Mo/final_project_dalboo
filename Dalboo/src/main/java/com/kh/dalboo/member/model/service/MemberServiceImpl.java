package com.kh.dalboo.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.member.model.dao.MemberDAO;
import com.kh.dalboo.member.model.vo.Address;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;
import com.kh.dalboo.order.model.vo.SirenOrder;
import com.kh.dalboo.owner.model.vo.StoreStock;

@Service("mService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private MemberService mService;
	
	
	@Override
	public Member memberLogin(Member m) {
		return mDAO.selectMember(sqlSession, m);
	}

	@Override
	public int joinMember(Member m) {
		return mDAO.joinMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		return mDAO.updateMember(sqlSession, m);
	}
	
	@Override
	public int updatePwd(HashMap<String, String> map) {
		return mDAO.updatePwd(sqlSession, map);
	}
	

	@Override
	public int checkIdDup(String id) {
		return mDAO.checkIdDup(sqlSession, id);
	}
	
	
	//아이디 찾기
	@Override
	public Member findId(Member m) {
		return mDAO.findId(sqlSession,m);
	}


	
	
	
		
		//난수 생성한 뒤 그 난수가 임시 비밀번호가 된다.
		public int emailCertify(HashMap<String, String> map) throws Exception{
			
			int result = mDAO.emailCertify(map);
			
			
			if (result > 0) { 
				result = (int) (Math.random() * 999999) + 1;
				
			
				
				
				String setfrom = "dlwogns1123@gmail.com";

				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
				messageHelper.setTo(map.get("email")); // 받는사람 이메일
				messageHelper.setSubject("달보드레  임시비밀번호"); // 메일제목은 생략이 가능하다
				messageHelper.setText("당신의 임시비밀번호는 "+Integer.toString(result)+"입니다."); // 메일 내용
				String encPwd = "";
				encPwd=bcrypt.encode(Integer.toString(result));
			
				map.put("newPwd",encPwd);
				
				int success = mService.updatePwdtemp(map);

				
				if(success > 0) {//성공 시
					System.out.println("비밀번호 성공");
				}else {//실패시
					System.out.println("비밀번호 실패");
				}
				mailSender.send(message);
				
			
			} else { // 존재하지 않을 경우
				result = 0;
				System.out.println("아이디 이메일 존재하지 않습니다.");
			}
			
			return result;
		}


	

	
//	회원가입된 이메일인지 확인용 Service  
	@Override
	public int signUpedEmail(String email) throws Exception {
		
		int result = mDAO.signUpedEmail(email);
		return result;
	}
			
		
	
	
		
	@Override
	public int updatePwdemail(Member m) {
		return mDAO.updatePwdemail(sqlSession, m);
	}

	
	@Override
	public int updatePwdtemp(HashMap<String, String> map) {
		return mDAO.updatePwdtemp(map);
	}




	//지원
	@Override
	public int insertAddress(Address add) {
		return mDAO.insertAddress(sqlSession, add);
	}

	@Override
	public ArrayList<Address> selectAddress(String id) {
		return mDAO.selectAddress(sqlSession, id);
	}

	@Override
	public int deleteAddress(Address ad) {
		return mDAO.deleteAddress(sqlSession, ad);
	}

	@Override
	public int updateBaseAdd(int adNum, String id) {
		return mDAO.updateBaseAdd(sqlSession, adNum, id);
	}

	@Override
	public int insertMemberUpdatePoint(PointHistory ph) {
		return mDAO.insertMemberUpdatePoint(sqlSession, ph);
	}

	@Override
	public int getpointListCount(String mId) {
		return mDAO.getPointListCount(sqlSession, mId);
	}

	@Override
	public ArrayList<PointHistory> selectPointList(String mId, PageInfo pi) {
		return mDAO.selectPointList(sqlSession, mId, pi);
	}
	
	


	
	
	
	
	

	
	
	//새로운성모
	@Override
	public List<SirenOrder> coffee_orderList(String id, PageInfo pi) {
		
		List<SirenOrder> orderList = mDAO.coffee_orderList(sqlSession, id, pi);
		
		for(SirenOrder order : orderList) {
			order.setStockNames(mDAO.getOrderStockList(sqlSession, order.getSo_num()));
		}
		
		return orderList;
	}
	
	@Override
	public int updateStock(StoreStock ss) {
		return mDAO.updateStock(sqlSession, ss);
	}

	@Override
	public int getCoffeeListCount(String id) {
		return mDAO.getCoffeeListCount(sqlSession, id);
	}


	
	
	   @Override
	   public int deleteMember(String id) {
	      return mDAO.deleteMember(sqlSession, id);
	   }

	
	
	

	
	
	
	
	
}