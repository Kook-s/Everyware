package kr.or.everyware.admin.approval.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.approval.mapper.AdminApprovalMapper;
import kr.or.everyware.admin.approval.service.IAdminApprovalService;
import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.document.vo.Document;

@Service
public class AdminApprovalServiceImpl implements IAdminApprovalService{

	@Autowired
	private AdminApprovalMapper approvalMapper;

	@Override
	public List<Document> getAllDocumentList(Document doc) {
		return approvalMapper.selectAllDocumentList(doc);
	}

	@Override
	public ServiceResult editConfig(ApprovalConfig config) {
		
		int configCount = approvalMapper.selectConfigCount(config);
		
		int count;
		if(configCount > 0) {
			count = approvalMapper.updateConfig(config);
		}else {
			count = approvalMapper.insertConfig(config);
		}
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ApprovalConfig getConfig(String custId) {
		ApprovalConfig config = approvalMapper.selectConfig(custId);
		return config;
	}
}
