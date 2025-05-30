package kr.or.everyware.everyware.cmnt.service.Impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.everyware.cmnt.mapper.CmntMapper;
import kr.or.everyware.everyware.cmnt.service.CmntService;
import kr.or.everyware.everyware.cmnt.vo.Cmnt;
import kr.or.everyware.everyware.cmnt.vo.CmntPaginationInfo;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CmntServiceImpl implements CmntService {

	@Inject
	CmntMapper mapper;

	@Override
	public void cmntInsert(Cmnt cmnt) {
		mapper.cmntInsert(cmnt);
	}

	@Override
	public List<Cmnt> selectCmntList(CmntPaginationInfo<Cmnt> cpagingVO) {
		return mapper.selectCmntList(cpagingVO);
	}

	@Override
	public int selectCmntCount(CmntPaginationInfo<Cmnt> cpagingVO) {
		// TODO Auto-generated method stub
		return mapper.selectCmntCount(cpagingVO);
	}

	@Override
	public void cmntDelete(int cmntId) {
		// TODO Auto-generated method stub
		mapper.cmntDelete(cmntId);
	}

}
