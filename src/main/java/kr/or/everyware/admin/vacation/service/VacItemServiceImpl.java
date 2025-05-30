package kr.or.everyware.admin.vacation.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.vacation.mapper.VacItemMapper;
import kr.or.everyware.admin.vacation.vo.VacItem;

@Service
public class VacItemServiceImpl implements VacItemService{

	@Inject
	private VacItemMapper vacItemMapper;
	
	@Override
	public List<VacItem> getVacItem(String custId) {
		return vacItemMapper.getVacItem(custId);
	}

	@Override
	public ServiceResult addVacItem(VacItem vacItem) {
		ServiceResult result = null;
		
		int status = vacItemMapper.addVacItem(vacItem);
		
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public int delVacItem(int viNo) {
		return vacItemMapper.delVacItem(viNo);
	}

	@Override
	public ServiceResult editVacItem(VacItem vacItem) {
		ServiceResult result = null;
		
		int status = vacItemMapper.editVacItem(vacItem);
		
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

}
