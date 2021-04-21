package com.kh.dalboo.board.model.service;

import java.util.ArrayList;


import com.kh.dalboo.board.model.vo.Board;
import com.kh.dalboo.board.model.vo.Reply;
import com.kh.dalboo.common.PageInfo;

public interface BoardService {
	
//	ㅡㅡㅡㅡㅡㅡㅡㅡ이벤트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	int getListCount();

	ArrayList<Board> selectList(PageInfo pi);

	int insertBoard(Board b);

	Board selectBoard(int bNum);

	int updateBoard(Board b);

	int boardDelete(int bNum);

	
//	ㅡㅡㅡㅡㅡㅡㅡㅡ공지사항ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	int getListCount2();

	ArrayList<Board> selectList2(PageInfo pi);

	int insertBoard2(Board b);

	Board selectBoard2(int bNum);

	int updateBoard2(Board b);

	int boardDelete2(int bNum);
	
//	ㅡㅡㅡㅡㅡㅡㅡㅡ고객센터ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	int getListCount3();

	ArrayList<Board> selectList3(PageInfo pi);
	
	int insertBoard3(Board b);

	Board selectBoard3(int bNum);

	int updateBoard3(Board b);

	int boardDelete3(int bNum);
	
//  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ댓글(답변)등록 ㅡㅡㅡㅡㅡㅡㅡㅡㅡ
  ArrayList<Reply> selectReplyList(int bNum);
  
  int insertReply(Reply r);

  int deleteReply(Reply r);
	
	
}
