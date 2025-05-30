package kr.or.everyware.everyware.facility.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import kr.or.everyware.everyware.facility.service.IFacilityService;
import kr.or.everyware.everyware.facility.vo.Car;
import kr.or.everyware.everyware.facility.vo.MeetingRoom;

@RestController
@RequestMapping("/everyware")
public class FacilityRestController {
	
	@Autowired
	private IFacilityService facilityService;
	@Autowired
	private Gson gson;
	
	@GetMapping("/facilities/meeting-rooms")
	public String getMtgRoomList() {
		String custId = "a001";
		List<MeetingRoom> mtgRoomList = facilityService.getMtgRoomList(custId);
		return "";
	}
	
	@GetMapping("/facilities/cars")
	public String getCarList() {
		String custId = "a001";
		List<Car> carList = facilityService.getCarList(custId);
		return "";
	}
}
