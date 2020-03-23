package com.dev.erp.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dev.erp.board.model.vo.Board;
import com.dev.erp.board.model.vo.BoardCategory;
import com.dev.erp.board.model.vo.BoardComment;

	@Repository
	public class BoardDAOImpl implements BoardDAO {

		@Autowired
		SqlSessionTemplate sqlSession;
		


		@Override
		public int insertBoardCategory(BoardCategory boardCategory) {
			return sqlSession.insert("board.insertBoardCategory",boardCategory);
		}

		@Override
		public List<Map<String, Object>> selectBoardCategoryList() {
			return sqlSession.selectList("board.selectBoardCategoryList");
		}

		@Override
		public Board seletOneBoard(int boardNo) {
			return sqlSession.selectOne("board.seletOneBoard",boardNo);
		}

		
		@Override
		public BoardCategory boardCategoryView(int categoryNo) {
			return sqlSession.selectOne("board.boardCategoryView",categoryNo);
		}


		@Override
		public List<Map<String,Object>> selectBoardClubList(int boardNo) {
			return sqlSession.selectList("board.selectBoardClubList",boardNo);
		}

		@Override
		public List<Board> selectBoardList() {
			return sqlSession.selectList("board.selectBoardList");
		}

		@Override
		public List<Map<String,Object>> selectBoardAllList() {
			return sqlSession.selectList("board.selectBoardAllList");
		}

		@Override
		public List<Board> selectBoardType() {
			return sqlSession.selectList("board.selectBoardType");
		}

		@Override
		public int boardCommentInsert(BoardComment boardComment) {
			return sqlSession.insert("board.boardCommentInsert",boardComment);
		}

		@Override
		public List<BoardComment> getBoardComment(int categoryNo) {
			return sqlSession.selectList("board.getBoardComment",categoryNo);
		}

		@Override
		public int boardCommentDelete(BoardComment boardComment) {
			return sqlSession.delete("board.boardCommentDelete",boardComment);
		}

		@Override
		public int boardComment2Delete(BoardComment boardComment) {
			return sqlSession.delete("board.boardComment2Delete",boardComment);
		}

		@Override
		public List<BoardCategory> updateBoard(String categoryWriter) {
			return sqlSession.selectList("board.updateBoard",categoryWriter);
		}

		@Override
		public int boardDelete(int categoryNo) {
			return sqlSession.delete("board.boardDelete",categoryNo);
		}

		@Override
		public BoardCategory boardModify(int categoryNo) {
			return sqlSession.selectOne("board.boardModify", categoryNo);
		}

		@Override
		public int boardModifyEnd(BoardCategory boardCategory) {
			return sqlSession.update("board.boardModifyEnd",boardCategory);
		}

}
