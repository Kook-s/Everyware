//package kr.or.everyware.admin.work.controler;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import javax.inject.Inject;
//
//import org.apache.commons.collections.map.HashedMap;
//import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import kr.or.everyware.admin.work.vo.WorkAdjAdmin;
//import kr.or.everyware.login.vo.CustomUserEmployee;
//import kr.or.everyware.login.vo.Employee;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Controller
//@RequestMapping("/everyware/admin")
//public class WorkAdjAdminController {
//	
//	@Inject
//	private WorkAdjAdminService workAdjAdminService;
//	
//	/**
//	 * goWorkAdjAdmin
//	 * @param model
//	 * @return
//	 */
//	@PreAuthorize("hasAnyAuthority('HR_AD')")
//	@GetMapping(value = "/workAdj")
//	public String goWorkAdjAdmin(Model model) {
//		log.info("goWorkAdjAdmin()");
//		return "admin/work/workAdjAdmin";
//	}
	
//	
//	public Map<String, Object> getAdminWorkAdjList(
//			@RequestBody WorkAdjAdmin workAdjAdmin
//			, Model model
//			){
//		log.info("getAdminWorkAdjList()");
//		log.info("workAdjAdmin : " + workAdjAdmin);
//		
//		Map<String, Object> workAdjAdminMap = new HashMap<String, Object>();
//		
//		// security User
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
//		Employee employee = customUser.getEmployee();
//		log.info("employee : " + employee);
//		
//		workAdjAdmin.setEmpId(employee.getEmpId());
//		workAdjAdmin.setCustId(employee.getCustId());
//		workAdjAdmin.setCurrentPage(workAdjAdmin.getPage());
//		log.info("workAdjAdmin : " + workAdjAdmin);
		
		// 목록
		
		
//	}
//}
