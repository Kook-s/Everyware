package kr.or.everyware.admin.emp.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.emp.service.IAdminService;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.login.vo.AuthorityGroup;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.fileUtils.MediaUtils;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everyware/admin")
@Slf4j
public class AdminComtroller {

    @Inject
    private IAdminService adminService;
    
    @Resource(name="uploadPath")
	private String resourcesPath;

    @PreAuthorize("hasAnyAuthority('EM_AD','custauth')")
    @RequestMapping(value = "/management" , method = RequestMethod.GET)
    public String goAdmin(Model model){

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
        

        List<Employee> empList = adminService.getEmployee(custId);
        List<Department> dept = adminService.getDepartment(custId);
        List<Position> posi = adminService.getPosition(custId);
        List<AuthorityGroup> authGroup = adminService.getAuthList(custId);
        List<WorkGroup> workGroup = adminService.getWorkGroupList(custId);
        

        model.addAttribute("workGroupList" ,workGroup);
        model.addAttribute("empList" ,empList);
        model.addAttribute("depList" ,dept);
        model.addAttribute("posiList" ,posi);
        model.addAttribute("authList" ,authGroup);
        
        model.addAttribute("custId" ,empList.get(0).getCustId());

        return "admin/management";
    }
    
    @PostMapping("/addDepartment")
    public ResponseEntity<ServiceResult> addDepartment(Model model , String deptNm){
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
    	
    	ServiceResult res = null;
    	Department dep = new Department();
    	dep.setDeptNm(deptNm);
    	dep.setCustId(custId);
    	System.out.println(dep);
    	res = adminService.addDepartment(dep);
    	
    	return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
    }
    
    @PostMapping("/addPosition")
    public ResponseEntity<ServiceResult> addPosition(Model model , String posiNm){
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

        ServiceResult res = null;
        Position posi = new Position();
        posi.setJbgdNm(posiNm);
        posi.setCustId(custId);
        res = adminService.addPosition(posi);

        return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
    }

    @PostMapping("/editDepartment")
    public ResponseEntity<ServiceResult> editDepartment(Model model , String deptId, @RequestParam("empId")String empId){

        Employee emp = new Employee();
        emp.setEmpId(empId);
        emp.setDeptId(Integer.parseInt(deptId));

        ServiceResult res = null;
        res = adminService.editDepartment(emp);

        return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
    }

    @PostMapping("/editPosition")
    public ResponseEntity<ServiceResult> editPosition(Model model , String jbgdId, @RequestParam("empId")String empId){
    	
    	Employee emp = new Employee();
    	emp.setEmpId(empId);
    	emp.setJbgdId(Integer.parseInt(jbgdId));
    	
    	ServiceResult res = null;
    	res = adminService.editPosition(emp);
    	
    	return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
    }
    
    @PostMapping("/editAuth")
    public ResponseEntity<ServiceResult> editAuth(Model model , String authrtId, @RequestParam("empId")String empId){

        Employee emp = new Employee();
        emp.setEmpId(empId);
        emp.setAuthrtId(Integer.parseInt(authrtId));
    

        ServiceResult res = null;
        res = adminService.editAuth(emp);

        return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
    }
    
    @PostMapping("/editWorkGroup")
    public ResponseEntity<ServiceResult> editWorkGroup(Model model , String groupNo, @RequestParam("empId")String empId){

        Employee emp = new Employee();
        emp.setEmpId(empId);
        emp.setGroupNo(Integer.parseInt(groupNo));
        log.info("@@@@@@" + emp);
        ServiceResult res = null;
        res = adminService.editWorkGroup(emp);

        return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
    }
    
    
    @PostMapping("/delDepartment")
    public ResponseEntity<ServiceResult> delDepartment(Model model, String deptId){
    	log.info("삭제 확인 :: "+deptId);
    	
    	
    	ServiceResult res = null;
    	res = adminService.delDepartment(deptId);
    	return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
    }
    
    @PostMapping("/delPosition")
    public ResponseEntity<ServiceResult> delPosition(Model model, String jbgdId){
    	log.info("삭제 확인 :: "+jbgdId);
    	
    	
    	ServiceResult res = null;
    	res = adminService.delPosition(jbgdId);
    	return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
    }
    
    @PreAuthorize("hasAnyAuthority('EM_AD','custauth')")
	@GetMapping(value = "/thumbnail")
	public ResponseEntity<byte[]> getProfileImg(String empId){
		InputStream is=null;
		ResponseEntity<byte[]> entity = null;
		try {
			
			
			String savedFileName="";
			System.out.println("이엠피아디: "+ empId);
			Employee newEmp= adminService.getEmployeeOne(empId);
			savedFileName=newEmp.getEmpProfile();
			
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
