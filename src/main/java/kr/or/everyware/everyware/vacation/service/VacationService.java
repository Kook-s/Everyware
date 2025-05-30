package kr.or.everyware.everyware.vacation.service;

import java.util.List;

import kr.or.everyware.everyware.vacation.vo.Vacation;
import kr.or.everyware.everyware.vacation.vo.VacationPaging;

public interface VacationService {

	public List<Vacation> getVacationList(VacationPaging<Vacation> vacationPaging);
	public int getVacationCount(VacationPaging<Vacation> vacationPaging);

}
