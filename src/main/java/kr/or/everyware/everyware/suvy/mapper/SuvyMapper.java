package kr.or.everyware.everyware.suvy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.suvy.vo.Suvy;
import kr.or.everyware.everyware.suvy.vo.SuvyAnswer;
import kr.or.everyware.everyware.suvy.vo.SuvyItem;
import kr.or.everyware.everyware.suvy.vo.SuvyPaging;
import kr.or.everyware.everyware.suvy.vo.SuvyParticipants;
import kr.or.everyware.login.vo.Employee;

@Mapper
public interface SuvyMapper {

	public int getSuvyCount(SuvyPaging<Suvy> suvyPaging);
	public List<Suvy> getSuvyList(SuvyPaging<Suvy> suvyPaging);
	public int addSuvy(Suvy suvy);
	public Suvy getSuvy(int suvyNo);
	public int addSuvyItem(SuvyItem suvyItem);
	public Suvy getOneSuvy(int suvyNo);
	public List<SuvyItem> getSuvyItemList(int suvyNo);
	public int delSuvy(int suvyNo);
	public int delSuvyItem(int suvyNo);
	public List<Employee> getAllProfileList(Employee employee);
	public int insertSuvyMember(Map<String, Object> map);
	public void updateSuvyStart();
	public void updateSuvyEnd();
	public SuvyItem selectSuvyItem(Integer siNo);
	public int insertSuvyAnswer(SuvyAnswer answer);
	public int updatePartYn(Map<String, Object> map);
	public int deleteMyAnswer(Map<String, Object> map);
	public List<SuvyAnswer> getSuvyAnswers(Map<String, Object> map);
	public SuvyParticipants getIsSuvyMember(Map<String, Object> map);
	public int deleteAnswers(int suvyNo);
	public int deleteParticipants(int suvyNo);
	public int getPickCount(SuvyItem suvyItem);
	public int getSuvyPartCount(int suvyNo);
	public int getSuvySubCount(int suvyNo);
}
