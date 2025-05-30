package kr.or.everyware.everyware.contact.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.contact.vo.AddressBook;
import kr.or.everyware.everyware.contact.vo.ContactInCompany;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Folder;

@Mapper
public interface ContactMapper {

	public List<Department> selectEmpByDeptList(String custId);

	public List<Folder> selectFolderList(String empId);

	public int insertFolder(Folder folder);

	public int updateFolder(Folder folder);

	public int deleteFolder(int folSn);

	public List<AddressBook> selectContactsOut(String empId);

	public int insertContactsOut(List<AddressBook> addrList);

	public int updateContactsOut(List<AddressBook> addrList);

	public int deleteContactsOut(List<Integer> addrSnList);

	public int insertContactsIn(List<ContactInCompany> addrList);

	public int updateContactsIn(List<ContactInCompany> addrList);

	public int deleteContactsIn(List<Integer> addrSnList);

	public List<Folder> selectContactsInByFolder(String empId);

	public List<ContactInCompany> selectContactsIn(String empId);

	public int selectContactsInCount(Map<String, Object> condition);

	public int selectContactsOutCount(Map<String, Object> condition);

	public List<Department> selectDeptList(String custId);
}
