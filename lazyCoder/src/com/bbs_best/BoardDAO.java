package com.bbs_best;

import java.sql.SQLException;
import java.util.List;



public interface BoardDAO {
	public int insertBoard(BoardDTO dto) throws SQLException;
	
	public List<BoardDTO> listBoard(int offset, int rows);
	public List<BoardDTO> listBoard();
	
	public int updateHitCount(int num) throws SQLException;
	public int dataCount();
	public int dataCount(String condition , String keyword);
	
	public BoardDTO readBoard(int num) throws SQLException;
}
