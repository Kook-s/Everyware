package kr.or.everyware.everyware.document.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.vacation.vo.Vacation;

@Mapper
public interface TemplateMapper {

	List<Vacation> selectVacationItems(String custId);

}
