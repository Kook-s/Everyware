package kr.or.everyware.everysolution.service;

import java.util.List;

import javax.inject.Inject;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everysolution.vo.Product;
import kr.or.everyware.everysolution.vo.WorkStatistic;
import kr.or.everyware.everysolution.vo.orderProduct;
import kr.or.everyware.everyware.board.vo.Board;

import org.springframework.stereotype.Service;

import kr.or.everyware.everysolution.mapper.EverySolutionMapper;
import kr.or.everyware.login.vo.Client;

@Service
public class EverySolutionServiceImpl implements IEverySolutionService{

	@Inject
	private EverySolutionMapper everySolutionMapper;
	
	@Override
	public int addEverySignup(Client client) {
		return everySolutionMapper.addEverySignup(client);
	}

	@Override
	public ServiceResult addOrderProduct(orderProduct order) {
		ServiceResult res = null;
		int result = everySolutionMapper.addOrderProduct(order);

		if(result >0){
			res=ServiceResult.OK;
		}else{
			res=ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public Product getProduct(String pdtNm) {
		return everySolutionMapper.getProduct(pdtNm);
	}

	@Override
	public orderProduct getOrderProduct(String custId) {
		return everySolutionMapper.getOrderProduct(custId);
	}

	@Override
	public orderProduct getLastOrderProduct(String custId) {
		// TODO Auto-generated method stub
		return everySolutionMapper.getLastOrderProduct(custId);
	}

	@Override
	public Product getProductById(int pdtId) {
		// TODO Auto-generated method stub
		return everySolutionMapper.getProductById(pdtId);
	}

	@Override
	public int getEmployeeCount(String custId) {
		// TODO Auto-generated method stub
		return everySolutionMapper.getEmployeeCount(custId);
	}

	@Override
	public long getCustFileSum(String custId) {
		// TODO Auto-generated method stub
		return everySolutionMapper.getCustFileSum(custId);
	}

	@Override
	public ServiceResult updateClient(Client clientInfo) {
		// TODO Auto-generated method stub
		return ServiceResult.getExecutionResult(everySolutionMapper.updateClient(clientInfo));
	}

	@Override
	public List<orderProduct> getOrderProductList(String custId) {
		// TODO Auto-generated method stub
		return everySolutionMapper.getOrderProductList(custId);
	}

	@Override
	public List<WorkStatistic> getNormalWorkList(String custId) {
		// TODO Auto-generated method stub
		return everySolutionMapper.getNormalWorkList(custId);
	}

	@Override
	public List<WorkStatistic> getAbnormalWorkList(String custId) {
		// TODO Auto-generated method stub
		return everySolutionMapper.getAbnormalWorkList(custId);
	}

	@Override
	public List<Board> getNoticeFive(String custId) {
		// TODO Auto-generated method stub
		return everySolutionMapper.getNoticeFive(custId);
	}


}
