package kr.or.everyware.admin.approval.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.document.vo.Document;

public interface IAdminApprovalService {

	List<Document> getAllDocumentList(Document doc);

	ServiceResult editConfig(ApprovalConfig config);

	ApprovalConfig getConfig(String custId);

}
