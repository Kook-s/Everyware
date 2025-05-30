package kr.or.everyware.everyware.facility.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.facility.vo.Car;
import kr.or.everyware.everyware.facility.vo.MeetingRoom;

@Mapper
public interface FacilityMapper {

	List<MeetingRoom> selectMtgRoomList(String custId);

	List<Car> selectCarList(String custId);

}
