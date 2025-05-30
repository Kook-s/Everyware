package kr.or.everyware.everyware.document.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.document.mapper.ApprovalMapper;
import kr.or.everyware.everyware.document.service.IApprovalService;
import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Proxy;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ApprovalServiceImpl implements IApprovalService {
	
	@Autowired
	private ApprovalMapper approvalMapper;

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public ServiceResult addProxy(List<Proxy> proxyList) {
		
		for(Proxy proxy : proxyList) {
			int count = approvalMapper.insertProxy(proxy);
			if(!(count > 0)) {
				throw new IllegalArgumentException();
			}
		}
		
		return ServiceResult.OK;
	}

	@Override
	public List<Proxy> getProxyList(String empId) {
		List<Proxy> list = approvalMapper.selectProxyList(empId);
		return list;
	}

	@Override
	public ServiceResult deleteProxy(int proxyId) {
		int count = approvalMapper.deleteProxy(proxyId);
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
			approvalMapper.insertDcrbApprovalLine(aprvLine);
			
			// 기존 결재자 대결위임처리
			approvalMapper.updateDelegateWithProxy(aprvLine);
			
		}else {
			log.info("대결아님");
			// 본인 결재 상태코드 변경
			approvalMapper.updateApprovalLineStatus(aprvLine);
		}
	
		// if 반려
		if(aprvLine.getPrgrsSttsCd() == 4) {
			// 문서 완전 반려처리
			approvalMapper.updateDocumentFinalReject(aprvLine);
			return null;
		}
		
		// if 전결
		if(aprvLine.getAprvSeCd() == 1 && aprvLine.getDcrbYn().equals("Y")) {
			log.info("전결");
			// 이후 결재자 전부 전결위임처리
			approvalMapper.updateDelegateWithApproval(aprvLine);
			
			// 문서 최종 승인처리
			approvalMapper.updateDocumentFinalConfirm(aprvLine);
		}
		
		// 첫번째 결재자인지 확인
		int isFirst = approvalMapper.selectForIsFirstCheck(aprvLine);
		
		// if 첫번째 결재자
		if(!(isFirst > 0)) {
			log.info("첫번째 결재자");
			// 문서 상태 진행으로 변경
			approvalMapper.updateDocumentFirstConfirm(aprvLine);
		}
		
		
		// 최종 결재자인지 확인
		int isFinal = approvalMapper.selectForIsFinalCheck(aprvLine);
		
		// if 최종 결재자
		if(isFinal == 0) {
			log.info("최종 결재자");
			// 문서 최종 승인처리
			approvalMapper.updateDocumentFinalConfirm(aprvLine);
			
		}else {
			log.info("최종 결재자 아님");
			// 다음 결재자 상태코드 변경
			approvalMapper.updateNextApproverStatus(aprvLine);
		}
		
		//TODO 채번
		
		return null;
	}
}
