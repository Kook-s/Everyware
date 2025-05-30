package kr.or.everyware.admin.fingerhr.controller;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;
import gnu.io.SerialPort;
import kr.or.everyware.admin.fingerhr.service.FingerService;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/everyware/admin")
@Controller
@Slf4j
public class FingerHRController {
	
	@Inject
	private FingerService fingerService;
	

	
	    @GetMapping("/fingerHR")
	    @PreAuthorize("hasAnyAuthority('custauth')")
	    public String fingerHR(Model model) throws Exception {
	    	
	    	 CommPortIdentifier portIdentifier = CommPortIdentifier.getPortIdentifier("COM4");
	         if ( portIdentifier.isCurrentlyOwned() )
	         {
	             System.out.println("Error: Port is currently in use");
	         }
	         else
	         {
	             //클래스 이름을 식별자로 사용하여 포트 오픈
	             CommPort commPort = portIdentifier.open(this.getClass().getName(),2000);
	             
	             if ( commPort instanceof SerialPort )
	             {
	                 //포트 설정(통신속도 설정. 기본 9600으로 사용)
	                 SerialPort serialPort = (SerialPort) commPort;
	                 serialPort.setSerialPortParams(9600,SerialPort.DATABITS_8,SerialPort.STOPBITS_1,SerialPort.PARITY_NONE);
	                 
	                 //Input,OutputStream 버퍼 생성 후 오픈
	                 InputStream in = serialPort.getInputStream();
	                 
	                  //읽기, 쓰기 쓰레드 작동
	                 (new Thread(new SerialReader(in))).start();

	             }
	             else
	             {
	                 System.out.println("Error: Only serial ports are handled by this example.");
	             }
	         }     
	         return "FingerHR/FingerHR";
	    }

	    public  class SerialReader implements Runnable 
	    {
	        InputStream in;
	        
	        public SerialReader ( InputStream in )
	        {
	            this.in = in;
	        }
	        
	        public void run ()
	        {
	            byte[] buffer = new byte[1024];
	            int len = -1;
	            try
	            {
	                while ( ( len = this.in.read(buffer)) > -1 )
	                {
	                    String fingerId = new String(buffer,0,len);
	                    Employee emp = fingerService.getFingerEmp(fingerId);
	                    log.info("@@  "+emp);
	                    
	                    if(emp!= null) {
	                    	WorkGroup  workGroup = fingerService.getWorkGroup(emp.getGroupNo());
	                    	int TodayWork = fingerService.getEmpWork(emp.getEmpId());
	                    	
	                    	Work work = new Work();
	                    	work.setEmpId(emp.getEmpId());
	                    	
	                    if(TodayWork == 0 ) {//-----------------
	                    	//출근 지각
	                    	 LocalDateTime dateTime1 = LocalDateTime.parse(workGroup.getGroupWorkBgngDt(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	                    	 LocalDateTime now = LocalDateTime.now();
	                    	
	                    	if (dateTime1.getHour()<now.getHour()) {
	                    		work.setWorkState("지각");
	                         } else {
	                        	 work.setWorkState("출근");
	                         }
	                    	 
	                    	fingerService.addEmpWork(work);
	                    }else {
	                    	//퇴근 연장 조퇴
	                    	LocalDateTime dateTime1 = LocalDateTime.parse(workGroup.getGroupWorkEndDt(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	                    	 LocalDateTime now = LocalDateTime.now();
	                    	work = fingerService.getWork(emp.getEmpId());
	                    	 
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
	                    	
	                    	fingerService.editEmpWork(work);
	                    }
	                    	
	                    }
	                }
	            }
	            catch ( IOException e )
	            {
	                e.printStackTrace();
	            }            
	        }
	    }
	    @PreAuthorize("hasAnyAuthority('custauth')")
	    @ResponseBody
	    @RequestMapping(value="/fingerEmpList", produces = "application/json;charset=utf-8")
	    public List<Employee> fingerEmpList(){
	    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	         CustomUserClient custtomUser = (CustomUserClient)authentication.getPrincipal();
	         Client client = custtomUser.getClient();
	         
	         List<Employee> empList = fingerService.getFingerEmpList(client.getCustId());
	    	return empList;
	    }

}
