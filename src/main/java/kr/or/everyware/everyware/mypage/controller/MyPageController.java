package kr.or.everyware.everyware.mypage.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.mypage.service.MyPageservice;
import kr.or.everyware.everyware.mypage.vo.MyPage;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.login.vo.LoginLog;
import kr.or.everyware.util.attachment.vo.AttachFile;
import kr.or.everyware.util.fileUtils.MediaUtils;
import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasAuthority('MAIL')")

@Controller
@Slf4j
@RequestMapping("/everyware")
public class MyPageController {

	@Inject
	private MyPageservice service;

	@Resource(name="uploadPath")
	private String resourcesPath;
	
// 비밀번호 확인 창
	@RequestMapping("/mypage")
	public String goMypageFomr(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		model.addAttribute("emp", employee);
		log.info(":::::  " + employee);

		return "everyware/mypage/mypage";
	}
// ----------------------------------------------------------------------------------------------
	// 마이페이지메인창

	@RequestMapping("/mypagemain")
	public String goMyPageMain(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		String page="";
//		model.addAttribute("employee", employee);
		
		String attribute = (String)model.getAttribute("flag");
		if("true".equals(attribute)) {
			page="everyware/mypage/mypagemain";
		}else {
			page="redirect:/everyware/mypage";
		}
		return page;
		
	}
	
	@RequestMapping("/confirmPw")
	public String confirmPw(Employee emp ,RedirectAttributes ra) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		String page = "";
		//시큐리티 암호화하면 비번인증방식 바꿔야함
		if(employee.getEmpPw().equals(emp.getEmpPw())) {
			ra.addFlashAttribute("flag","true");
			System.out.println("1분기");
			page="redirect:/everyware/mypagemain";
		}else {
			ra.addFlashAttribute("flag","false");
			System.out.println("2분기");
			page="redirect:/everyware/mypage";
		}
		
		
//		model.addAttribute("employee", employee);
		return page;

	}
	
	
	@PostMapping(value="/mypage/empInfo")
	@ResponseBody
	public Map<String, Object> getEmpInfo() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", ServiceResult.OK);
		map.put("emp", employee);
		return map;
	}
	
	@PostMapping(value="/mypage/ipInfo")
	@ResponseBody
	public Map<String, Object> getIpInfo() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		List<LoginLog> ipList =service.getIpList(employee.getEmpId());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", ServiceResult.OK);
		map.put("ipList", ipList);
		return map;
	}
	
	@PostMapping(value="/mypage/upEmp")
	@ResponseBody
	public Map<String, Object> editEmployee(Employee emp) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		emp.setEmpId(employee.getEmpId());
		ServiceResult res = service.updateEmployee(emp);
		if(res.equals(ServiceResult.OK)) {
			Employee newEmp =  service.readByEmployeeId(employee.getEmpId());
			customUser.setEmployee(newEmp);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		map.put("emp", customUser.getEmployee());
		return map;
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@GetMapping(value = "/mypage/thumbnail")
	public ResponseEntity<byte[]> getProfileImg(String empId){
		InputStream is=null;
		ResponseEntity<byte[]> entity = null;
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
			Employee employee = customUser.getEmployee();
			String savedFileName="";
			System.out.println("이엠피아디: "+ empId);
			if(empId!=null && !"".equals(empId)) {
				Employee newEmp= service.getEmployee(empId);
				savedFileName=newEmp.getEmpProfile();
			}else {
				savedFileName=employee.getEmpProfile();
			}
			String front = savedFileName.substring(0,12); 	// /2023/06/07 폴더
			String end = savedFileName.substring(12);		// 뒤 파일 명
			String fileName= front+"s_"+end;
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMeMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			is = new FileInputStream(resourcesPath+fileName);
			if(mType!=null) {
				headers.setContentType(mType);
			}else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; fileName=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is),headers,HttpStatus.CREATED);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return entity;
	}
}
