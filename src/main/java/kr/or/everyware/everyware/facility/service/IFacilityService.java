package kr.or.everyware.everyware.facility.service;

import java.util.List;

import kr.or.everyware.everyware.facility.vo.Car;
import kr.or.everyware.everyware.facility.vo.MeetingRoom;

public interface IFacilityService {

	List<MeetingRoom> getMtgRoomList(String custId);

	List<Car> getCarList(String custId);

}
