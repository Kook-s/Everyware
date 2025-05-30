package kr.or.everyware.admin.vacation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.vacation.vo.VacItem;

@Mapper
public interface VacItemMapper {

	public List<VacItem> getVacItem(String custId);

	public int addVacItem(VacItem vacItem);

	public int delVacItem(int viNo);

	public int editVacItem(VacItem vacItem);

}
