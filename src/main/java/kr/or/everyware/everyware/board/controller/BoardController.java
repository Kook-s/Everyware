package kr.or.everyware.everyware.board.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.board.service.BoardService;
import kr.or.everyware.everyware.board.vo.Board;
import kr.or.everyware.everyware.board.vo.BoardPaginationInfo;
import kr.or.everyware.everyware.cmnt.service.CmntService;
import kr.or.everyware.everyware.cmnt.vo.Cmnt;
import kr.or.everyware.everyware.cmnt.vo.CmntPaginationInfo;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;
import kr.or.everyware.util.fileUtils.MediaUtils;
import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasAuthority('BOARD')")
@Slf4j
@Controller
@RequestMapping("/everyware")
public class BoardController {

	@Inject
	private BoardService service;

	@Inject
	private CmntService Cservice;

	// 게시글 등록
	@GetMapping(value = "/boardInsert")
	public String boardInsertForm(Model model, String ctgryNo) {
		// 내 아이디
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 내아디 다시담아
		String empId = user.getUsername();
		
		model.addAttribute("boardActive","active");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		model.addAttribute("emp", employee);


		Board board = new Board();
		board.setEmpId(empId);
		board.setCtgryNo(ctgryNo);
		model.addAttribute("board", board);

		return "everyware/board/boardInsert";
	}

	@PostMapping(value = "/boardInsert")
	public String handleBoardInsert(Board board, Model model) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		
		model.addAttribute("boardActive","active");
		

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		model.addAttribute("emp", employee);
		
		AttachFile tmp = new AttachFile();
		tmp.setAtchFileNo(board.getAtchFileNo());
		AttachFile atch = service.getAttachFile(tmp);
		model.addAttribute("atch",atch);
		
		
		board.setEmpId(empId);
		MultipartFile picturs = board.getFile();
		log.info(picturs.getOriginalFilename());
		log.info("@@@@@@@@@@@@@ "+board);
		ServiceResult res =null;
		service.addBoard(board);
		log.info("@@@@@@@@@  "+board);
		

		return "redirect:/everyware/boardDetail?pstId="+board.getPstId();
	}
//-------------------------------------------------------------------------------------------	

	// 상세보기
	@GetMapping(value = "/boardDetail")
	public String boardDetail(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,int pstId, Model model) {
		
		model.addAttribute("boardActive","active");
		
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		model.addAttribute("emp", employee);
		
		
		// 내 아이디
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 내아디 다시담아
		String empId = user.getUsername();
		
		
		Cmnt cmnt = new Cmnt();
		Board board = service.detail(pstId);
		
		AttachFile tmp = new AttachFile();
		tmp.setAtchFileNo(board.getAtchFileNo());
		AttachFile atch = service.getAttachFile(tmp);
		model.addAttribute("atch",atch);
		model.addAttribute("board", board);
		
		model.addAttribute("emp", employee);
		
		employee.getEmpProfile();
		
		CmntPaginationInfo<Cmnt> CpagingVO = new CmntPaginationInfo<Cmnt>();
		CpagingVO.setPstId(pstId);

		CpagingVO.setCurrentPage(currentPage); // startRow, endRow, startPage, endPage 가 결정
		int totalRecode = Cservice.selectCmntCount(CpagingVO);
		CpagingVO.setTotalRecord(totalRecode);
		CpagingVO.setEmpId(empId);
		CpagingVO.setPstId(pstId);
		List<Cmnt> dataList = Cservice.selectCmntList(CpagingVO);
		CpagingVO.setDataList(dataList);
		model.addAttribute("CpagingVO", CpagingVO);
		model.addAttribute(empId);
		return "everyware/board/boardDetail";

	}


//-------------------------------------------------------------------------------------------	

	// 게시글 삭제
	@PostMapping(value = "/boardDelete")
	@ResponseBody
	public ResponseEntity<ServiceResult> boardDelete(@RequestBody List<Integer> data, Model model) {
		System.out.println(data);
		model.addAttribute("boardActive","active");
		int cnt = 0;
		for (int i = 0; i < data.size(); i++) {
			cnt += service.delete(data.get(i));
		}
		ServiceResult result = null;

		if (cnt == data.size()) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		model.addAttribute("msg", "삭제가완료되었습니다");
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);

	}

//-------------------------------------------------------------------------------------------	

