package com.kh.dalboo.board.model.service;

import java.util.ArrayList;

import com.kh.dalboo.board.model.vo.NewMenuBoard;
import com.kh.dalboo.board.model.vo.NewMenuFiles;
import com.kh.dalboo.board.model.vo.Vote;
import com.kh.dalboo.common.PageInfo;

public interface NewMenuService {

	int insertNfile(NewMenuFiles fi);

	int insertNmboard(NewMenuBoard b);

	int getListCount();

	ArrayList<NewMenuBoard> selectList(PageInfo pi);

	NewMenuBoard selectBoard(int nNum);

	ArrayList<NewMenuFiles> selectFile(int nNum);

	int deleteNewMenuBoard(int nNum);

	int updateNmboard(NewMenuBoard b);

	int updateNfile(NewMenuFiles f);


	int voteCount(Vote v);

	int voteStatus(Vote v);

	int voteMenuDelete(int fNum);

	int addinsertNfile(NewMenuFiles f);

	int rollbackUpdate(int nNum);

	int voteStatusEnd(int nNum);

	Vote voteTotalCount(int nNum);

	NewMenuFiles voteFileSelect(int fNum);

	ArrayList<NewMenuBoard> selectMainVoteList();

	int updateNmFilesContent(NewMenuFiles fi);

	String BoardvoteStatus(int nNum);


}
