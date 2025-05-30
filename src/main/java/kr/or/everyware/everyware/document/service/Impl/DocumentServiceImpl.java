package kr.or.everyware.everyware.document.service.Impl;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.document.mapper.DocumentMapper;
import kr.or.everyware.everyware.document.service.IDocumentService;
import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Document;
import kr.or.everyware.everyware.document.vo.Proxy;
import kr.or.everyware.everyware.document.vo.Template;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DocumentServiceImpl implements IDocumentService{
	
	@Autowired
	private DocumentMapper documentMapper;

	@Override
	public List<Template> getTemplateList() {
		List<Template> list = documentMapper.selectTemplateList();
		return list;
	}

	@Override
	public Template getTemplate(int tmpltCd) {
		Template template = documentMapper.selectTemplate(tmpltCd);
		return template;
	}

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public ServiceResult addDocument(Document document, ApprovalConfig config) {
		log.info(config.toString());
		
		String numberingTime = config.getNumberingTime();
		if(numberingTime.equals("wrote")) {
			String aprvNo = createAprvNo(document, config);
			
//			String condition = createNumberingCondition(config, document);
//			
//			log.info(condition);
//			config.setLikeCondition(condition);
//			
//			log.info(config.toString());
//			
//			int count = documentMapper.selectDocumentCountWithConfig(config);
//			
//			String seq = "";
//			if(count > 0) {
//				seq = String.format("%04d", count + 1);
//			}else {
//				seq = "0001";
//			}
//			
//			String aprvNo = condition.replace("%", seq);
			document.setAprvNo(aprvNo);
		}
		
		
		int cntDoc = documentMapper.insertDocument(document);
		if(!(cntDoc > 0)) {
			throw new IllegalArgumentException();
		}
		
		for(ApprovalLine line : document.getApprovalLine()) {
			line.setAprvSn(document.getAprvSn());
			int cntAppr = documentMapper.insertApprovalLine(line);
			if(!(cntAppr > 0)) {
				throw new IllegalArgumentException();
			}
		}
		
		for(Department dept : document.getDestinations()) {
			dept.setAprvSn(document.getAprvSn());
			int cntDept = documentMapper.insertDestination(dept);
			if(!(cntDept > 0)) {
				throw new IllegalArgumentException();
			}
		}
		return ServiceResult.OK;
	}
	
	public String createAprvNo(Document doc, ApprovalConfig config) {
		
		String condition = createNumberingCondition(config, doc);
		
		log.info(condition);
		config.setLikeCondition(condition);
		
		log.info(config.toString());
		
		int count = documentMapper.selectDocumentCountWithConfig(config);
		
		String seq = "";
		if(count > 0) {
			seq = String.format("%04d", count + 1);
		}else {
			seq = "0001";
		}
		
		String aprvNo = condition.replace("%", seq);
		return aprvNo;
	}

	@Override
	public List<Document> getDocumentListWithPending(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithPending(doc);
		return docList;
	}

	@Override
	public List<Document> getDocumentListWithScheduled(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithScheduled(doc);
		return docList;
	}

	@Override
	public List<Document> getDocumentListWithCompleted(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithCompleted(doc);
		return docList;
	}

	@Override
	public List<Document> getDocumentListWithDepartment(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithDepartment(doc);
		return docList;
	}

	@Override
	public List<Document> getDocumentListWithReference(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithReference(doc);
		return docList;
	}

	@Override
	public List<Document> getDocumentListWithDrafts(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithDrafts(doc);
		return docList;
	}

	@Override
	public List<Document> getDocumentListWithTemp(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithTemp(doc);
		return docList;
	}

	@Override
	public List<Document> getDocumentListWithScraps(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithScraps(doc);
		return docList;
	}

	@Override
	public List<Document> getDocumentListWithShared(Document doc) {
		List<Document> docList = documentMapper.selectDocumentListWithShared(doc);
		return docList;
	}

	@Override
	public Document getDocument(int docSn) {
		Document doc = documentMapper.selectDocument(docSn);
		return doc;
	}

	public String createNumberingCondition(ApprovalConfig config, Document document) {
		String conm = document.getConm();
		String deptNm = document.getDeptNm();
		String tmpltNm = document.getTmpltNm();
		log.info("tmpltNm: " + tmpltNm);
		
        LocalDate currentDate = LocalDate.now();
        String year = currentDate.getYear() + "";
        String month = currentDate.getMonthValue() + "";
        String day = currentDate.getDayOfMonth() + "";
		
		String reg = config.getNumberingReg();
		log.info("reg: " + reg);
		String aprvNo = reg.replace("{company}", conm).replace("{dept}", deptNm).replace("{tmplt}", tmpltNm)
			.replace("{year}", year).replace("{month}", month).replace("{day}", day).replace("{seq}", "%");
		
		return aprvNo;
	}

	public int getSequenceNumber(ApprovalConfig config) {
		int count = documentMapper.selectDocumentCountWithConfig(config);
		return count;
	}

	@Override
	public List<ApprovalLine> getMyPermission(Map<String, Object> map) {
		List<ApprovalLine> permission = documentMapper.selectMyPermission(map);
		return permission;
	}

	@Override
	public ServiceResult addScrapDocument(Map<String, Object> map) {
		int count = documentMapper.insertScrapDocument(map);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult deleteScrapDocument(Map<String, Object> map) {
		int count = documentMapper.deleteScrapDocument(map);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult collectDocument(int aprvSn) {
		int count = documentMapper.updateDocumentStatusToCollect(aprvSn);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult addShareDocument(Document document) {
		int count = documentMapper.insertShareDocument(document);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public List<Template> getTemplateRecentlyUsed(String empId) {
		List<Template> list = documentMapper.selectTemplateRecentlyUsed(empId);
		return list;
	}

	@Override
	public int getCountDocumentListWithScheduled(String empId) {
		int cnt = documentMapper.selectCountDocumentListWithScheduled(empId);
		return cnt;
	}

	@Override
	public int getCountDocumentListWithCompleted(String empId) {
		int cnt = documentMapper.selectCountDocumentListWithCompleted(empId);
		return cnt;
	}

	@Override
	public List<Document> getDocumentListWithNotRead(String empId) {
		List<Document> list = documentMapper.selectDocumentListWithNotRead(empId);
		return list;
	}

	@Override
	public int getCountDocumentListWithViewer(String empId) {
		int cnt = documentMapper.selectCountDocumentListWithViewer(empId);
		return cnt;
	}

	@Override
	public int getCountDocumentListWithReference(String empId) {
		int cnt = documentMapper.selectCountDocumentListWithReference(empId);
		return cnt;
	}

	@Override
	public List<Document> getDocumentListWithOnProcess(String empId) {
		List<Document> list = documentMapper.selectDocumentListWithOnProcess(empId);
		return list;
	}

	@Override
	public int getCountDocumentWithConfirmed(String empId) {
		int cnt = documentMapper.selectCountDocumentWithConfirmed(empId);
		return cnt;
	}

	@Override
	public int getCountDocumentWithRejected(String empId) {
		int cnt = documentMapper.selectCountDocumentWithRejected(empId);
		return cnt;
	}

	@Override
	public List<Document> getDocumentListWithDepartmentRecently5(String empId) {
		List<Document> list = documentMapper.selectDocumentListWithDepartmentRecently5(empId);
		return null;
	}
	

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public ServiceResult addProxy(List<Proxy> proxyList) {
		
		for(Proxy proxy : proxyList) {
			int count = documentMapper.insertProxy(proxy);
			if(!(count > 0)) {
				throw new IllegalArgumentException();
			}
		}
		
		return ServiceResult.OK;
	}

	@Override
	public List<Proxy> getProxyList(String empId) {
		List<Proxy> list = documentMapper.selectProxyList(empId);
		return list;
	}

	@Override
	public ServiceResult deleteProxy(int proxyId) {
		int count = documentMapper.deleteProxy(proxyId);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public ServiceResult confirmProcess(ApprovalLine aprvLine) {
		log.info("결재 서비스 왔음");
		log.info(aprvLine.toString());
		/* 승인/합의일 때 */
		
		// if 대결
		if(aprvLine.getAprvSeCd() == 1 && aprvLine.getSubYn().equals("Y")) {
			log.info("대결");
			
			// 대결자명으로 결재라인 insert
			documentMapper.insertDcrbApprovalLine(aprvLine);
			
			// 기존 결재자 대결위임처리
			documentMapper.updateDelegateWithProxy(aprvLine);
			
		}else {
			log.info("대결아님");
			// 본인 결재 상태코드 변경
			documentMapper.updateApprovalLineStatus(aprvLine);
		}
	
		// if 반려
		if(aprvLine.getPrgrsSttsCd() == 4) {
			// 문서 완전 반려처리
			documentMapper.updateDocumentFinalReject(aprvLine);
			return null;
		}
		
		// if 전결
		if(aprvLine.getAprvSeCd() == 1 && aprvLine.getDcrbYn().equals("Y")) {
			log.info("전결");
			// 이후 결재자 전부 전결위임처리
			documentMapper.updateDelegateWithApproval(aprvLine);
			
			// 문서 최종 승인처리
			documentMapper.updateDocumentFinalConfirm(aprvLine);
		}
		
		// 첫번째 결재자인지 확인
		int isFirst = documentMapper.selectForIsFirstCheck(aprvLine);
		
		// if 첫번째 결재자
		if(!(isFirst > 0)) {
			log.info("첫번째 결재자");
			// 문서 상태 진행으로 변경
			documentMapper.updateDocumentFirstConfirm(aprvLine);
		}
		
		
		// 최종 결재자인지 확인
		int isFinal = documentMapper.selectForIsFinalCheck(aprvLine);
		
		// if 최종 결재자
		if(isFinal == 0) {
			log.info("최종 결재자");
			// 문서 최종 승인처리
			documentMapper.updateDocumentFinalConfirm(aprvLine);
			
		}else {
			log.info("최종 결재자 아님");
			// 다음 결재자 상태코드 변경
			documentMapper.updateNextApproverStatus(aprvLine);
		}
		
		//TODO 채번
		
		return null;
	}

	@Override
	public ServiceResult updateAprvNo(Document doc) {
		int count = documentMapper.updateAprvNo(doc);
		return ServiceResult.getExecutionResult(count);
	}
}
