package kr.or.everyware.everyware.suvy.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.suvy.vo.Suvy;
import kr.or.everyware.everyware.suvy.vo.SuvyAnswer;
import kr.or.everyware.everyware.suvy.vo.SuvyItem;
import kr.or.everyware.everyware.suvy.vo.SuvyPaging;
import kr.or.everyware.everyware.suvy.vo.SuvyParticipants;
import kr.or.everyware.login.vo.Employee;

public interface SuvyService {

	public int getSuvyCount(SuvyPaging<Suvy> suvyPaging);
	public List<Suvy> getSuvyList(SuvyPaging<Suvy> suvyPaging);
	public ServiceResult addSuvy(Suvy suvy);
	public Suvy getOneSuvy(int suvyNo);
	public List<SuvyItem> getSuvyItemList(int suvyNo);
	public ServiceResult delSuvy(int suvyNo);
	public List<Employee> getAllProfileList(Employee employee);
	public ServiceResult voteProccess(List<Integer> siNoList);
	public int revoteProccess(List<Integer> siNoList);
	public List<SuvyAnswer> getSuvyAnswers(Map<String, Object> map);
	public SuvyParticipants getIsSuvyMember(Map<String, Object> map);
	public List<SuvyItem> getSuvyItemListAndCount(int suvyNo);
	public int getSuvyPartCount(int suvyNo);
	public int getSuvySubCount(int suvyNo);
}
