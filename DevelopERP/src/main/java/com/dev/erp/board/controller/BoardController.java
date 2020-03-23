package com.dev.erp.board.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.board.model.service.BoardService;
import com.dev.erp.board.model.vo.Board;
import com.dev.erp.board.model.vo.BoardCategory;
import com.dev.erp.board.model.vo.BoardComment;
import com.dev.erp.member.model.vo.Member;

@Controller
public class BoardController {

	static final Logger logger=LoggerFactory.getLogger(BoardController.class);
	@Autowired
	BoardService boardService;
	
	
	@RequestMapping("/board/boardList.do")
	public ModelAndView selectBoardList(ModelAndView mav)
	{
		List<Map<String,Object>> boardCategoryList= new ArrayList<>();
		List<Board> boardList = new ArrayList<>();
		boardCategoryList = boardService.selectBoardCategoryList();	
		boardList = boardService.selectBoardList();
		
		mav.addObject("boardNo",0);
		mav.addObject("boardlist",boardCategoryList);
		mav.addObject("board",boardList);
		mav.setViewName("board/boardList");
		return mav;
	}

	@RequestMapping("/board/boardClubList.do")
	public ModelAndView selectBoardClubList(ModelAndView mav, @RequestParam("boardNo") int boardNo)
	{
		List<Map<String,Object>> boardClubList= new ArrayList<>();
		List<Board> boardList = new ArrayList<>();
		boardClubList = boardService.selectBoardClubList(boardNo);
		boardList = boardService.selectBoardList();
		mav.addObject("boardNo",boardNo);
		mav.addObject("boardlist",boardClubList);
		mav.addObject("board",boardList);
		mav.setViewName("board/boardList");
		
		return mav;
	}

	@RequestMapping("/board/insertBoardForm.do")
	public ModelAndView insertBoardForm(ModelAndView mav) {
		List<Board> board = new ArrayList<>();
		board = boardService.selectBoardType();
		mav.addObject("board",board);
		mav.setViewName("/board/insertBoardForm");
		return mav;
	}
	
	@RequestMapping("/board/enrollBoard.do")
	public ModelAndView InsertBoard(ModelAndView mav, 
												@RequestParam("categoryDate") Date categoryDate,
												@RequestParam("boardType") int boardType,
												@RequestParam("categoryTitle") String categoryTitle,
												@RequestParam("categoryComment") String categoryComment,
												@RequestParam("categoryWriter") String categoryWriter)
												{	
		BoardCategory boardCategory = new BoardCategory(0,boardType,categoryComment, categoryWriter,categoryTitle,"y",categoryDate);
		System.out.println("Dfffffffffffff"+boardCategory);
		int result = boardService.insertBoardCategory(boardCategory);
		logger.debug("category={}",categoryDate);
		mav.addObject("msg",result>0?"등록성공":"등록실패");
		mav.addObject("loc","/board/boardList.do");
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("/board/boardDetailView.do")
	public ModelAndView documentDetailView(ModelAndView mav, @RequestParam("categoryNo") int categoryNo,@SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn) {	
		String name = Optional.ofNullable(memberLoggedIn).map(Member::getEmpName)
				 .orElseThrow(IllegalStateException::new);
		System.out.println("dssssssssssss"+name);
		Board board = new Board();
		BoardCategory boardCategory = new BoardCategory();
		boardCategory = boardService.boardCategoryView(categoryNo);
		List<BoardComment> boardComment =boardService.getBoardComment(categoryNo);
		logger.debug("boardCategory={}",boardCategory);
		System.out.println("fdsafdsaasa"+boardComment);
		mav.addObject("boardComment",boardComment);
		mav.addObject("list",board);
		mav.addObject("name",name);
		mav.addObject("categorylist",boardCategory);
		mav.setViewName("board/boardDetailView");
		
		return mav;
	}
	@RequestMapping("/board/boardAllList.do")
	@ResponseBody
	public Map<String,Object> boardAllList(){
		List<Map<String,Object>> boardCategoryList = new ArrayList<>();
		boardCategoryList = boardService.selectBoardAllList();
		Map<String,Object> map = new HashMap<>();
		logger.debug("boardCategoryList={}",boardCategoryList);
		map.put("list", boardCategoryList);
		return map;
		
	}
	@RequestMapping("/board/boardCommentInsert.do")
	public ModelAndView boardCommentInsert(ModelAndView mav,BoardComment boardComment) {
		int result=boardService.boardCommentInsert(boardComment);
		mav.addObject("msg",result>0?"댓글 등록 성공":"댓글 등록 실패");
		mav.addObject("loc","/board/boardList2.do?categoryNo="+boardComment.getBoardRef());
		mav.setViewName("common/msg");
		return mav;
	}

	@RequestMapping("/board/boardCommentDelete.do")
	public ModelAndView boardCommentDelete(ModelAndView mav,BoardComment boardComment) {
		System.out.println("fdfdfdddd"+boardComment);
		int result=boardService.boardComment2Delete(boardComment);
		 result=boardService.boardCommentDelete(boardComment);
		mav.addObject("msg",result>0?"댓글 삭제 성공":"댓글 삭제 실패");
		mav.addObject("loc","/board/boardList2.do?categoryNo="+boardComment.getBoardRef());
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("/board/boardList2.do")
	public ModelAndView selectBoardList2(ModelAndView mav,@RequestParam("categoryNo") int categoryNo)
	{
		List<Map<String,Object>> boardCategoryList= new ArrayList<>();
		List<Board> boardList = new ArrayList<>();
		boardCategoryList = boardService.selectBoardCategoryList();	
		boardList = boardService.selectBoardList();
		
		mav.addObject("categoryNo",categoryNo);
		mav.addObject("boardlist",boardCategoryList);
		mav.addObject("board",boardList);
		mav.setViewName("board/boardList2");
		return mav;
	}
	@RequestMapping("board/UpdateBoardForm.do")
	public ModelAndView UpdateBoard(ModelAndView mav,@RequestParam("categoryWriter") String categoryWriter) {
		System.out.println("FDFDF"+categoryWriter);
		List<BoardCategory> list=boardService.updateBoard(categoryWriter);
		System.out.println("fdfdfd"+list);
		
		mav.addObject("list",list);
		mav.setViewName("board/boardUpdateForm");
		return mav;
	}
	@RequestMapping("board/boardDelete.do")
	public ModelAndView boardDelete(ModelAndView mav,@RequestParam("categoryNo") int categoryNo) {
		System.out.println("FDFDF"+categoryNo);
		int result=boardService.boardDelete(categoryNo);
		
	
		mav.addObject("msg",result>0?"게시물 삭제 성공":"게시물 삭제 실패");
		mav.addObject("loc","/board/boardList.do");
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("board/boardModifyEnd.do")
	public ModelAndView boardModifyEnd(ModelAndView mav,BoardCategory boardCategory) {
		
		int result=boardService.boardModifyEnd(boardCategory);
		mav.addObject("msg",result>0?"게시물 수정 성공":"게시물 수정 실패");
		mav.addObject("loc","/board/boardList.do");
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("board/boardModify.do")
	public ModelAndView boardModify(ModelAndView mav,@RequestParam("categoryNo") int categoryNo) {
		System.out.println("FDFDF"+categoryNo);
		BoardCategory boardCategory=boardService.boardModify(categoryNo);
		List<Board> board = new ArrayList<>();
		board = boardService.selectBoardType();
		mav.addObject("board",board);
		mav.addObject("boardCategory",boardCategory);
		mav.setViewName("board/boardModifyForm");
		return mav;
	}
}
