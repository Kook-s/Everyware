package kr.or.everyware.util.attachment.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttachMapper {


	long getCustFileSum(String custId);

	long getProductInfo(String custId);

	
}
