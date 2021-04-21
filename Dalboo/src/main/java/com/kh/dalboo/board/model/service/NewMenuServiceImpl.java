package com.kh.dalboo.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dalboo.board.model.dao.NewMenuDAO;
import com.kh.dalboo.board.model.vo.NewMenuBoard;
import com.kh.dalboo.board.model.vo.NewMenuFiles;
import com.kh.dalboo.board.model.vo.Vote;
import com.kh.dalboo.common.PageInfo;

@Service("nmService")
public class NewMenuServiceImpl  implements NewMenuService {
	
	@Autowired
	private NewMenuDAO nmDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	

	@Override
	public int insertNmboard(NewMenuBoard b) {
		return nmDAO.insertNmboard(sqlSession, b);
	}



	@Override
	public int insertNfile(NewMenuFiles fi) {
		return nmDAO.insertNfile(sqlSession, fi);
	}



	@Override
	public int getListCount() {
		return nmDAO.getListCount(sqlSession);
	}



	@Override
	public ArrayList<NewMenuBoard> selectList(PageInfo pi) {
		return nmDAO.selectList(sqlSession, pi);
	}



	@Override
	public NewMenuBoard selectBoard(int nNum) {
		int result = nmDAO.addReadCount(sqlSession, nNum);
		NewMenuBoard b = null;
		if(result > 0) {
			b = nmDAO.selectBoard(sqlSession, nNum);
		}
		return b;
	}



	@Override
	public ArrayList<NewMenuFiles> selectFile(int nNum) {
		ArrayList<NewMenuFiles> f = null;
		f = nmDAO.selectFile(sqlSession, nNum);
		return f;
	}



	@Override
	public int deleteNewMenuBoard(int nNum) {
		return nmDAO.deleteNewMenuBoard(sqlSession, nNum);
		
	}



	@Override
	public int updateNmboard(NewMenuBoard b) {
		// TODO Auto-generated method stub
		return nmDAO.updateNmboard(sqlSession, b);
	}



	@Override
	public int updateNfile(NewMenuFiles f) {
		
		return nmDAO.updateNfile(sqlSession, f);
	}


	@Override
	public int voteCount(Vote v) {
		int result = nmDAO.MemberVoteStatus(sqlSession, v);
		int result2 = 0;
		if(result > 0) {
			result2 = nmDAO.addVoteCount(sqlSession, v);
		}
		return result2;		
	}



	@Override
	public int voteStatus(Vote v) {
		// TODO Auto-generated method stub
		return nmDAO.voteStatusChk(sqlSession, v);
	}



	@Override
	public int voteMenuDelete(int fNum) {
		return nmDAO.voteMenuDelete(sqlSession, fNum);
	}



	@Override
	public int addinsertNfile(NewMenuFiles f) {
		return nmDAO.addinsertNfile(sqlSession, f);
	}



	@Override
	public int rollbackUpdate(int nNum) {
		return nmDAO.rollbackUpdate(sqlSession, nNum);
	}



	@Override
	public int voteStatusEnd(int nNum) {
		return nmDAO.voteStatusEnd(sqlSession, nNum);
	}



	@Override
	public Vote voteTotalCount(int nNum) {
		return nmDAO.voteTotalCount(sqlSession, nNum);
	}



	@Override
	public NewMenuFiles voteFileSelect(int fNum) {
		return nmDAO.voteFileSelect(sqlSession, fNum);
	}



	@Override
	public ArrayList<NewMenuBoard> selectMainVoteList() {
		return nmDAO.selectMainVoteList(sqlSession);
	}



	@Override
	public int updateNmFilesContent(NewMenuFiles fi) {
		return nmDAO.updateNmFilesContent(sqlSession, fi);
	}





	
	
	
	@Override
	   public String BoardvoteStatus(int nNum) {
	      return nmDAO.BoardvoteStatus(sqlSession, nNum);
	   }


	
	

	

}
