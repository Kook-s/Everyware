package kr.or.everyware.everyware.board.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.board.vo.Board;
import kr.or.everyware.everyware.board.vo.BoardPaginationInfo;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;

@Mapper

public interface BoardMapper {

	public List<Board> list();

	public int insert(Board board);

	public Board detail(int pstId);

	public int delete(int pstId);

	public List<Board> boardCategory(String ctgryNo);

	public List<Board> search(Board board);

	public int boardhit(int pstId);

	public int selectBoardCount(BoardPaginationInfo<Board> pagingVO);

	public List<Board> selectBoardList(BoardPaginationInfo<Board> pagingVO);

	public Board selectBoard(int pstId);

	public int updateBoard(Board board);


	public int insertAttach(AttachFile attachFile);

	public AttachFile getAttachFile(AttachFile attachFile);

	public List<Employee> getEmpList();


}
