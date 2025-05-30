package kr.or.everyware.everyware.document.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Document;
import kr.or.everyware.everyware.document.vo.Proxy;
import kr.or.everyware.everyware.document.vo.Template;

@Mapper
public interface DocumentMapper {

	List<Template> selectTemplateList();

	Template selectTemplate(int tmpltCd);

	int insertDocument(Document document);

	int insertApprovalLine(ApprovalLine line);

	int insertDestination(Department dept);
	
	// TODO xml에 쿼리문 추가
	Document selectDocument(int docSn);
	
	// TODO 문서함별 조회 전부 xml에 검색조건 추가
	/* 문서함 목록 조회 */
	List<Document> selectDocumentListWithPending(Document doc);

	List<Document> selectDocumentListWithScheduled(Document doc);

	List<Document> selectDocumentListWithCompleted(Document doc);

	List<Document> selectDocumentListWithDepartment(Document doc);

	List<Document> selectDocumentListWithReference(Document doc);

	List<Document> selectDocumentListWithDrafts(Document doc);

	List<Document> selectDocumentListWithTemp(Document doc);

	List<Document> selectDocumentListWithScraps(Document doc);

	List<Document> selectDocumentListWithShared(Document doc);
	

	
	int selectDocumentCountWithConfig(ApprovalConfig config);

	List<ApprovalLine> selectMyPermission(Map<String, Object> map);

	int insertScrapDocument(Map<String, Object> map);

	int deleteScrapDocument(Map<String, Object> map);

	int updateDocumentStatusToCollect(int aprvSn);

	int insertShareDocument(Document document);

	List<Template> selectTemplateRecentlyUsed(String empId);

	int selectCountDocumentListWithScheduled(String empId);

	int selectCountDocumentListWithCompleted(String empId);

	List<Document> selectDocumentListWithNotRead(String empId);

	int selectCountDocumentListWithViewer(String empId);

	int selectCountDocumentListWithReference(String empId);

	List<Document> selectDocumentListWithOnProcess(String empId);

	int selectCountDocumentWithConfirmed(String empId);

	int selectCountDocumentWithRejected(String empId);

	List<Document> selectDocumentListWithDepartmentRecently5(String empId);
	
	
	

	int insertProxy(Proxy proxy);

	List<Proxy> selectProxyList(String empId);

	int deleteProxy(int proxyId);

	int updateApprovalLine(ApprovalLine aprvLine);

	void insertDcrbApprovalLine(ApprovalLine aprvLine);

	void updateDelegateWithProxy(ApprovalLine aprvLine);

	void updateDelegateWithApproval(ApprovalLine aprvLine);

	void updateApprovalLineStatus(ApprovalLine aprvLine);

	void updateDocumentFinalConfirm(ApprovalLine aprvLine);

	int selectForIsFinalCheck(ApprovalLine aprvLine);

	void updateNextApproverStatus(ApprovalLine aprvLine);

	int selectForIsFirstCheck(ApprovalLine aprvLine);

	void updateDocumentFirstConfirm(ApprovalLine aprvLine);

	void updateDocumentFinalReject(ApprovalLine aprvLine);

	int updateAprvNo(Document doc);

}
