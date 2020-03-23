package com.dev.erp.board.model.dao;

import java.util.List;
import java.util.Map;

import com.dev.erp.board.model.vo.Board;
import com.dev.erp.board.model.vo.BoardCategory;
import com.dev.erp.board.model.vo.BoardComment;

public interface BoardDAO {

	
	int insertBoardCategory(BoardCategory boardCategory);

	List<Map<String, Object>> selectBoardCategoryList();

	Board seletOneBoard(int boardNo);



	BoardCategory boardCategoryView(int categoryNo);

	List<Map<String,Object>> selectBoardClubList(int boardNo);

	List<Board> selectBoardList();

	List<Map<String,Object>> selectBoardAllList();

	List<Board> selectBoardType();

	int boardCommentInsert(BoardComment boardComment);

	List<BoardComment> getBoardComment(int categoryNo);

	int boardCommentDelete(BoardComment boardComment);

	int boardComment2Delete(BoardComment boardComment);

	List<BoardCategory> updateBoard(String categoryWriter);

	int boardDelete(int categoryNo);

	BoardCategory boardModify(int categoryNo);

	int boardModifyEnd(BoardCategory boardCategory);


	



	

	
}
