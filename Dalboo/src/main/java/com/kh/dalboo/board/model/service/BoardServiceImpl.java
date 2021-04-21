package com.kh.dalboo.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dalboo.board.model.dao.BoardDAO;
import com.kh.dalboo.board.model.vo.Board;
import com.kh.dalboo.board.model.vo.Reply;
import com.kh.dalboo.common.PageInfo;


@Service("bService")
public class BoardServiceImpl implements BoardService{
	
//	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ이벤트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

	@Autowired
	private BoardDAO bDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int getListCount() {
		return bDAO.getListCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectList(PageInfo pi) {
		return bDAO.selectList(sqlSession, pi);
	}

	@Override
	public int insertBoard(Board b) {
		return bDAO.insertBoard(sqlSession, b);
	}

	@Override
	public Board selectBoard(int bNum) {
		int result = bDAO.addReadCount(sqlSession, bNum);
		
		Board b = null;
		if(result > 0) {
			b = bDAO.selectBoard(sqlSession, bNum);
		}
		return b;
	}
	
	@Override
	public int updateBoard(Board b) {
		return bDAO.updateBoard(sqlSession, b);
	}

	@Override
	public int boardDelete(int bNum) {
		return bDAO.boardDelete(sqlSession, bNum);
	}
	

//	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ공지사항ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

		@Override
	public int getListCount2() {
		return bDAO.getListCount2(sqlSession);
	}

	@Override
	public ArrayList<Board> selectList2(PageInfo pi) {
		return bDAO.selectList2(sqlSession, pi);
	}

	@Override
	public int insertBoard2(Board b) {
		return bDAO.insertBoard2(sqlSession, b);
	}

	@Override
	public Board selectBoard2(int bNum) {
		int result = bDAO.addReadCount2(sqlSession, bNum);
		
		Board b = null;
		if(result > 0) {
			b = bDAO.selectBoard2(sqlSession, bNum);
		}
		return b;
	}
	
	@Override
	public int updateBoard2(Board b) {
		return bDAO.updateBoard2(sqlSession, b);
	}

	@Override
	public int boardDelete2(int bNum) {
		return bDAO.boardDelete2(sqlSession, bNum);
	}
	
	
//	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ공지사항ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

	@Override
	public int getListCount3() {
		return bDAO.getListCount3(sqlSession);
	}

	@Override
	public ArrayList<Board> selectList3(PageInfo pi) {
		return bDAO.selectList3(sqlSession, pi);
	}
	
	@Override
	public int insertBoard3(Board b) {
		return bDAO.insertBoard3(sqlSession, b);
	}

	@Override
	public Board selectBoard3(int bNum) {
		int result = bDAO.addReadCount3(sqlSession, bNum);
		
		Board b = null;
		if(result > 0) {
			b = bDAO.selectBoard3(sqlSession, bNum);
		}
		return b;
	}
	
	@Override
	public int updateBoard3(Board b) {
		return bDAO.updateBoard3(sqlSession, b);
	}

	@Override
	public int boardDelete3(int bNum) {
		return bDAO.boardDelete3(sqlSession, bNum);
	}
	
//  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ댓글(답변) 등록 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
  @Override
  public ArrayList<Reply> selectReplyList(int bNum) {
     return bDAO.selectReplyList(sqlSession,bNum);
  }
  
  @Override
  public int insertReply(Reply r) {
     return bDAO.insertReply(sqlSession, r);
  }

  @Override
  public int deleteReply(Reply r) {
     return bDAO.deleteReply(sqlSession, r);
  }

}