//	카테고리 게시판 선택 및 리스트
	@RequestMapping(value = "/boardList")
	public String showBoard(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, @RequestParam("category") String ctgryNo,
			String filePath, String fileSavedNm, String fileNm,

			HttpSession session, Model model) {

		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		model.addAttribute("emp", employee);
		model.addAttribute("boardActive","active");
		
		List<Employee> empList = service.getEmpList();
		model.addAttribute("empList", empList);
		

		
		BoardPaginationInfo<Board> pagingVO = new BoardPaginationInfo<Board>();
		pagingVO.setCtgryNo(ctgryNo);
		if (StringUtils.isNotBlank(searchWord)) { // 검색함
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
			AttachFile file = new AttachFile();

		}

		pagingVO.setCurrentPage(currentPage); // startRow, endRow, startPage, endPage 가 결정
		int totalRecode = service.selectBoardCount(pagingVO); // 총 게시글 수
		pagingVO.setTotalRecord(totalRecode);

		List<Board> dataList = service.selectBoardList(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("ctgryNo", ctgryNo);
		if (ctgryNo.equals("1")) {
			model.addAttribute("notice_board","active");
			return "everyware/board/notice_board";
		} else if (ctgryNo.equals("2")) {
			model.addAttribute("free_board","active");
			return "everyware/board/free_board";
		} else if (ctgryNo.equals("3")) {
			model.addAttribute("file_board","active");
			return "everyware/board/file_board";
		}
		model.addAttribute("notice_board","active");
		return "everyware/board/file_board";
	}
//-------------------------------------------------------------------------------------------	

	// 검색 기능
	@PostMapping(value = "/boardSearch")
	public String crudSearch(String ctgryNo, String pstTtl, Model model) {
		Board board = new Board();
		board.getPstTtl();
		board.setCtgryNo(ctgryNo);
		
		model.addAttribute("boardActive","active");

		List<Board> boardList = service.search(board);
		model.addAttribute("board", board);
		model.addAttribute("ctgryNo:", ctgryNo);
		model.addAttribute("boardList", boardList);

		return "everyware/board/file_board";
	}

//------------------------------------------------------------------------------------------

	// 수정

	@GetMapping(value = "/boardUpdate/{pstId}/{ctgryNo}")
	public String boardUpdateForm(@PathVariable int pstId, @PathVariable String ctgryNo, Model model) {
		Board board = service.selectBoard(pstId);
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		
		model.addAttribute("boardActive","active");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee(); 
		model.addAttribute("emp", employee);
		
		
		board.setEmpId(empId);
		board.setCtgryNo(ctgryNo);
		model.addAttribute("board", board);
		return "everyware/board/boardUpdate";
	}

	@PostMapping(value = "/boardUpdate")
	@ResponseBody
	public String boardUpdate(Board board, Model model, HttpServletResponse response) throws Exception {
		model.addAttribute("boardActive","active");
		String goPage = "";
		int rslt = service.updateBoard(board);
		if (rslt > 0) {
			response.sendRedirect("/everyware/boardDetail?pstId=" + board.getPstId());
		} else {
			model.addAttribute("message", "수정실패");
			model.addAttribute("board", board);
			goPage = "/everyware/board/boardDetail";
		}
		return goPage;
	}
//-----------------------------------------------------------------------
	// 댓글 작성
	
	  @GetMapping(value="/cmntInsert")
	  public String cmntInsertForm(Cmnt cmnt,Model model) {
	  log.info("cmntInsertForm실행"); 
	  User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
	  String empId = user.getUsername();
	  
	  model.addAttribute("boardActive","active");
	  
	 model.addAttribute("cmnt",cmnt);
	 
	  return "everyware/board/boardDetail";
	  
	  }
	 
	@PostMapping(value="/cmntInsert")
	public String cmntInsert(Cmnt cmnt, Model model) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		cmnt.setEmpId(empId);
		Cservice.cmntInsert(cmnt);
		
		model.addAttribute("boardActive","active");
		
		return "redirect:/everyware/boardDetail?pstId="+cmnt.getPstId();
	}
	
//-----------------------------------------------------------------------
	// 댓글 수정
	
	@PostMapping(value="/cmntUpdate")
	public String cmntUpdate(Cmnt cmnt, Model model) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee(); 
		model.addAttribute("emp", employee);
		
		model.addAttribute("boardActive","active");
		
		cmnt.setEmpId(empId);
		Cservice.cmntInsert(cmnt);
		
		return "redirect:/everyware/boardDetail?pstId="+cmnt.getPstId();
	}
	
	//-----------------------------------------------------------------------
		// 댓글 삭제
		
		@GetMapping(value="/cmntDelete")
		public String cmntDelete(Cmnt cmnt, Model model) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String empId = user.getUsername();
			cmnt.setEmpId(empId);
			Cservice.cmntDelete(cmnt.getCmntId());
			
			model.addAttribute("boardActive","active");
		
			return "redirect:/everyware/boardDetail?pstId="+cmnt.getPstId();
		}
		
//-------------------------------------------------------------------------------------------------		
		// 파일 다운로드
		@PreAuthorize("hasAuthority('BOARD')")
		@GetMapping(value = "/board/filedownload")
		public ResponseEntity<byte[]> getFile(AttachFile attachFile, Model model){
			model.addAttribute("boardActive","active");
			InputStream is=null;
			ResponseEntity<byte[]> entity = null;
			try {
				AttachFile fileInfo = service.getAttachFile(attachFile);
				String fileName = fileInfo.getFileSavedNm();
				String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
				MediaType mType = MediaUtils.getMeMediaType(formatName);
				HttpHeaders headers = new HttpHeaders();
				is = new FileInputStream(fileInfo.getFilePath()+fileName);
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; fileName=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is),headers,HttpStatus.CREATED);
			} catch (IOException e) {
				e.printStackTrace();
			}finally{
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			return entity;
		}
		
		
}

