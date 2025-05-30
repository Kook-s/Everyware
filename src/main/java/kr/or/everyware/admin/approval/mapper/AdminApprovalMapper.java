package kr.or.everyware.admin.approval.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.document.vo.Document;

@Mapper
public interface AdminApprovalMapper {

	List<Document> selectAllDocumentList(Document doc);

	int insertConfig(ApprovalConfig config);

	int selectConfigCount(ApprovalConfig config);

	int updateConfig(ApprovalConfig config);

	ApprovalConfig selectConfigCount(String custId);

	ApprovalConfig selectConfig(String custId);

}
