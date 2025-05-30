package kr.or.everyware.admin.emp.controller;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.emp.service.IAdminService;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.login.vo.AuthMenu;
import kr.or.everyware.login.vo.AuthorityGroup;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everyware/popup")
@Slf4j
public class PopupWindowController {

	@Inject
	private IAdminService adminService;

//    개인정보 수정 팝업
	@PreAuthorize("hasAnyAuthority('EM_AD','custauth')")
	@GetMapping("/popupWindow")
	public String goPopupWindow(Model model, String empId) {
		log.info("@@@@@@@  " + empId);

		Employee emp = adminService.getPopEmployee(empId);
		List<Department> dept = adminService.getDepartment(emp.getCustId());
		List<Position> posi = adminService.getPosition(emp.getCustId());

		model.addAttribute("emp", emp);
		model.addAttribute("deptList", dept);
		model.addAttribute("posiList", posi);
		return "popup/popup";
	}

	@PostMapping("/modify")
	public ResponseEntity<ServiceResult> editEmployee(Model model, String empData, String empType, String empId) {

		ServiceResult res = null;
		Employee emp = new Employee();
		int empInt = 0;

		log.info("111 " + empData);
		log.info("222 " + empType);
		log.info("333 " + empId);
		emp.setEmpId(empId);

		if (empType.equals("empId")) {
			emp.setEmpId(empData);
		} else if (empType.equals("empPw")) {
			emp.setEmpPw(empData);
		} else if (empType.equals("empTel")) {
			emp.setEmpTel(empData);
		} else if (empType.equals("empMail")) {
			emp.setEmpMail(empData);
		} else if (empType.equals("empPost")) {
			emp.setEmpPost(empData);
		} else if (empType.equals("empAddr1")) {
			emp.setEmpAddr1(empData);
		} else if (empType.equals("empAddr2")) {
			emp.setEmpAddr2(empData);
		}
		log.info("확인 " + emp);

		res = adminService.editEmployee(emp);
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}

	@GetMapping("/empPopup")
	public String empPopup(Model model, String custId) {
		model.addAttribute("custId", custId);
		return "popup/empPopup";
	}

	 @PreAuthorize("hasAnyAuthority('EM_AD','custauth')")
	@ResponseBody
	@RequestMapping(value = "/excelEmp", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public List<Employee> ExcelEmp(MultipartFile file) throws Exception {
String custId="";
        
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
			custId = client.getCustId();
		}else {
			CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
			Employee employee = customUser.getEmployee();
			custId = employee.getCustId();
		}

		List<Employee> beforeEmpList = adminService.getEmployee(custId);
		List<Department> depList = adminService.getDepartment(custId);
		List<Position> posiList = adminService.getPosition(custId);

		log.info("OriginalName: " + file.getOriginalFilename());

		InputStream is = file.getInputStream();

		XSSFWorkbook workbook = new XSSFWorkbook(is);
		XSSFSheet sheet = workbook.getSheet("사원정보");
		int a = 0;
		boolean flag = false;
		boolean stringNum = false;

		List<Employee> empList = new ArrayList<Employee>();
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMdd");
		for (Row row : sheet) {

			Iterator<Cell> cellIterator = row.cellIterator();
			List<String> list = new ArrayList<String>();

			while (cellIterator.hasNext()) {
				Cell cell = cellIterator.next();

				switch (cell.getCellType()) {

				case NUMERIC:
					if (flag) {
						list.add(String.valueOf((int) cell.getNumericCellValue()));
					}
					break;

				case STRING:
					if (cell.getStringCellValue().equals("사번")) {
						stringNum = true;
					}
					if (flag) {
						list.add(cell.getStringCellValue());
					}
					break;
				}
			}

			a++;
			log.info("확인 ::: " + a);
			if (list.size() == 0) {
				flag = false;
			}

			if (flag) {

				Employee employee = new Employee();

				employee.setEmpId(list.get(0));
				employee.setEmpPw(list.get(1));

				for (Department dep : depList) {
					if (dep.getDeptNm().equals(list.get(3))) {
						employee.setDepartment(dep);
						employee.setDeptId(Integer.parseInt(dep.getDeptId()));
					}
				}
				for (Position posi : posiList) {
					if (posi.getJbgdNm().equals(list.get(2))) {
						employee.setPosition(posi);
						employee.setJbgdId(posi.getJbgdId());
					}
				}
				employee.setCustId(custId);
//				employee.setDeptId(Integer.parseInt(list.get(2)));
//				employee.setJbgdId(Integer.parseInt(list.get(3)));
				employee.setEmpName(list.get(4));
				employee.setEmpBirth(list.get(5));//이거 employee empBirth타입을 String으로 해서 에러나..
				employee.setEmpTel(list.get(6));
				employee.setEmpPost(list.get(7));
				employee.setEmpAddr1(list.get(8));
				employee.setEmpAddr2(list.get(9));
				employee.setEmpDate(list.get(10));//이거 employee empBirth타입을 String으로 해서 에러나..
				employee.setEmpIdno(list.get(11));
				// empList.get(i).setEmpVac(list.get(12));
				// employee.setEmpMail(list.get(13));
				empList.add(employee);
//				log.info("담긴거확인" + empList);

			}
			if (stringNum) {
				flag = true;
			}
		}

		log.info("담긴거확인 ::: " + empList);

		return empList;
	}

