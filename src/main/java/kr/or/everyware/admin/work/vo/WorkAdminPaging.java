package kr.or.everyware.admin.work.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WorkAdminPaging<T> {
	private int totalRecord; 	// 총 게시글 수
	private int totalPage; 		// 총 페이지 수
	private int currentPage; 	// 현재 페이지
	private int screenSize = 10;// 페이지 당 게시글 수
	private int blockSize = 10; // 페이지 블록 수
	private int startRow; 		// 시작 row
	private int endRow; 		// 끝 row
	private int startPage; 		// 시작 페이지
	private int endPage; 		// 끝 페이지
	private List<T> dataList; 	// 결과를 넣을 데이터 리스트
	
	private String empId;		// 사원번호
	private String custId;		// 고객사Id
	private int page;
	
	// 검색
	private String searchStartDate;	// 검색 시작날짜 
	private String searchEndDate;	// 검색 끝날짜
	private String searchState; 	// 검색 상태
	private List<String> idList;			//주소록으로 선택된 대상자들 아이디리스트
	
	// 근태현황
	private int totalWork;		// 전체건수
	private int totalNormal;	// 정상건수
	private int totalExtension;	// 연장건수 
	private int totalLateness;	// 지각건수
	private int totalLeaveEarly;// 조퇴건수
	private int totalVacation;	// 휴가건수
	
	public WorkAdminPaging() {}
	
	// PaginationInfoVO 객체를 만들 때, 한 페이지당 게시글 수와 페이지 블록 수를 
	// 원하는 값으로 초기화 할 수 있도록 Custom 생성자 생성
	public WorkAdminPaging(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		// 총 페이지 수 구하기
		// ceil 올림
		totalPage = (int)Math.ceil(totalRecord / (double)screenSize); 
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;				// 현재 페이지
		endRow = currentPage * screenSize;	// 끝 row = 현재 페이지 * 한 페이지당 게시글 수
		startRow = endRow - (screenSize - 1);	// 시작 row = 끝  row -(한페이지당 게시글 수 -1)
		// 마지막 페이지 = (현재 페이지 + (페이지 블록 사이즈 -1)) / 페이지 블록 사이즈 * 페이지 블록 사이즈
		endPage = (currentPage + (blockSize - 1)) / blockSize * blockSize;
		startPage = endPage - (blockSize - 1);		// 시작 페이지 = 마지막 페이지 - (페이지 블록 사이즈 -1)
	}

	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		
		// 부트스트랩을 이용하던 여러 css요소를 이용해서 페이징 UI를 구현하는 곳입니다!
		html.append("<ul class='pagination pagination-sm m-0 float-right'>");
		
		if(startPage > 1) {
			html.append(
					"<li class='page-item'>"
					+ "<a href='' class='page-link' data-page='" + (startPage - blockSize) + "'><<</a>"
					+ "</li>");
		}
		
		for(int i = startPage; i <= (endPage < totalPage ? endPage : totalPage); i++) {
			if(i == currentPage) {
				html.append(
						"<li class='page-item active'>"
						+ "<span class='page-link'>" + i + "</span>"
						+ "</li>");
			} else {
				html.append(
						"<li class='page-item'>"
						+ "<a href='' class='page-link' data-page='" + i + "'>" + i + "</a>"
						+ "</li>");
			}
		}
		
		if(endPage < totalPage) {
			html.append(
					"<li class='page-item'>"
					+ "<a href='' class='page-link' data-page='" + (endPage + 1) + "'>>>" + "</a>"
					+ "</li>");
		}
		html.append("</ul>");
		return html.toString();
	}
}
