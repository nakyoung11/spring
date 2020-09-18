package com.koreait.matzip.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.koreait.matzip.Const;
import com.koreait.matzip.ViewRef;

@Controller
@RequestMapping("/user")
public class UserController {
	@RequestMapping(value="/login", method= RequestMethod.GET)
	public String login(Model model) {
		model.addAttribute(Const.TITLE,"로그인");
		model.addAttribute(Const.VIEW,"user/login");
		
		return ViewRef.TEMP_DEFAULT;
	}
}
