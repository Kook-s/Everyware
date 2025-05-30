package kr.or.everyware.everyware.suvy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.suvy.service.SuvyService;
import kr.or.everyware.everyware.suvy.vo.Suvy;
import kr.or.everyware.everyware.suvy.vo.SuvyAnswer;
import kr.or.everyware.everyware.suvy.vo.SuvyItem;
import kr.or.everyware.everyware.suvy.vo.SuvyPaging;
import kr.or.everyware.everyware.suvy.vo.SuvyParticipants;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware")
public class SuvyController<V> {

	@Inject
	private SuvyService suvyService;
	
	/**
	 * goSuvy
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('SUVY')")
	@GetMapping(value = "/suvy")
	public String goSuvy() {
		log.info("goSuvy()");
		return "everyware/suvy/suvy";
	}
	
	/**
	 * 
	 * @param suvy
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAuthority('SUVY')")
	@ResponseBody
	@PostMapping(value = "/suvy/suvyList", produces = "application/json; charset=utf-8")
	public Map<String, Object> getSuvyList(
			@RequestBody Suvy suvy
			, Model model
			){
		log.info("getSuvyList()");
		System.out.println("페이징 검색 정보");
		System.out.println(suvy);
		
		Map<String, Object> suvyMap = new HashMap<String, Object>();
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		suvy.setEmpId(employee.getEmpId());
		suvy.setCustId(employee.getCustId());
		suvy.setCurrentPage(suvy.getPage());
		
		int totalRecord = suvyService.getSuvyCount(suvy);	// 전체 설문건수
		suvy.setTotalRecord(totalRecord);
		
		// 설문목록
		List<Suvy> dataList = suvyService.getSuvyList(suvy);
		System.out.println(dataList.size());
		for (Suvy suvy2 : dataList) {
			List<SuvyItem> suvyItemList = suvyService.getSuvyItemList(suvy2.getSuvyNo());
			suvy2.setSuvyItemList(suvyItemList);
			log.info("suvyItemList : " + suvyItemList);
		}
		
		suvy.setDataList(dataList);
		suvyMap.put("dataList", dataList);
		suvyMap.put("suvyPaging", suvy);
		
		log.info("dataList : " + dataList);
		log.info("suvyPaging : " + suvy);
		
		model.addAttribute("suvyActive", "active");
		return suvyMap;
	}
	
	/**
	 * 설문등록폼 goSuvyForm
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('SUVY')")
	@GetMapping(value = "/suvy/form.do")
	public String goSuvyForm() {
		log.info("goSuvyForm()");
		return "everyware/suvy/suvyForm";
	}
	
	/**
	 * 설문등록폼에서 프로필 목록을 가져오기위한 메소드
	 * @return
	 */
	@PreAuthorize("hasAuthority('SUVY')")
	@RequestMapping("/suvy/getAllProfile")
	public ResponseEntity<List<Employee>> getAllProfileList() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		List<Employee> profileList = suvyService.getAllProfileList(employee);
		
