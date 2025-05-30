package kr.or.everyware.everyware.suvy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.suvy.mapper.SuvyMapper;
import kr.or.everyware.everyware.suvy.vo.Suvy;
import kr.or.everyware.everyware.suvy.vo.SuvyAnswer;
import kr.or.everyware.everyware.suvy.vo.SuvyItem;
import kr.or.everyware.everyware.suvy.vo.SuvyPaging;
import kr.or.everyware.everyware.suvy.vo.SuvyParticipants;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;
import sun.util.logging.resources.logging;

@Slf4j
@Service
public class SuvyServiceImpl implements SuvyService {

	@Inject
	private SuvyMapper suvyMapper;
	
	@Override
	public int getSuvyCount(SuvyPaging<Suvy> suvyPaging) {
		return suvyMapper.getSuvyCount(suvyPaging);
	}

	@Override
	public List<Suvy> getSuvyList(SuvyPaging<Suvy> suvyPaging) {
		return suvyMapper.getSuvyList(suvyPaging);
	}

	@Override
	public ServiceResult addSuvy(Suvy suvy) {
		ServiceResult result = null;
		int status = suvyMapper.addSuvy(suvy);
		int status2 = 0;
		System.out.println("서비 추가후");
		System.out.println(suvy);
		List<SuvyItem> suvyItemList = suvy.getSuvyItemList();
		for (SuvyItem suvyItem : suvyItemList) {
			suvyItem.setSuvyNo(suvy.getSuvyNo());
			status2 = suvyMapper.addSuvyItem(suvyItem);
		}
		
		System.out.println("여긴 에드서비");
		System.out.println(suvy);
		
		List<String> idList = suvy.getIdList();
		if(idList!=null && idList.size()>0) {
			for (String empId : idList) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("empId", empId);
				map.put("suvyNo", suvy.getSuvyNo());
				int res=suvyMapper.insertSuvyMember(map);
			}
		}
		
		
		if(status > 0) {
			if(status2 > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public Suvy getOneSuvy(int suvyNo) {
		return suvyMapper.getOneSuvy(suvyNo);
	}

	@Override
	public List<SuvyItem> getSuvyItemList(int suvyNo) {
		return suvyMapper.getSuvyItemList(suvyNo);
	}

	@Override
	public ServiceResult delSuvy(int suvyNo) {
		ServiceResult result = null;
		int res = suvyMapper.deleteAnswers(suvyNo);
		res = suvyMapper.deleteParticipants(suvyNo);
		int status = suvyMapper.delSuvyItem(suvyNo);
		int status2 = suvyMapper.delSuvy(suvyNo);
		

		log.info("status : " + status);
		log.info("status2 : " + status2);
		
		if(status > 0) {
			if(status2 > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else {
			result = ServiceResult.FAILED;
		}
		log.info("result : " + result);
		return result;
	}

	@Override
	public List<Employee> getAllProfileList(Employee employee) {
		// TODO Auto-generated method stub
		return suvyMapper.getAllProfileList(employee);
	}

	@Override
	public ServiceResult voteProccess(List<Integer> siNoList) {
		// TODO Auto-generated method stub
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		if(siNoList==null || siNoList.size()==0) {
			return ServiceResult.FAILED;
		}
		
		SuvyItem selectSuvyItem = suvyMapper.selectSuvyItem(siNoList.get(0));
		Suvy oneSuvy = suvyMapper.getOneSuvy(selectSuvyItem.getSuvyNo());
		Map<String, Object>tmp = new HashMap<String, Object>();
		tmp.put("empId", employee.getEmpId());
		tmp.put("suvyNo", selectSuvyItem.getSuvyNo());
		SuvyParticipants suvyMember = suvyMapper.getIsSuvyMember(tmp);
		if(suvyMember==null||suvyMember.getPartYn().equals("Y")) {
			return ServiceResult.EXIST;
		}
		SuvyItem item = null;
		for (Integer siNo : siNoList) {
			item =  suvyMapper.selectSuvyItem(siNo);
			SuvyAnswer answer = new SuvyAnswer();
			answer.setEmpId(employee.getEmpId());
			answer.setSuvyNo(item.getSuvyNo());
			answer.setSiNo(item.getSiNo());
			int res = suvyMapper.insertSuvyAnswer(answer);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("suvyNo", item.getSuvyNo());
		map.put("empId", employee.getEmpId());
		int res = suvyMapper.updatePartYn(map);
		
		return ServiceResult.getExecutionResult(res);
	}

	@Override
	public int revoteProccess(List<Integer> siNoList) {
		// TODO Auto-generated method stub
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		
		SuvyItem tmpItem = suvyMapper.selectSuvyItem(siNoList.get(0));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empId", employee.getEmpId());
		map.put("suvyNo", tmpItem.getSuvyNo());
		int res = suvyMapper.deleteMyAnswer(map);
		if(res>0) {
			SuvyItem item = null;
			for (Integer siNo : siNoList) {
				item =  suvyMapper.selectSuvyItem(siNo);
				SuvyAnswer answer = new SuvyAnswer();
				answer.setEmpId(employee.getEmpId());
				answer.setSuvyNo(item.getSuvyNo());
				answer.setSiNo(item.getSiNo());
				res = suvyMapper.insertSuvyAnswer(answer);
			}
		}else {
			return 0;
		}
		return tmpItem.getSuvyNo();
	}

	@Override
	public List<SuvyAnswer> getSuvyAnswers(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return suvyMapper.getSuvyAnswers(map);
	}

	@Override
	public SuvyParticipants getIsSuvyMember(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return suvyMapper.getIsSuvyMember(map);
	}

	@Override
	public List<SuvyItem> getSuvyItemListAndCount(int suvyNo) {
		// TODO Auto-generated method stub
		
		List<SuvyItem> suvyItemList = suvyMapper.getSuvyItemList(suvyNo);
		
		for (SuvyItem suvyItem : suvyItemList) {
			int count = suvyMapper.getPickCount(suvyItem);
			suvyItem.setCount(count);
		}
		return suvyItemList;
	}

	@Override
	public int getSuvyPartCount(int suvyNo) {
		// TODO Auto-generated method stub
		return suvyMapper.getSuvyPartCount(suvyNo);
	}

	@Override
	public int getSuvySubCount(int suvyNo) {
		// TODO Auto-generated method stub
		return suvyMapper.getSuvySubCount(suvyNo);
	}


	
}
