package kr.or.everyware.everyware.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.everyware.vacation.service.VacationService;
import kr.or.everyware.everyware.vacation.vo.Vacation;
import kr.or.everyware.everyware.vacation.vo.VacationPaging;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware")
public class VacationController {
	
	@Inject
	private VacationService vacationService;
	
	/**
	 * goVacation
	 * @return
	 */
//	@PreAuthorize("hasAnyAuthority('')")
	@GetMapping(value = "/vacation")
	public String goVacation() {
		log.info("goVacation()");
		return "everyware/vacation/vacation";
	}
	
	/**
	 * 휴가목록
	 * @param currentPage
	 * @param searchStartDate
	 * @param searchEndDate
	 * @param searchState
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/vacation/getVacationList",  produces = "application/json; charset=utf-8")
	public Map<String, Object> getVacationList(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
		, @RequestParam(value = "searchStartDate", required = false) String searchStartDate
		, @RequestParam(value = "searchEndDate", required = false)  String searchEndDate
		, @RequestParam(required = false) String searchState
		, Model model
		){
		log.info("getVacationList");
		
		Map<String, Object> vacationMap = new HashMap<String, Object>();
		VacationPaging<Vacation> vacationPaging = new VacationPaging<Vacation>();
		
		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		vacationPaging.setEmpId(empId);
		
		// 검색 기능
		if (searchStartDate != null && searchEndDate != null) {
			vacationPaging.setSearchStartDate(searchStartDate);
			vacationPaging.setSearchEndDate(searchEndDate);
			vacationPaging.setSearchState(searchState);

			model.addAttribute("searchStartDate", searchStartDate);
			model.addAttribute("searchEndDate", searchEndDate);
			model.addAttribute("searchState", searchState);
		}
		vacationPaging.setCurrentPage(currentPage);	// startRow, endRow, startPage, endPage 가 결정
		
		
		// 휴가현황
		int totalRecord = vacationService.getVacationCount(vacationPaging);	// 사원의 전체 휴가건수
		vacationPaging.setTotalRecord(totalRecord);
		
		
		
		// 휴가목록
		// vo에 다른 테이블 vo값? 추가
		List<Vacation> dataList = vacationService.getVacationList(vacationPaging);
		vacationPaging.setDataList(dataList);
		vacationMap.put("dataList", dataList);
		vacationMap.put("pagingVO", vacationPaging);
		
		log.info("dataList : " + dataList);
		log.info("vacationPaging : " + vacationPaging);
		
		return vacationMap;
	}
}
