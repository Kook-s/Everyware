package kr.or.everyware;

import java.util.List;

public enum ServiceResult {
	OK,FAILED,EXIST,NOTEXIST;
	
	public static ServiceResult getExecutionResult(int count) {
		if(count > 0) {
			return OK;
		}else {
			return FAILED; 
		}
	}
	
	public static ServiceResult getExistenceResult(int count) {
		if(count > 0) {
			return EXIST;
		}else {
			return NOTEXIST; 
		}
	}
	
	public static ServiceResult getExistenceResult(List<?> list) {
		if(list.size() > 0) {
			return EXIST;
		}else {
			return NOTEXIST; 
		}
	}
}
