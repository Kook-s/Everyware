package kr.or.everyware.admin.main;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import kr.or.everyware.everysolution.service.IEverySolutionService;
import kr.or.everyware.everysolution.vo.Product;
import kr.or.everyware.everysolution.vo.orderProduct;
import kr.or.everyware.everyware.board.vo.Board;
import kr.or.everyware.everyware.calendar.service.CalendarService;
import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/everyware/admin")
@Controller
@Slf4j
public class AdminMainController {


	@Inject
	CalendarService calendarService;
	@Inject
	IEverySolutionService solutionService;
	
	@PreAuthorize("hasAnyAuthority('HOME_AD')")
	@GetMapping("/main")
	public String everyIntroduce(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
//		model.addAttribute("employee",employee);
		
		List<Schedule> companyEventList = calendarService.getCompanyEventList(employee.getCustId());
		int weekEventCount = calendarService.getWeekEventCount(employee);
		int todayEventCount= calendarService.getTodayEventCount(employee);
		int tomorrowEventCount = calendarService.getTomorrowEevntCount(employee);
		orderProduct lastOrderProduct = solutionService.getLastOrderProduct(employee.getCustId());
		Product product = solutionService.getProductById(lastOrderProduct.getPdtId());
		double maxFileSz = lastOrderProduct.getOrdrPerson()*product.getAddFileSz();
		double useFileSz = solutionService.getCustFileSum(employee.getCustId());
		useFileSz = Math.round((useFileSz/1024.0/1024.0/1024.0)*100.0)/100.0;
		List<Board> notices= solutionService.getNoticeFive(employee.getCustId());//ui크기때매 4개로 바꿈
		
		
		Gson gson = new Gson();
		String json = gson.toJson(companyEventList);
		model.addAttribute("eventList",json);
		model.addAttribute("weekEventCount",weekEventCount);
		model.addAttribute("todayEventCount",todayEventCount);
		model.addAttribute("tomorrowEventCount",tomorrowEventCount);
		model.addAttribute("mainActive","active");
		model.addAttribute("maxFileSz",maxFileSz);
		model.addAttribute("useFileSz",useFileSz);
		model.addAttribute("notices",notices);
		
		return "admin/main/main";
	}
}
