package com.kh.dalboo.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dalboo.board.model.vo.Board;
import com.kh.dalboo.board.model.vo.Reply;
import com.kh.dalboo.common.PageInfo;

@Repository("bDAO")
public class BoardDAO {

//	public BoardService bService;
	
//	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ이벤트 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getListCount");
	}

	public ArrayList<Board> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectList", null, rowBounds);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	public int addReadCount(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("boardMapper.addReadCount", bNum);
	}

	public Board selectBoard(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.selectOne("boardMapper.selectBoard", bNum);
	}

	
	
	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard",b);
	}


	public int boardDelete(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("boardMapper.deleteBoard",bNum);
	}

	
	
	
//	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ공지사항 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public int getListCount2(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getListCount2");
	}

	public ArrayList<Board> selectList2(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
//		return (ArrayList)sqlSession.selectList2("boardMapper.selectList2", null, rowBounds);
		return (ArrayList)sqlSession.selectList("boardMapper.selectList2", null, rowBounds);
	}

	public int insertBoard2(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard2", b);
	}

	public int addReadCount2(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("boardMapper.addReadCount2", bNum);
	}

	public Board selectBoard2(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.selectOne("boardMapper.selectBoard2", bNum);
	}

	
	
	public int updateBoard2(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard2",b);
	}


	public int boardDelete2(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("boardMapper.deleteBoard2",bNum);
	}
	
	
//	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ고객센터 게시판 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public int getListCount3(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getListCount3");
	}

	public ArrayList<Board> selectList3(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectList3", null, rowBounds);
	}
	
	
	public int insertBoard3(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard3", b);
	}

	public int addReadCount3(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("boardMapper.addReadCount3", bNum);
	}

	public Board selectBoard3(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.selectOne("boardMapper.selectBoard3", bNum);
	}

	
	
	public int updateBoard3(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard3",b);
	}


	public int boardDelete3(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("boardMapper.deleteBoard3",bNum);
	}
	
//  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ댓글 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
  public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, int bNum) {
     return (ArrayList)sqlSession.selectList("boardMapper.selectReplyList",bNum);
  }
  
  public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
     return sqlSession.insert("boardMapper.insertReply", r);
  }


  public int deleteReply(SqlSessionTemplate sqlSession, Reply r) {
     return sqlSession.update("boardMapper.deleteReply", r);
  }

}