	@PostMapping("/addNewEmp")
	@ResponseBody
	public ResponseEntity<ServiceResult> addNewEmp(@RequestBody List<Employee> empList) {
		log.info("@@@@@@@@@ " + empList);
		ServiceResult res = null;
		for (Employee emp : empList) {
			res = adminService.addNewEmp(emp);
		}
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}

	@GetMapping("/authPopup")
	public String authPopup(Model model, String custId) {
		String custIds="";
        
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
			custIds = client.getCustId();
		}else {
			CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
			Employee employee = customUser.getEmployee();
			custIds = employee.getCustId();
		}

		List<AuthorityGroup> authList = adminService.getAuthList(custIds);

		model.addAttribute("custId", custId);
		model.addAttribute("authList", authList);
		return "popup/authPopup";
	}

	@PostMapping("/addAuthGrop")
	public ResponseEntity<ServiceResult> addAuthGrop(Model model, String authrtNm) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserClient custtomUser = (CustomUserClient) authentication.getPrincipal();
		Client client = custtomUser.getClient();

		ServiceResult res = null;
		log.info("권한이름 ::: " + authrtNm);
		AuthorityGroup authGroup = new AuthorityGroup();
		authGroup.setAuthrtNm(authrtNm);
		authGroup.setCustId(client.getCustId());
		res = adminService.addAuthGrop(authGroup);
		log.info("권한이름 @@ " + res);
		res = adminService.addAuthMenu(authGroup.getAuthrtId());

		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}

	@PostMapping("/getAuthMenu")
	@ResponseBody
	public List<AuthMenu> getAuthMenu(Model model, String authrtId) {
		List<AuthMenu> authMenuList = adminService.getAuthMenu(authrtId);
		return authMenuList;
	}
	
	@PostMapping("/addDelAuthMenu")
	@ResponseBody
	public ResponseEntity<ServiceResult> addDelAuthMenu(Model model, String authrtId , String addDel , String authMenu) {
		ServiceResult res = null;
		log.info("1 : "+authrtId+"  2 : "+addDel+" 3 : "+ authMenu);
		
		AuthMenu menu = new AuthMenu();
		
		
		menu.setAuthrtId(Integer.parseInt(authrtId));
		menu.setMenuId(authMenu);
		
		if(addDel.equals("Y")) {
			res = adminService.addAuthMenu(menu);
		}else {
			res = adminService.delAuthMenu(menu);
		}
		
		int cntAD = adminService.countAD(authrtId);
		log.info("@@@@@@@@@ "+cntAD);
		if(cntAD > 0) {
			if(adminService.getHomeAD(authrtId) == 0) {
				log.info("123123   관리자 홈 권한 없음");
				adminService.addHomeAD(authrtId);
			}else {
				log.info("123123   관리자 홈 권한 있음");
			}
		}
		if(cntAD == 1){
			adminService.delHomeAD(authrtId);
		}
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}

}
