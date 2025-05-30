package kr.or.everyware.everyware.vacation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.vacation.vo.Vacation;
import kr.or.everyware.everyware.vacation.vo.VacationPaging;

@Mapper
public interface VacationMapper {

	public List<Vacation> getVacationList(VacationPaging<Vacation> vacationPaging);
	public int getVacationCount(VacationPaging<Vacation> vacationPaging);

}
