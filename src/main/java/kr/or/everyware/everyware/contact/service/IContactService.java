package kr.or.everyware.everyware.contact.service;

import java.util.List;
import java.util.Map;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.contact.vo.AddressBook;
import kr.or.everyware.everyware.contact.vo.ContactInCompany;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Folder;

public interface IContactService {

	List<Department> getEmpByDeptList(String custId);

	List<Folder> getFolderList(String empId);

	ServiceResult addFolder(Folder folder);

	ServiceResult editFolder(Folder folder);

	ServiceResult deleteFolder(int folSn);

	List<AddressBook> getContactsOut(String empId);

	ServiceResult addContactsOut(List<AddressBook> addrList);

	ServiceResult editContactsOut(List<AddressBook> addrList);

	ServiceResult deleteContactsOut(List<Integer> addrSnList);

	List<ContactInCompany> getContactsIn(String empId);

	ServiceResult addContactsIn(List<ContactInCompany> addrList);

	ServiceResult editContactsIn(List<ContactInCompany> addrList);

	ServiceResult deleteContactsIn(List<Integer> addrSnList);

	List<Folder> getContactByFolderList(String custId);

	int getContactsInCount(Map<String, Object> condition);

	int getContactsOutCount(Map<String, Object> condition);

	List<Department> getDeptList(String custId);

}
