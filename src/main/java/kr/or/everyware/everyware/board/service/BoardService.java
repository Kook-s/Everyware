package kr.or.everyware.everyware.board.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.board.vo.Board;
import kr.or.everyware.everyware.board.vo.BoardPaginationInfo;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;

public interface BoardService {

	public List<Board> list();

	public Board detail(int pstId);

	public int delete(int pstId);

	public void insert(Board board);

	public List<Board> boardCategory(String ctgryNo);

	public List<Board> search(Board board);

	public int selectBoardCount(BoardPaginationInfo<Board> pagingVO);

	List<Board> selectBoardList(BoardPaginationInfo<Board> pagingVO);

	public Board selectBoard(int pstId);

	public int updateBoard(Board board);

	public ServiceResult addBoard(Board board);

	public AttachFile getAttachFile(AttachFile attachFile);

	public List<Employee> getEmpList();


}
