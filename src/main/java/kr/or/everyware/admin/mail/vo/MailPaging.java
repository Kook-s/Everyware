package kr.or.everyware.admin.mail.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

public class MailPaging<T> {
	  private int totalRecord;		// 총 게시글 수
	  private int totalPage;		// 총 페이지 수
	  private int currentPage;		// 현재 페이지
	  private int screenSize=10;		// 페이지당 게시글 수
	  private int blockSize=5;		// 페이지 블록 수
	  private int startRow;			// 시작 row
	  private int endRow;			// 끝 row
	  private int startPage;		// 시작 페이지
	  private int endPage;			// 끝 페이지
	  private List<T> dataList;		// 결과를 넣을 데이터 리스트
	  private String searchType ;	// 검색 타입(제목, 내용, 작성자, 작성일 등등)
	  private String searchWord ;	// 검색 단어(키워드)

	  private String custId;
	  private int deptId;
	  private int jbgdId;
	  private String name;
	  private String title;
	  private String sdate;
	  private String edate;
	  private String isRemove;
	  private String isTrash;
	  private String isLately;
	  
	  
	  
	

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getIsLately() {
		return isLately;
	}

	public void setIsLately(String isLately) {
		this.isLately = isLately;
	}



	public MailPaging() {
		  
	  }
	  
	  //paginationinfoVO객체를 만들 때, 한 페이지당 게시글 수와 페이지 블록 수를
	  //원하는 값으로 초기화 할 수 있도록 Custom 생성자 생성
	  public MailPaging(int screenSize, int blockSize) {
		  super();
		  this.screenSize=screenSize;
		  this.blockSize=blockSize;
	  }

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		//총 페이지 수 구하기
		//ceil 올림
		totalPage = (int)Math.ceil(totalRecord/(double)screenSize);
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;		// 현재 페이지
		endRow =currentPage*screenSize;		// 끝row = 현재페이지*한 페이지당 게시글 수
		startRow = endRow - (screenSize-1);	// 시작row = 끝row-(한 페이지당 게시글 수-1)
		// 마지막 페이지 =(현재페이지+(페이지 블록사이즈-1))/페이지 블록사이즈* 페이지 블록사이즈
		endPage = (currentPage + (blockSize-1))/blockSize*blockSize;
		startPage = endPage-(blockSize-1); 	//시작페이지 = 마지막페이지-(페이지 블록사이즈-1)
	}

	public int getScreenSize() {
		return screenSize;
	}

	public void setScreenSize(int screenSize) {
		this.screenSize = screenSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public List<T> getDataList() {
		return dataList;
	}

	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	
	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		
		//부트 스트랩을 이용하던 여러 css요소를 이용해서 페이징 ui를 구현하는 곳 입니다.
		html.append("<ul class='pagination pagination-sm m-0 float-right'>");
		if(startPage>1) {
			html.append("<li class = 'page-item'><a href='' class='page-link' data-page='"
		               +(startPage - blockSize)+"'>Prev</a></li>");
		}
		
		for(int i=startPage; i<=(endPage<totalPage ? endPage:totalPage); i++) {
			if(i==currentPage) {
				html.append("<li class='page-item active'><span class='page-link'>"
						+i+"</span></li>");
			}else {
				html.append("<li class='page-item'><a href='' class='page-link' data-page='"
						+i+"'>"+i+"</a><li>");
			}
		}
		
		if(endPage<totalPage) {
			html.append("<li class='page-item'><a href='' class='page-link' data-page='"
					+(endPage+1)+"'>Next</a></li>");
		}
		html.append("</ul>");
		return html.toString();
	}

	public int getDeptId() {
		return deptId;
	}

	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}

	public int getJbgdId() {
		return jbgdId;
	}

	public void setJbgdId(int jbgdId) {
		this.jbgdId = jbgdId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}



	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getEdate() {
		return edate;
	}

	@Override
	public String toString() {
		return "MailPaging [totalRecord=" + totalRecord + ", totalPage=" + totalPage + ", currentPage=" + currentPage
				+ ", screenSize=" + screenSize + ", blockSize=" + blockSize + ", startRow=" + startRow + ", endRow="
				+ endRow + ", startPage=" + startPage + ", endPage=" + endPage + ", dataList=" + dataList
				+ ", searchType=" + searchType + ", searchWord=" + searchWord + ", custId=" + custId + ", deptId="
				+ deptId + ", jbgdId=" + jbgdId + ", name=" + name + ", title=" + title + ", sdate=" + sdate
				+ ", edate=" + edate + ", isRemove=" + isRemove + ", isTrash=" + isTrash + ", isLately=" + isLately
				+ "]";
	}

	public void setEdate(String edate) {
		this.edate = edate;
	}

	public String getIsRemove() {
		return isRemove;
	}

	public void setIsRemove(String isRemove) {
		this.isRemove = isRemove;
	}

	public String getIsTrash() {
		return isTrash;
	}

	public void setIsTrash(String isTrash) {
		this.isTrash = isTrash;
	}


}

