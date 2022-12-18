package com.community.boards;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;

public class BoardDao {

	private static BoardDao instance = new BoardDao();
	private BoardDao() {}
	public static BoardDao getInstance() {
		return instance;
	}
	
	@SuppressWarnings("unchecked")
	public List<Board> getBoards(Map<String, Object> param) {
		return (List<Board>) SqlMapper.selectList("boards.getBoards", param);
	}
	
	public Board getBoardByNo(int boardNo) {
		return (Board) SqlMapper.selectOne("boards.getBoardByNo", boardNo);
	}
	
	public void insertBoard(Board board) {
		SqlMapper.insert("boards.insertBoard", board);
	}
	
	public void updateBoard(Board board) {
		SqlMapper.update("boards.updateBoard", board);
	}
	public void updateBoardSeq(int parentBoardNo) {
		SqlMapper.update("boards.updateBoardSeq", parentBoardNo);
	}
}
