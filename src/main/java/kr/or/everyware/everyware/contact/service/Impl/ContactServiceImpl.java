package kr.or.everyware.everyware.contact.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.contact.mapper.ContactMapper;
import kr.or.everyware.everyware.contact.service.IContactService;
import kr.or.everyware.everyware.contact.vo.AddressBook;
import kr.or.everyware.everyware.contact.vo.ContactInCompany;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Folder;

@Service
public class ContactServiceImpl implements IContactService{
	
	@Autowired
	private ContactMapper contactMapper;
	
	@Override
	public List<Department> getEmpByDeptList(String custId){
		List<Department> deptList = contactMapper.selectEmpByDeptList(custId);
		return deptList;
	}
	
	@Override
	public List<Folder>	getFolderList(String empId) {
		List<Folder> folderList = contactMapper.selectFolderList(empId);
		return folderList;
	}

	@Override
	public ServiceResult addFolder(Folder folder) {
		int count = contactMapper.insertFolder(folder);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult editFolder(Folder folder) {
		int count = contactMapper.updateFolder(folder);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult deleteFolder(int folSn) {
		int count = contactMapper.deleteFolder(folSn);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public List<AddressBook> getContactsOut(String empId) {
		List<AddressBook> addrList = contactMapper.selectContactsOut(empId);
		return addrList;
	}

	@Override
	public ServiceResult addContactsOut(List<AddressBook> addrList) {
		int count = contactMapper.insertContactsOut(addrList);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult editContactsOut(List<AddressBook> addrList) {
		int count = contactMapper.updateContactsOut(addrList);
		System.out.println("count::::::::::::: " + count);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult deleteContactsOut(List<Integer> addrSnList) {
		int count = contactMapper.deleteContactsOut(addrSnList);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public List<ContactInCompany> getContactsIn(String empId) {
		List<ContactInCompany> addrList = contactMapper.selectContactsIn(empId);
		return addrList;
	}

	@Override
	public ServiceResult addContactsIn(List<ContactInCompany> addrList) {
		int count = contactMapper.insertContactsIn(addrList);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult editContactsIn(List<ContactInCompany> addrList) {
		int count = contactMapper.updateContactsIn(addrList);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public ServiceResult deleteContactsIn(List<Integer> addrSnList) {
		int count = contactMapper.deleteContactsIn(addrSnList);
		return ServiceResult.getExecutionResult(count);
	}

	@Override
	public List<Folder> getContactByFolderList(String empId) {
		List<Folder> folderList = contactMapper.selectContactsInByFolder(empId);
		return folderList;
	}

	@Override
	public int getContactsInCount(Map<String, Object> condition) {
		int count = contactMapper.selectContactsInCount(condition);
		return count;
	}

	@Override
	public int getContactsOutCount(Map<String, Object> condition) {
		int count = contactMapper.selectContactsOutCount(condition);
		return count;
	}

	@Override
	public List<Department> getDeptList(String custId) {
		List<Department> deptList = contactMapper.selectDeptList(custId);
		return deptList;
	}
}
