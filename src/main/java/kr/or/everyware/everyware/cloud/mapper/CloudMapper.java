package kr.or.everyware.everyware.cloud.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.cloud.vo.OrderProduct;

@Mapper
public interface CloudMapper {

	public OrderProduct getOrCldSize(String custId);

}
