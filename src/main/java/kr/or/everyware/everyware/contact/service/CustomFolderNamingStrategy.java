package kr.or.everyware.everyware.contact.service;

import java.lang.reflect.Field;

import com.google.gson.FieldNamingStrategy;

public class CustomFolderNamingStrategy implements FieldNamingStrategy {

	@Override
	public String translateName(Field f) {
		String fieldName = f.getName();
        
        if (fieldName.equals("folSn")) {
        	return "id";
        } else if (fieldName.equals("folNm")) {
        	return "text";
        } else if(fieldName.equals("folders")) {
        	return "children";
        }
        return fieldName;
	}

}
