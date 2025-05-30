package kr.or.everyware.everyware.cloud.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.everyware.cloud.mapper.CloudMapper;
import kr.or.everyware.everyware.cloud.service.CloudService;
import kr.or.everyware.everyware.cloud.vo.OrderProduct;

@Service
public class CloudServiceImpl implements CloudService {

	@Inject
	private CloudMapper cloudMapper;
	
	@Override
	public OrderProduct getOrCldSize(String custId) {
		// TODO Auto-generated method stub
		return cloudMapper.getOrCldSize(custId);
	}

}
