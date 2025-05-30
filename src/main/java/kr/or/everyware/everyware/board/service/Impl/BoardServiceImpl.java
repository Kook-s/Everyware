package kr.or.everyware.everyware.board.service.Impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.board.mapper.BoardMapper;
import kr.or.everyware.everyware.board.service.BoardService;
import kr.or.everyware.everyware.board.vo.Board;
import kr.or.everyware.everyware.board.vo.BoardPaginationInfo;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.AttachFileValidate;
import kr.or.everyware.util.attachment.vo.AttachFile;
import kr.or.everyware.util.fileUtils.UploadFileUtils;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardMapper mapper;
	
	@Resource(name = "uploadPath")
	private String resourcePath;
	
	@Inject
	AttachFileValidate attachService;

	@Override
	public List<Board> list() {
		return mapper.list();
	}

	@Override
	public Board detail(int pstId) {
		mapper.boardhit(pstId);
		return mapper.detail(pstId);
	}

	@Override
	public int delete(int pstId) {
		return mapper.delete(pstId);
	}

	@Override
	public void insert(Board board) {
		mapper.insert(board);
	}

	@Override
	public List<Board> boardCategory(String ctgryNo) {
		return mapper.boardCategory(ctgryNo);
	}

	@Override
	public List<Board> search(Board board) {
		return mapper.search(board);
	}

	@Override
	public int selectBoardCount(BoardPaginationInfo<Board> pagingVO) {
		return mapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<Board> selectBoardList(BoardPaginationInfo<Board> pagingVO) {
		return mapper.selectBoardList(pagingVO);

	}

	@Override
	public int updateBoard(Board board) {
		return mapper.updateBoard(board);
	}

	@Override
	public Board selectBoard(@Param("pstId")int pstId) {
		return mapper.selectBoard(pstId);
	}

	@Override
	public ServiceResult addBoard(Board board) {
		ServiceResult res = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		if(board.getFile()!=null) {
			List<MultipartFile> list = new ArrayList<MultipartFile>();
			list.add(board.getFile());
			if (ServiceResult.FAILED.equals(attachService.validate(employee.getCustId(), list))) {
				return ServiceResult.NOTEXIST;
			}
		}
		MultipartFile file = board.getFile();
		String realSavedName=null;
		try {
			realSavedName = UploadFileUtils.uploadFile(resourcePath, file.getOriginalFilename(), file.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		AttachFile attachFile = new AttachFile();
		attachFile.setAtchFileSeq(1);
		attachFile.setBizType(8);
		attachFile.setFileNm(file.getOriginalFilename());
		attachFile.setFileSz(file.getSize());
		attachFile.setCustId(employee.getCustId());
		attachFile.setFilePath(resourcePath);
		attachFile.setFileSavedNm(realSavedName);
		int result = mapper.insertAttach(attachFile);
		
		board.setAtchFileNo(attachFile.getAtchFileNo());
		System.out.println(board);
		result = mapper.insert(board);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public AttachFile getAttachFile(AttachFile attachFile) {
		// TODO Auto-generated method stub
		return mapper.getAttachFile(attachFile);
	}

	@Override
	public List<Employee> getEmpList() {
		// TODO Auto-generated method stub
		return mapper.getEmpList();
	}


	


}
