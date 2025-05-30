package kr.or.everyware.everyware.suvy.scheduler;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.or.everyware.everyware.suvy.mapper.SuvyMapper;

@Component
public class scheduler {
	
	@Inject
	SuvyMapper mapper;
	
	@Scheduled(cron="1 0 0 * * *")
	public void test2() {
		
		mapper.updateSuvyStart();
		mapper.updateSuvyEnd();
	}
}
