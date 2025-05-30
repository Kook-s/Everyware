package kr.or.everyware.everyware.cmnt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.cmnt.vo.Cmnt;
import kr.or.everyware.everyware.cmnt.vo.CmntPaginationInfo;

@Mapper
public interface CmntMapper {


	public void cmntInsert(Cmnt cmnt);

	public List<Cmnt> Mselect(Cmnt cmnt);


	public List<Cmnt> selectCmntList(CmntPaginationInfo<Cmnt> cpagingVO);

	public int selectCmntCount(CmntPaginationInfo<Cmnt> cpagingVO);

	public void cmntDelete(int cmntId);


}
