
package kr.or.everyware.everysolution.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everysolution.service.IEverySolutionService;
import kr.or.everyware.everysolution.vo.Product;
import kr.or.everyware.everysolution.vo.WorkStatistic;
import kr.or.everyware.everysolution.vo.orderProduct;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everysolution")
@Slf4j
public class everyController {

	@Inject
	private IEverySolutionService everyService;

	@RequestMapping(value = "/home")
	public String everyHome() {
		return "every/home";
	}
	
	@RequestMapping(value = "/signup" , method = RequestMethod.GET)
	public String goEverySignup() {
		return "every/signup";
	}
	
	@RequestMapping(value = "/signup" , method = RequestMethod.POST)
	public String addEverySignup(Client client , Model model) {
		System.out.println(client);

		int cnt =  everyService.addEverySignup(client);
		return "every/home";
	}

	@RequestMapping(value = "/membership" , method = RequestMethod.GET)
	public String goMembership() {
		return "every/membership";
	}

	@PreAuthorize("hasAuthority('custauth')")
	@RequestMapping(value = "/payment" , method = RequestMethod.GET)
	public String goEveryMembershipPayment(Model model , String pdtNm) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserClient custtomUser = (CustomUserClient)authentication.getPrincipal();
		Client client = custtomUser.getClient();
		Product product = everyService.getProduct(pdtNm);

		System.out.println(pdtNm);
		System.out.println(product);

		model.addAttribute("client" , client);
		model.addAttribute("product" , product);

		return "every/membershipPayment";
	}

	@PreAuthorize("hasAuthority('custauth')")
	@RequestMapping(value = "/payment" , method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> addEveryMembershipPayment(String custId, String ordrPerson ,Model model) {
		ServiceResult res = null;

		System.out.println(custId +" "+ ordrPerson);

		 orderProduct order = new orderProduct();
		 order.setCustId(custId);
		 order.setPdtId(1);
		 order.setOrdrAmt(100000*Integer.parseInt(ordrPerson));
		 order.setOrdrPerson(Integer.parseInt(ordrPerson));

		res = everyService.addOrderProduct(order);

		return new ResponseEntity<ServiceResult>(res,HttpStatus.OK);
	}

	@PreAuthorize("hasAuthority('custauth')")
	@RequestMapping(value = "/successPayment" , method = RequestMethod.GET)
	public String goSuccessPayment(Model model, @RequestParam("pdtNm")String pdtNm) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserClient custtomUser = (CustomUserClient)authentication.getPrincipal();
		Client client = custtomUser.getClient();

		orderProduct order = everyService.getOrderProduct(client.getCustId());
		Product product = everyService.getProduct(pdtNm);

		System.out.println(pdtNm);
		System.out.println(order);
		System.out.println(product);
		
		model.addAttribute("order" , order);
		model.addAttribute("product" , product);

		return "every/successPayment";
	}
	
	@PreAuthorize("hasAuthority('custauth')")
	@RequestMapping(value = "/myPage")
	public String everyMypage(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserClient custtomUser = (CustomUserClient)authentication.getPrincipal();
		Client client = custtomUser.getClient();
		System.out.println("멤버쉽갈때 확인 : "+client);
		orderProduct order = everyService.getLastOrderProduct(client.getCustId());
		Product product = everyService.getProductById(order.getPdtId());
		int employeeCount = everyService.getEmployeeCount(client.getCustId());
		if(order!=null) {
			long fileSum = everyService.getCustFileSum(client.getCustId());
			model.addAttribute("fileSum" , fileSum);
		}
		List<orderProduct> orderList= everyService.getOrderProductList(client.getCustId());
		
		List<WorkStatistic> normalList =  everyService.getNormalWorkList(client.getCustId());
		List<WorkStatistic> abnormalList =  everyService.getAbnormalWorkList(client.getCustId());
		Gson gson = new Gson();
		String json1 = gson.toJson(normalList);
		String json2 = gson.toJson(abnormalList);
		
		model.addAttribute("order",order);
		model.addAttribute("product" , product);
		model.addAttribute("employeeCount" , employeeCount);
		model.addAttribute("client" , client);
		model.addAttribute("orderList",orderList);
		model.addAttribute("normalList",json1);
		model.addAttribute("abnormalList",json2);
		
		return "every/myPage";
	}
	
	@RequestMapping(value = "/introduce")
	public String everyIntroduce() {
		return "every/introduce";
	}
	
	@PreAuthorize("hasAuthority('custauth')")
	@RequestMapping(value = "/confirmPw" , method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> getConfirmPass(String password) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserClient custtomUser = (CustomUserClient)authentication.getPrincipal();
		Client client = custtomUser.getClient();
		System.out.println("password: "+password);
		ServiceResult res = null;
		if(client.getCustPw().equals(password)) {
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		

		return new ResponseEntity<ServiceResult>(res,HttpStatus.OK);
	}
	
	@PreAuthorize("hasAuthority('custauth')")
	@RequestMapping(value = "/updateClient" , method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> editClient(Client clientInfo) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserClient custtomUser = (CustomUserClient)authentication.getPrincipal();
		Client client = custtomUser.getClient();
		System.out.println("클라이언트:" + clientInfo);
		ServiceResult res = null;
		res=everyService.updateClient(clientInfo);
		if(res.equals(ServiceResult.OK)) {
			client.setBplcAddr(clientInfo.getBplcAddr());
			client.setBplcDaddr(clientInfo.getBplcDaddr());
			client.setBplcNm(clientInfo.getBplcNm());
			client.setBplcTelno(client.getBplcTelno());
			client.setBplcZip(clientInfo.getBplcZip());
			client.setBrno(clientInfo.getBrno());
			client.setConm(clientInfo.getConm());
			if(clientInfo.isPasswordFlag()) {
				client.setCustPw(clientInfo.getCustPw());
			}
			client.setPicNm(clientInfo.getPicNm());
			client.setPicTelno(clientInfo.getPicTelno());
		}
		

		return new ResponseEntity<ServiceResult>(res,HttpStatus.OK);
	}
}





