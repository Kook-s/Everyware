package kr.or.everyware.login.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	
	@RequestMapping(value = "/everyware/login", method = RequestMethod.GET)
	public String tesasfasft(Locale locale, Model model) {
		return "login/everywareLogin";
	}

	@RequestMapping(value = "/everysolution/login", method = RequestMethod.GET)
	public String sasafasfd(Locale locale, Model model) {

		return "login/everySolutionLogin";
	}
	
	
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String sasafassfsfd(Locale locale, Model model) {
		return "home";
	}
	
	
	@PreAuthorize("hasAuthority('default')")
	@RequestMapping(value = "/everyware/test", method = RequestMethod.GET)
	public String asd(Locale locale, Model model) {
		return "login/test";
	}
	@PreAuthorize("hasAuthority('custauth')")
	@RequestMapping(value = "/everysolution/test", method = RequestMethod.GET)
	public String asfsd(Locale locale, Model model) {
		return "login/test";
	}
}
