package kr.or.everyware.everyware.vacation.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.everyware.vacation.mapper.VacationMapper;
import kr.or.everyware.everyware.vacation.vo.Vacation;
import kr.or.everyware.everyware.vacation.vo.VacationPaging;

@Service
public class VacationServiceImpl implements VacationService{

	@Inject
	private VacationMapper vacationMapper;
	
	@Override
	public List<Vacation> getVacationList(VacationPaging<Vacation> vacationPaging) {
		return vacationMapper.getVacationList(vacationPaging);
	}

	@Override
	public int getVacationCount(VacationPaging<Vacation> vacationPaging) {
		return vacationMapper.getVacationCount(vacationPaging);
	}

}
