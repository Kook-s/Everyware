package kr.or.everyware.security;

import java.io.IOException;
import java.net.InetAddress;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.maxmind.geoip2.model.CityResponse;
import com.maxmind.geoip2.model.CountryResponse;

import kr.or.everyware.login.mapper.LoginMapper;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.LoginLog;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	
	private static final Logger log = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	@Inject
	LoginMapper mapper;
	@Inject
	GeoReader reader;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		
		log.info("[로그인 성공!] onAuthenticationSuccess() 실행...!");
		Object customUser = (Object)authentication.getPrincipal();

        if(customUser instanceof CustomUserClient) {
        	CustomUserClient client = (CustomUserClient)customUser;
        	setDefaultTargetUrl("/everyware/admin/management");	// 나중에 관리자 메인페이지로 이동하도록 변경해야함
        									// 그룹웨어에 클라이언트가 로그인한 경우 바로 관리자페이지 이동
        }else {
        	CustomUserEmployee employee = (CustomUserEmployee)customUser;
        	//사원일 경우에만 접속 ip를 기록하겠음
        	String clientIp = request.getRemoteAddr();

            // 클라이언트의 브라우저 정보 얻기
            String userAgent = request.getHeader("User-Agent");
            InetAddress inetAddress = InetAddress.getByName(clientIp);
            //사설 ip주소이기 때문에 공공ip주소 리스트 데이터베이스에 해당 주소가 없음
            // CountryResponse country = reader.country(inetAddress);
            
            //따라서 시연용 조건문
            
            String country="";
            if(clientIp.contains("192.168")) {
            	country="Korea";
            }
            if(clientIp.contains("0:0")) {
            	country="Korea";
            }
            LoginLog loginLog = new LoginLog();
            loginLog.setEmpId(employee.getEmployee().getEmpId());
            loginLog.setLgnArea(country);
            loginLog.setLgnBro(parseBrowser(userAgent));
            loginLog.setLgnDeptNm(employee.getEmployee().getEmpName());
            loginLog.setLgnIpAddr(clientIp);
            mapper.inserLoginLog(loginLog);
        }
		
		
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
	
	
	
	public static String parseBrowser(String userAgentString) {
        if (userAgentString.contains("Edg")) {
            return "Microsoft Edge";
        } else if (userAgentString.contains("Chrome")) {
            return "Google Chrome";
        } else if (userAgentString.contains("Safari")) {
            return "Apple Safari";
        } else if (userAgentString.contains("Firefox")) {
            return "Mozilla Firefox";
        } else if (userAgentString.contains("Opera")) {
            return "Opera";
        } else if (userAgentString.contains("Trident")) {
            return "Internet Explorer";
        } else {
            return "Unknown Browser";
        }
    }
}
