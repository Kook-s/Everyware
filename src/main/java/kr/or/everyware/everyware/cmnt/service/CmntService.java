package kr.or.everyware.everyware.cmnt.service;

import java.util.List;

import kr.or.everyware.everyware.cmnt.vo.Cmnt;
import kr.or.everyware.everyware.cmnt.vo.CmntPaginationInfo;

public interface CmntService {

	public void cmntInsert(Cmnt cmnt);

	public List<Cmnt> selectCmntList(CmntPaginationInfo<Cmnt> cpagingVO);

	public int selectCmntCount(CmntPaginationInfo<Cmnt> cpagingVO);

	public void cmntDelete(int cmntId);

}
