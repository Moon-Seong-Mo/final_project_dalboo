package com.kh.dalboo.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dalboo.board.model.vo.NewMenuBoard;
import com.kh.dalboo.board.model.vo.NewMenuFiles;
import com.kh.dalboo.board.model.vo.Vote;
import com.kh.dalboo.common.PageInfo;

@Repository
public class NewMenuDAO {

	public int insertNmboard(SqlSessionTemplate sqlSession, NewMenuBoard b) {
		return sqlSession.insert("newMenuMapper.insertNmBoard", b);
	}

	public int insertNfile(SqlSessionTemplate sqlSession, NewMenuFiles fi) {
		return sqlSession.insert("newMenuMapper.insertNfile", fi);
	}

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("newMenuMapper.getListCount");
	}

	public ArrayList<NewMenuBoard> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() -1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("newMenuMapper.selectList", null, rowBounds);
	}

	public int addReadCount(SqlSessionTemplate sqlSession, int nNum) {
		return sqlSession.update("newMenuMapper.addReadCount", nNum);
	}

	public NewMenuBoard selectBoard(SqlSessionTemplate sqlSession, int nNum) {
		return sqlSession.selectOne("newMenuMapper.selectBoard", nNum);
	}

	public ArrayList<NewMenuFiles> selectFile(SqlSessionTemplate sqlSession, int nNum) {
		
		return (ArrayList)sqlSession.selectList("newMenuMapper.selectFile", nNum);
	}

	public int deleteNewMenuBoard(SqlSessionTemplate sqlSession, int nNum) {
		
		return sqlSession.update("newMenuMapper.deleteNewMenuBoard", nNum);
	}

	public int updateNmboard(SqlSessionTemplate sqlSession, NewMenuBoard b) {
		return sqlSession.update("newMenuMapper.updateNmboard", b);
	}

	public int updateNfile(SqlSessionTemplate sqlSession, NewMenuFiles f) {
		return sqlSession.update("newMenuMapper.updateNfile", f);
	}
	
	public int MemberVoteStatus(SqlSessionTemplate sqlSession,  Vote v) {
		return sqlSession.insert("newMenuMapper.voteStatus", v);
	}
	
	public int addVoteCount(SqlSessionTemplate sqlSession, Vote v) {
		return sqlSession.update("newMenuMapper.addVoteCount", v);
	}

	public int voteStatusChk(SqlSessionTemplate sqlSession, Vote v) {
		return sqlSession.selectOne("newMenuMapper.voteStatusChk", v);
	}

	public int voteMenuDelete(SqlSessionTemplate sqlSession, int fNum) {
		return sqlSession.update("newMenuMapper.voteMenuDelete", fNum);
	}

	public int addinsertNfile(SqlSessionTemplate sqlSession, NewMenuFiles f) {
		return sqlSession.insert("newMenuMapper.addinsertNfile", f);
	}

	public int rollbackUpdate(SqlSessionTemplate sqlSession, int nNum) {
		return sqlSession.update("newMenuMapper.rollbackUpdate", nNum);
	}

	public int voteStatusEnd(SqlSessionTemplate sqlSession, int nNum) {
		return sqlSession.update("newMenuMapper.voteStatusEnd", nNum);
	}

	public Vote voteTotalCount(SqlSessionTemplate sqlSession, int nNum) {
		return sqlSession.selectOne("newMenuMapper.voteTotalCount", nNum);
	}

	public NewMenuFiles voteFileSelect(SqlSessionTemplate sqlSession, int fNum) {
		return sqlSession.selectOne("newMenuMapper.voteFileSelect", fNum);
	}

	public ArrayList<NewMenuBoard> selectMainVoteList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("newMenuMapper.selectMainVoteList");
	}

	public int updateNmFilesContent(SqlSessionTemplate sqlSession, NewMenuFiles fi) {
		return sqlSession.update("newMenuMapper.updateNmFilesContent", fi);
	}
	
	
	
	public String BoardvoteStatus(SqlSessionTemplate sqlSession, int nNum) {
	      return sqlSession.selectOne("newMenuMapper.boardVoteStatus", nNum);
	   }

	


	
	

}
