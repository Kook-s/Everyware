package kr.or.everyware.util;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.or.everyware.everyware.contact.service.CustomEmpNamingStrategy;
import kr.or.everyware.everyware.contact.service.CustomFolderNamingStrategy;

@Configuration
public class GsonConfig {
	
	@Bean
	public Gson gson() {
        return new Gson();
    }
	
	@Bean
	public GsonBuilder empGsonBuilder() {
		return new GsonBuilder().setFieldNamingStrategy(new CustomEmpNamingStrategy());
	}
	
	@Bean
	public GsonBuilder folderGsonBuilder() {
		return new GsonBuilder().setFieldNamingStrategy(new CustomFolderNamingStrategy());
	}
}
