package kr.or.everyware.everyware.facility.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/everyware")
public class FacilityController {
	
	@GetMapping("/reservation")
	public String goReservation() {
		return "/everyware/facility/reservation";
	}
}
