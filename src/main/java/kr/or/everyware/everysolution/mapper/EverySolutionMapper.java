package kr.or.everyware.everysolution.mapper;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everysolution.vo.Product;
import kr.or.everyware.everysolution.vo.WorkStatistic;
import kr.or.everyware.everysolution.vo.orderProduct;
import kr.or.everyware.everyware.board.vo.Board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.login.vo.Client;

@Mapper
public interface EverySolutionMapper {

	public int addEverySignup(Client client);

	public Client getClient(String custId);

	public int addOrderProduct(orderProduct order);

	public Product getProduct(String pdtNm);

	public orderProduct getOrderProduct(String custId);

	public orderProduct getLastOrderProduct(String custId);

	public Product getProductById(int pdtId);

	public int getEmployeeCount(String custId);

	public long getCustFileSum(String custId);

	public int updateClient(Client clientInfo);

	public List<orderProduct> getOrderProductList(String custId);

	public List<WorkStatistic> getNormalWorkList(String custId);

	public List<WorkStatistic> getAbnormalWorkList(String custId);

	public List<Board> getNoticeFive(String custId);

}
