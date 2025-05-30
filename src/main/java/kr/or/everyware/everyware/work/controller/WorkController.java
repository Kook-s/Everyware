package kr.or.everyware.everyware.work.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.service.WorkService;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware")
public class WorkController {

	@Inject
	private WorkService workService;

	/**
	 * goWork
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@GetMapping(value = "/work")
	public String goWork() {
		System.out.println("goWork");
//		return "everyware/work/test";
		return "redirect:/everyware/work/list.do";
	}
	
	/**
	 * goWork2
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@GetMapping(value = "/work2")
	public String goWork2() {
		log.info("goWork2()");
		return "everyware/work/work2";
	}
	
	/**
	 * 근태목록
	 * @param currentPage
	 * @param searchStartDate
	 * @param searchEndDate
	 * @param searchState
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@RequestMapping(value = "/work/list.do")
	public String getList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, @RequestParam(value = "searchStartDate", required = false) String searchStartDate
			, @RequestParam(value = "searchEndDate", required = false) String searchEndDate
			, @RequestParam(required = false) String searchState
			, Model model
			) {
		log.info("getList()");
		model.addAttribute("workActive", "active");
		
		PaginationInfo<Work> pagingVO = new PaginationInfo<Work>();
		
		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		pagingVO.setEmpId(user.getUsername());
		String empId = user.getUsername();
		
		// 오늘 근태 기록
		List<Work> workList = workService.selectWorkToday(empId);
		model.addAttribute("workList", workList);
		log.info("workList : " + workList);
		
		// 검색 기능
		if(searchStartDate != null && searchEndDate != null) {
			pagingVO.setSearchStartDate(searchStartDate);
			pagingVO.setSearchEndDate(searchEndDate);
			pagingVO.setSearchState(searchState);
			
			model.addAttribute("searchStartDate", searchStartDate);
			model.addAttribute("searchEndDate", searchEndDate);
			model.addAttribute("searchState", searchState);
		}
		
		pagingVO.setCurrentPage(currentPage);	// startRow, endRow, startPage, endPage 가 결정
		
		// 근태현황
		int totalRecode = workService.selectWorkCount(pagingVO);				// 사원의 근태전체건수
		pagingVO.setTotalRecord(totalRecode);
		int totalNormal = workService.selectWorkNormalCount(pagingVO);			// 사원의 근태정상건수
		pagingVO.setTotalNormal(totalNormal);
		int totalExtension = workService.selectWorkExtensionCount(pagingVO);	// 사원의 근태연장건수
		pagingVO.setTotalExtension(totalExtension);
		int totalLateness = workService.selectWorkLatenessCount(pagingVO);		// 사원의 근태지각건수
		pagingVO.setTotalLateness(totalLateness);
		int totalLeaveEarly = workService.selectWorkLeaveEarlyCount(pagingVO);	// 사원의 근태조퇴건수
		pagingVO.setTotalLeaveEarly(totalLeaveEarly);
		int totalVacation = workService.selectWorkVacationCount(pagingVO);		// 사원의 휴가건수
		pagingVO.setTotalVacation(totalVacation);
		
		// 근태목록
		List<Work> dataList = workService.selectWorkList(pagingVO);	
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		
		log.info("dataList : " + dataList);
		log.info("pagingVO : " + pagingVO);
		
		return "everyware/work/work";
	}
	
	// 오늘 출근한 기록이 있으면 insert가 안되도록 O
	// 출근
	@PostMapping(value = "/work/addWorkBgngDt.do")
	public String addWorkBgngDt(
			HttpServletRequest req,
			RedirectAttributes ra,
			Work work, Model model) {
		model.addAttribute("workActive", "active");
		String goPage = "";
		ServiceResult selectResult = null;
		ServiceResult insertResult = null;
		
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		work.setEmpId(user.getUsername());
		
		// 오늘 날짜 기록 있는지 조회
		selectResult = workService.selectWorkTodayCount(req, work);
		
		if(selectResult.equals(ServiceResult.OK)) {
			insertResult = workService.insertWorkBgngDt(req, work);
			if(insertResult.equals(ServiceResult.OK)) {
				System.out.println("addWorkBgngDt 성공");
				goPage = "redirect:/everyware/work";
			}
			else {
				System.out.println("addWorkBgngDt 실패");
				goPage = "redirect:/everyware/work";
			}
		} else {
			System.out.println("오늘날짜 있음, 실패");
			goPage = "redirect:/everyware/work";
		}
		return goPage;
	}
	
	// 퇴근
	@PostMapping(value = "/work/editWorkEndDt.do")
	public String editWorkEndDt(
			HttpServletRequest req,
			Work work, Model model) {
		model.addAttribute("workActive", "active");
		String goPage = "";
		ServiceResult result = null;
		
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		work.setEmpId(user.getUsername());
		
		result = workService.updateWorkEndDt(req, work);
		if(result.equals(ServiceResult.OK)) {
			System.out.println("editWorkEndDt 성공");
			goPage = "redirect:/everyware/work";
		} else {
			System.out.println("editWorkEndDt 실패");
			goPage = "redirect:/everyware/work";
		}
		
		return goPage;
	}
	
	
	
	
	
	/**
	 * 근태목록 ajax
	 * @param searchData
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@ResponseBody
	@PostMapping(value = "/work/workList", produces = "application/json; charset=utf-8") 
	public Map<String, Object> getWorkList(
			@RequestBody Work searchData
			, Model model
//		@RequestParam(value = "searchStartDate", required = false) String searchStartDate
//		, @RequestParam(value = "searchEndDate", required = false)  String searchEndDate
//		, @RequestParam(required = false) String searchState
		){
		log.info("getWorkList()");
//		Work work = new Work();
		Map<String, Object> workListMap = new HashMap<String, Object>();

		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		searchData.setEmpId(empId);
		
		// 검색 기능
		if (searchData != null) {
			workListMap.put("searchData", searchData);
			log.info("searchData" + searchData);
		} 
		
		// 근태현황
		int totalWork = workService.getWorkCount(searchData);				// 사원의 근태전체건수
		searchData.setTotalWork(totalWork);
		workListMap.put("totalWork", totalWork);
		int totalNormal = workService.getWorkNormalCount(searchData);			// 사원의 근태정상건수
		searchData.setTotalNormal(totalNormal);
		workListMap.put("totalNormal", totalNormal);
		int totalExtension = workService.getWorkExtensionCount(searchData);	// 사원의 근태연장건수
		searchData.setTotalExtension(totalExtension);
		workListMap.put("totalExtension", totalExtension);
		int totalLateness = workService.getWorkLatenessCount(searchData);		// 사원의 근태지각건수
		searchData.setTotalLateness(totalLateness);
		workListMap.put("totalLateness", totalLateness);
		int totalLeaveEarly = workService.getWorkLeaveEarlyCount(searchData);	// 사원의 근태조퇴건수
		searchData.setTotalLeaveEarly(totalLeaveEarly);
		workListMap.put("totalLeaveEarly", totalLeaveEarly);
		int totalVacation = workService.getWorkVacationCount(searchData);		// 사원의 휴가건수
		searchData.setTotalVacation(totalVacation);
		workListMap.put("totalVacation", totalVacation);
		
		// 근태목록
		List<Work> dataList = workService.getWorkList(searchData);	
		workListMap.put("dataList", dataList);
		
//		log.info("dataList : " + dataList); 
		log.info("workListMap : " + workListMap);
		
		model.addAttribute("workActive", "active");
		return workListMap;
	}
	
	@ResponseBody
	@GetMapping(value = "/work/getAllWork", produces = "application/json; charset=utf-8")
	public List<Work> getAllWork(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		
		List<Work> workList = workService.getAllWork(employee.getEmpId());
		log.info("메인페이지 7일간 데이터  "+workList);
		return workList;
	}
	
	@ResponseBody
	@PostMapping(value = "/work/workAddDel", produces = "application/json; charset=utf-8")
	public List<Work> workAddDel(String time , String hr){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		log.info(time +"  @@@@@@@  "+hr);
         log.info("  @@@@@@@  "+employee.getGroupNo());
         
         Work work = new Work();
         WorkGroup workGroup = workService.getWorkGroup(employee.getGroupNo()); 
         
         work.setEmpId(employee.getEmpId());
         int cnt =0;
         
         if(hr.equals("출근")) {
        	 cnt = workService.getTodayWork(work);
        	 
        	 if(cnt ==0) {
        		 LocalDateTime now = LocalDateTime.now();
        		 LocalDateTime dateTime1 = LocalDateTime.parse(workGroup.getGroupWorkBgngDt(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        		 
        		 if (dateTime1.getHour()<now.getHour()) {
        			 work.setWorkState("지각");
        		 }else {
        			 work.setWorkState("출근");
        		 }
        		 
        		 workService.addTodayWork(work);
        	 }
         }else  if(hr.equals("퇴근")) {
        	 LocalDateTime now = LocalDateTime.now();
        	 LocalDateTime dateTime1 = LocalDateTime.parse(workGroup.getGroupWorkEndDt(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    		 work = workService.getTodayWork2(employee.getEmpId());
    		 
    		 if (dateTime1.getHour()>now.getHour()) {
         		work.setWorkState("조퇴");
	     	 } else {
	     		 if(!work.getWorkState().equals("지각")) {
	         		 if((dateTime1.getHour()+1)<now.getHour()){
	                 	 work.setWorkState("연장");
	                  } else{
	                 	 work.setWorkState("퇴근");
	                  }
	     		 }
	     	 }
        	 workService.editTodayWork(work);
         }
         
         List<Work> workList = workService.getAllWork(employee.getEmpId());
         
		return workList;
	}
	
	
	@ResponseBody
	@GetMapping(value = "/work/getWorkTime", produces = "application/json; charset=utf-8")
	public Work getWorkTime(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		Work work = workService.getTodayWork2(employee.getEmpId());
		
		return work;
	}
	
	/**
	 * 상세보기
	 * @param workNo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/work/getOneWork/{workNo}", produces = "application/json; charset=utf-8")
	public Work getOneWork(
			@PathVariable("workNo") int workNo
			, Model model) {
		log.info("getOneWork()");
		
		Work work = new Work();
		work = workService.getOneWork(workNo);
		log.info("workDetail : " + work);

		return work;
	}
	
	
}
