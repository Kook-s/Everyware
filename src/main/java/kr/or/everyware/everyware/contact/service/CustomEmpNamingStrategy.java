package kr.or.everyware.everyware.contact.service;

import java.lang.reflect.Field;

import com.google.gson.FieldNamingStrategy;

public class CustomEmpNamingStrategy implements FieldNamingStrategy {

	@Override
	public String translateName(Field f) {
		String fieldName = f.getName();
        
        if (fieldName.equals("empId")) {
        	return "id";
        } else if (fieldName.equals("empName")) {
        	return "empName";
        } else if(fieldName.equals("employees")) {
        	return "children";
        } else if(fieldName.equals("empProfile")) {
        	return "icon";
        } else if(fieldName.equals("deptNm")){
        	return "deptNm";
        } else if(fieldName.equals("jbgdNm")){
        	return "jbgdNm";
        }
        return fieldName;
	}

}
