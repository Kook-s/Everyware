package kr.or.everyware.admin;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;

import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;

@Controller
public class testController {
	@PreAuthorize("hasAnyAuthority('EM_AD','custauth')")
    @RequestMapping(value = "/everyware/test/test" , method = RequestMethod.GET)
	public String goCalendar(Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isCleint=false;
		if (authentication != null && authentication.isAuthenticated()) {
			authentication.getAuthorities();
		    for (GrantedAuthority authority : authentication.getAuthorities()) {
		        if(authority.getAuthority().equals("custauth")) {
		        	isCleint=true;
		        	break;
		        }
		    }
		}
		
		if(isCleint) {
			CustomUserClient customUser = (CustomUserClient) authentication.getPrincipal();
			Client client = customUser.getClient();
		}else {
			CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
			Employee employee = customUser.getEmployee();
		}
		return "test1";
	}
}
