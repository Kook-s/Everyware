package kr.or.everyware.everyware.document.service;

import java.util.List;
import java.util.Map;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Document;
import kr.or.everyware.everyware.document.vo.Proxy;
import kr.or.everyware.everyware.document.vo.Template;
import kr.or.everyware.everyware.vacation.vo.Vacation;

public interface IDocumentService {

	List<Template> getTemplateList();

	Template getTemplate(int tmpltCd);

	ServiceResult addDocument(Document document, ApprovalConfig config);

	List<Document> getDocumentListWithPending(Document doc);

	List<Document> getDocumentListWithScheduled(Document doc);

	List<Document> getDocumentListWithCompleted(Document doc);

	List<Document> getDocumentListWithDepartment(Document doc);

	List<Document> getDocumentListWithReference(Document doc);

	List<Document> getDocumentListWithDrafts(Document doc);

	List<Document> getDocumentListWithTemp(Document doc);

	List<Document> getDocumentListWithScraps(Document doc);

	List<Document> getDocumentListWithShared(Document doc);

	Document getDocument(int docSn);

	List<ApprovalLine> getMyPermission(Map<String, Object> map);

	ServiceResult addScrapDocument(Map<String, Object> map);

	ServiceResult deleteScrapDocument(Map<String, Object> map);

	ServiceResult collectDocument(int aprvSn);

	ServiceResult addShareDocument(Document document);

	List<Template> getTemplateRecentlyUsed(String empId);

	int getCountDocumentListWithScheduled(String empId);

	int getCountDocumentListWithCompleted(String empId);

	List<Document> getDocumentListWithNotRead(String empId);

	int getCountDocumentListWithViewer(String empId);

	int getCountDocumentListWithReference(String empId);
	
	List<Document> getDocumentListWithOnProcess(String empId);

	int getCountDocumentWithConfirmed(String empId);

	int getCountDocumentWithRejected(String empId);

	List<Document> getDocumentListWithDepartmentRecently5(String empId);
	
	ServiceResult addProxy(List<Proxy> proxyList);

	List<Proxy> getProxyList(String empId);

	ServiceResult deleteProxy(int proxyId);

	ServiceResult confirmProcess(ApprovalLine aprvLine);

	String createAprvNo(Document doc, ApprovalConfig config);

	ServiceResult updateAprvNo(Document doc);
	
	
}
