package kr.or.everyware.everyware.document.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Proxy;

@Mapper
public interface ApprovalMapper {

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

}
