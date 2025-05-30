package kr.or.everyware.util;

import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

public class ExcelDownload<T> {
	// 템플릿에 따라 설정...
	// row 시작지점은 통일하여 지정하기
	private static final int ROW_START_INDEX = 0;
	private static final int COLUMN_START_INDEX = 0;

	private Workbook workbook;
	private Sheet sheet;
	private String fileName;
	private List<Field> fields;

	// 생성자
	public ExcelDownload(List<T> list, Class<?> type) throws IllegalArgumentException, IllegalAccessException {
		this.workbook = new SXSSFWorkbook();
		settingHeaders(type);
		renderExcel(list);
		settingFileName(type);
	}

	// 필드 헤더 설정하기
	private void settingHeaders(Class<?> type) {
		fields = getFieldsWithAnnotation(type, ExcelFieldName.class);
		fields.sort((f1, f2) -> {
			ExcelFieldName field1Annotation = f1.getAnnotation(ExcelFieldName.class);
			ExcelFieldName field2Annotation = f2.getAnnotation(ExcelFieldName.class);
			return Integer.compare(field1Annotation.order(), field2Annotation.order());
		});
	}

	// 엑셀 생성하기
	private void renderExcel(List<T> list) throws IllegalArgumentException, IllegalAccessException {
		sheet = workbook.createSheet();
		renderHeaders(sheet, ROW_START_INDEX, COLUMN_START_INDEX);

		if (list.isEmpty()) {
			return;
		}

		int rowIndex = ROW_START_INDEX + 1;
		for (Object renderedData : list) {
			renderBody(renderedData, rowIndex++, COLUMN_START_INDEX);
		}
	}

	// 필드 헤더 만들기
	private void renderHeaders(Sheet sheet, int rowStartIndex, int columnStartIndex) {
		Row headerRow = sheet.createRow(rowStartIndex);
		int columnIndex = columnStartIndex;
		for (Field field : fields) {
			ExcelFieldName annotation = field.getAnnotation(ExcelFieldName.class);
			String columnName = annotation.value();
			headerRow.createCell(columnIndex).setCellValue(columnName);
			columnIndex++;
		}
	}

	// 내용 만들기
	private void renderBody(Object data, int rowIndex, int columnStartIndex) throws IllegalArgumentException, IllegalAccessException {
		Row bodyRow = sheet.createRow(rowIndex);
		int columnIndex = columnStartIndex;
		for (Field field : fields) {
			field.setAccessible(true);
			Object value = field.get(data);
			Cell cell = bodyRow.createCell(columnIndex++);
			setCellValue(cell, value);
		}
	}

	// 타입에 따른 셀 설정
	private void setCellValue(Cell cell, Object value) {
		if (value == null) {
			cell.setCellValue("");
		} else if (value instanceof String) {
			cell.setCellValue((String) value);
		} else if (value instanceof Integer) {
			cell.setCellValue((Integer) value);
		} else if (value instanceof Double) {
			cell.setCellValue((Double) value);
		} else if (value instanceof Boolean) {
			cell.setCellValue((Boolean) value);
		}
	}

	// 어노테이션 설정된 필드 값 가져오기
	private List<Field> getFieldsWithAnnotation(Class<?> clazz, Class<? extends Annotation> annotationClass) {
		List<Field> annotatedFields = new ArrayList<>();
		for (Field field : clazz.getDeclaredFields()) {
			if (field.isAnnotationPresent(annotationClass)) {
				annotatedFields.add(field);
			}
		}
		return annotatedFields;
	}
	
	// 어노테이션 설정된 파일이름 가져오기
	private void settingFileName(Class<?> type) {
		ExcelFileName annotation = type.getAnnotation(ExcelFileName.class);
		String fileName = (annotation != null) ? annotation.value() : "output";
		fileName += ".xlsx";
		this.fileName = fileName;
	}
	
	// 실제 호출하는 파일 작성 메소드
	public void write(HttpServletResponse response) throws IOException {
		String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8.toString());
		
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment;filename=" + encodedFileName);
		
		ServletOutputStream stream = response.getOutputStream();
		
		workbook.write(stream);
		workbook.close();
		stream.flush();
		stream.close();
	}
}
