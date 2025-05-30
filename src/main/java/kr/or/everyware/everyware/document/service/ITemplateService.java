package kr.or.everyware.everyware.document.service;

import java.util.List;

import kr.or.everyware.everyware.vacation.vo.Vacation;

public interface ITemplateService {

	List<Vacation> getVacationItems(String custId);
	
}
