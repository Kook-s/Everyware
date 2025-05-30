package kr.or.everyware.everyware.document.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.everyware.everyware.document.mapper.TemplateMapper;
import kr.or.everyware.everyware.document.service.ITemplateService;
import kr.or.everyware.everyware.vacation.vo.Vacation;

@Service
public class TemplateServiceImpl implements ITemplateService {
	
	@Autowired
	private TemplateMapper templateMapper;

	@Override
	public List<Vacation> getVacationItems(String custId) {
		return templateMapper.selectVacationItems(custId);
	}

}
