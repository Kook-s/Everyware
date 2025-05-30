package kr.or.everyware.util.attachment;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.util.attachment.mapper.AttachMapper;

@Service
public class AttachFileValidate {
	
	@Inject
	AttachMapper mapper;
	
	public ServiceResult validate(String custId, List<MultipartFile> files) {
		
		System.out.println(custId);
		long MaxSize =mapper.getProductInfo(custId);//kb 현재 요금제에 따른 맥스사이즈
		MaxSize = MaxSize*1024*1024*1024;
		long fileSzSum=0;
		for (MultipartFile file : files) {
			fileSzSum+=(long)file.getSize();//kb 지금 넣으려는 파일 사이즈
		}
		
		
		long custFileSzSum=mapper.getCustFileSum(custId);//kb 현재 이번달 모든사원 사용량 사이즈
		
		System.out.println("maxSize: "+MaxSize);
		System.out.println("fileSzSum: "+fileSzSum);
		System.out.println("custFileSzSum: "+custFileSzSum );
		
		
		
		
		
		if(custFileSzSum+fileSzSum>MaxSize) {
			return ServiceResult.FAILED;
		}else {
			return ServiceResult.OK;
		}
		
	}
	
}
