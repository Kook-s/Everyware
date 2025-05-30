package kr.or.everyware.admin.vacation.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.vacation.vo.VacItem;

public interface VacItemService {

	public List<VacItem> getVacItem(String custId);

	public ServiceResult addVacItem(VacItem vacItem);

	public int delVacItem(int viNo);

	public ServiceResult editVacItem(VacItem vacItem);

}
