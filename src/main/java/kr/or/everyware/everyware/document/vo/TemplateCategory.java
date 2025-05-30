package kr.or.everyware.everyware.document.vo;

import java.util.List;

import lombok.Data;

@Data
public class TemplateCategory {
	private String clsfNm;
	private List<Template> templates;
}
