package kr.or.everyware.admin.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.vacation.service.VacItemService;
import kr.or.everyware.admin.vacation.vo.VacItem;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware/admin")
public class VacItemController {
	
	@Inject
	private VacItemService vacItemService;
	
	/**
	 * goVacItem
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR_AD')")
	@GetMapping(value = "/vacation/vacItem")
	public String goVacItem() {
		log.info("goVacItem()");
		return "admin/vacation/vacItem";
	}
	
	/**
	 * 목록
	 * getVacItem
	 * @param authentication
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/vacation/vacItem/vacItemList", produces = "application/json; charset=utf-8")
	public Map<String, Object> getVacItem(
			Authentication authentication
			, Model model){
		log.info("getVacItem()");
		
		// security User
		authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		log.info("employee : " + employee);
	
		HashMap<String, Object> vacItemMap = new HashMap<String, Object>();
		
		List<VacItem> vacItem = vacItemService.getVacItem(employee.getCustId());
		log.info("vacItem : " + vacItem);
		
		vacItemMap.put("vacItem", vacItem);
		
		return vacItemMap;
	}
	
	/**
	 * 추가
	 * @param vacItem
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/vacation/vacItem/addVacItem", produces = "application/json; charset=utf-8")
	public String addVacItem(
			@RequestBody VacItem vacItem
			, Model model) {
		log.info("addVacItem()");
		String resTxt = "";
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		vacItem.setCustId(employee.getCustId());
		log.info("vacItem : " + vacItem);
		
		ServiceResult result = vacItemService.addVacItem(vacItem);
		log.info("result : " + result);
		
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		return resTxt;
	}
	
	/**
	 * 삭제
	 * delVacItem
	 * @param viNo
	 * @return
	 */
	@ResponseBody
	@DeleteMapping(value = "/vacation/vacItem/delVacItem/{viNo}", produces = "application/json; charset=utf-8")
	public String delVacItem(@PathVariable("viNo") int viNo) {
		log.info("delVacItem()");
		log.info("viNo : " + viNo);
		String resTxt = "";
		
		int result = vacItemService.delVacItem(viNo);
		log.info("result :" + result);
		
		if(result > 0) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
	/**
	 * 수정
	 * @param vacItem
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PutMapping(value = "/vacation/vacItem/editVacItem", produces = "application/json; charset=utf-8")
	public String editVacItem(
			@RequestBody VacItem vacItem
			, Model model) {
		log.info("editVacItem()");
		log.info("vacItem : " + vacItem);
		String resTxt = "";
		
		ServiceResult result = vacItemService.editVacItem(vacItem);
		log.info("result : " + result);
		
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
}
