package com.community.positions;

import java.util.List;

import com.community.util.SqlMapper;

public class PositionDao {

	private static PositionDao instance = new PositionDao();
	private PositionDao() {}
	public static PositionDao getInstance() {
		return instance;
	}
	
	@SuppressWarnings("unchecked")
	public List<Position> getAllPositions() {
		return (List<Position>) SqlMapper.selectList("positions.getAllPositions");
	}
	
	public Position getPositionByNo(int positionNo) {
		return (Position) SqlMapper.selectOne("positions.getPositionByNo", positionNo);
	}
	
	public void insertPosition(Position position) {
		SqlMapper.insert("positions.insertPosition", position);
	}
	
	public void updatePositionSeq(int positionSeq) {
		SqlMapper.update("positions.updatePositionSeq", positionSeq);
	}
	
	public void updatePosition(Position position) {
		SqlMapper.update("positions.updatePosition", position);
	}
}
