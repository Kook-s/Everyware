package kr.or.everyware.everyware.document.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Proxy;

public interface IApprovalService {

	ServiceResult addProxy(List<Proxy> proxyList);

	List<Proxy> getProxyList(String empId);

	ServiceResult deleteProxy(int proxyId);

	ServiceResult confirmProcess(ApprovalLine aprvLine);

}
