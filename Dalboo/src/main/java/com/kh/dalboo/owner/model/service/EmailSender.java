package com.kh.dalboo.owner.model.service;

import java.util.HashMap;

import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class EmailSender extends SqlSessionDaoSupport{

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	public EmailSender(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	public void sendEmail(HashMap<String, String> map) throws Exception {
		// 메일 발송 기능 제공
		String setfrom = "DalbooCafe@gmail.com";
		String tomail = (String)map.get("mail"); // 받는 사람 이메일
		String title = "달보드레의 새로운 가족이 되신걸 환영합니다."; // 제목

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			String text = map.get("code");
			messageHelper.setText("발급된 로그인 코드입니다.[ " + text + " ]", true);
			
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