		return new ResponseEntity<List<Employee>>(profileList,HttpStatus.OK);
				
	}
	
	/**
	 * 설문등록
	 * @param suvy
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('SUVY')")
	@ResponseBody
	@PostMapping(value = "/suvy/addSuvy", produces = "application/json; charset=utf-8")
	public String addSuvy(
			@RequestBody Suvy suvy
			, Model model
			) {
		log.info("addSuvy()");
		log.info("addSuvy : ", suvy);
		String addSuvyResult = "";
		
		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		suvy.setEmpId(empId);
		
		ServiceResult result = suvyService.addSuvy(suvy);
		if(result.equals(ServiceResult.OK)) {
			addSuvyResult = "success";
		} else {
			addSuvyResult = "fail";
		}
		model.addAttribute("suvyActive", "active");
		return addSuvyResult;
	}
	
	/**
	 *  goSuvyDetail
	 * 설문상세보기 페이지 이동
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('SUVY')")
	@GetMapping(value = "/suvy/suvyDetail")
	public String goSuvyDetail(int suvyNo, Model model) {
		log.info("goSuvy()");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		
		System.out.println("suv  "+suvyNo);
		Suvy suvy = suvyService.getOneSuvy(suvyNo);
		if(suvy.getEmpId().equals(employee.getEmpId())) {
			model.addAttribute("delYn",'Y');
		}
		if(suvy.getSuvySigned().equals("Y") || suvy.getEmpId().equals(employee.getEmpId())) {
			model.addAttribute("resYn","Y");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empId", employee.getEmpId());
		map.put("suvyNo", suvyNo);
		SuvyParticipants suvyParticipants = suvyService.getIsSuvyMember(map);
		if(suvyParticipants==null) {
			model.addAttribute("voteYn","N");
		}else if(suvyParticipants.getPartYn().equals("Y")) {
			model.addAttribute("revoteYn","Y");
		}else if(suvyParticipants.getPartYn().equals("N")) {
			model.addAttribute("voteYn","Y");
		}
		return "everyware/suvy/suvyDetail";
	}
	
	/**
	 * getOneSuvy
	 * 설문상세보기
	 * @param suvyNo
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/suvy/getOneSuvy/{suvyNo}", produces = "application/json; charset=utf-8")
	public Suvy getOneSuvy(
			@PathVariable("suvyNo") int suvyNo
			, Model model) {
		log.info("getOneSuvy()");
		log.info("suvyNo : " + suvyNo);
		model.addAttribute("suvyActive", "active");
		
		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		model.addAttribute("empId", empId);
		log.info("empId : " + empId);
		
		Suvy suvy = new Suvy();
		suvy = suvyService.getOneSuvy(suvyNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empId", empId);
		map.put("suvyNo", suvyNo);
		List<SuvyAnswer> suvyAnswers = suvyService.getSuvyAnswers(map);
		suvy.setAnswers(suvyAnswers);
		log.info("suvyDetail : " + suvy);
		return suvy;
	}
	
	@ResponseBody
	@DeleteMapping(value = "/suvy/delSuvy/{suvyNo}", produces = "application/json; charset=utf-8")
	public String delSuvy(
			@PathVariable("suvyNo") int suvyNo
			, Authentication authentication
			, Model model) {
		log.info("delSuvy()");
		model.addAttribute("suvyActive", "active");
		String resTxt = "";
		
		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		model.addAttribute("empId2", empId);
		log.info("empId : " + empId);
		
		ServiceResult result = suvyService.delSuvy(suvyNo);
//		log.info("result : " + result);
		
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	@ResponseBody
	@PostMapping(value = "/suvy/vote", produces = "application/json; charset=utf-8")
	public ServiceResult addVote(@RequestBody List<Integer> siNoList) {
		log.info("delSuvy()");
		System.out.println(siNoList);
		ServiceResult res =  suvyService.voteProccess(siNoList);
		return res;
	}
	
	@ResponseBody
	@PostMapping(value = "/suvy/revote", produces = "application/json; charset=utf-8")
	public Map<String, Object> editVote(@RequestBody List<Integer> siNoList) {
		log.info("delSuvy()");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		System.out.println(siNoList);
		int suvyNo =  suvyService.revoteProccess(siNoList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empId", employee.getEmpId());
		map.put("suvyNo", suvyNo);
		List<SuvyAnswer> answerList =  suvyService.getSuvyAnswers(map);
		map.put("siNoList", answerList);
		map.put("res", suvyNo);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/suvy/result", produces = "application/json; charset=utf-8")
	public Map<String, Object> editVote(@RequestBody int suvyNo) {
		log.info("delSuvy()");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		System.out.println(suvyNo);
		System.out.println(suvyNo);
		
		List<SuvyItem> suvyItemList = suvyService.getSuvyItemListAndCount(suvyNo);
		int partCount = suvyService.getSuvyPartCount(suvyNo);
		int subCount = suvyService.getSuvySubCount(suvyNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("itemList", suvyItemList);
		map.put("subCount", subCount);
		map.put("partCount", partCount);
		return map;
	}
}
