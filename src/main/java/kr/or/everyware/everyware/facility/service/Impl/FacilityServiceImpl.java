package kr.or.everyware.everyware.facility.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.everyware.everyware.facility.mapper.FacilityMapper;
import kr.or.everyware.everyware.facility.service.IFacilityService;
import kr.or.everyware.everyware.facility.vo.Car;
import kr.or.everyware.everyware.facility.vo.MeetingRoom;

@Service
public class FacilityServiceImpl implements IFacilityService {
	
	@Autowired
	private FacilityMapper facilityMapper;

	@Override
	public List<MeetingRoom> getMtgRoomList(String custId) {
		List<MeetingRoom> mtgRoomList = facilityMapper.selectMtgRoomList(custId);
		return mtgRoomList;
	}

	@Override
	public List<Car> getCarList(String custId) {
		List<Car> carList = facilityMapper.selectCarList(custId);
		return carList;
	}

}
