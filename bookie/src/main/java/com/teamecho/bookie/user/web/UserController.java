package com.teamecho.bookie.user.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.domain.UserCommand;
import com.teamecho.bookie.user.service.UserService;

@Controller
@RequestMapping("/user/add_user")
public class UserController {

	@Autowired
	private UserService userService;

	@GetMapping
	public String addUserform(Model model) {
		model.addAttribute("user", new UserCommand());
		return "/user/add_user";
	}

	@ModelAttribute("emailProviderList")
	public List<EmailProvider> getEmailProviderList() {
		List<EmailProvider> list = new ArrayList<EmailProvider>();
		list.add(new EmailProvider("gmail.com", "gmail.com"));
		list.add(new EmailProvider("naver.com", "naver.com"));
		list.add(new EmailProvider("hanmail.net", "hanmail.net"));
		list.add(new EmailProvider("daum.net", "daum.net"));
		list.add(new EmailProvider("kakao.com", "kakao.com"));

		return list;
	}

	@ModelAttribute("PhoneProviderList")
	public List<String> getPhoneProviderList() {
		List<String> list = new ArrayList<String>();
		list.add("010");
		list.add("011");
		list.add("016");

		return list;
	}

	@PostMapping
	public String addUser(@ModelAttribute("user") UserCommand userCommand, Model model, HttpServletRequest request) {
		String userId = userCommand.getEmail1() + "@" + userCommand.getEmail2();
		String phone = userCommand.getPhone1() + "-" + userCommand.getPhone2() + "-" + userCommand.getPhone3();
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");
		String uType = request.getParameter("uType");
		String addr = request.getParameter("addr");

		int idResult = userService.checkingUserId(userId);
		model.addAttribute("idResult", idResult);

		// form ???????????? ?????????????????? ?????? ????????????????????????
		if (idResult == 1) {
			return "user/error_signUp";
		}
		if (phone == null || phone.length() == 0) {
			return "user/error_signUp";
		}
		if (passwd == null || passwd.length() == 0) {
			return "user/error_signUp";
		}
		if (name == null || name.length() == 0) {
			return "user/error_signUp";
		}
		if (uType == null || uType.length() == 0) {
			return "user/error_signUp";
		}
		if (addr == null || addr.length() == 0) {
			return "user/error_signUp";
		}

		User user = new User();
		user.setUserId(userId);
		user.setPasswd(passwd);
		user.setName(name);
		user.setUType(uType.charAt(0));
		user.setPhone(phone);
		user.setManager('N');
		user.setAddr(addr);

		model.addAttribute("user", user);

		userService.addUser(user);

		return "user/login";

	}
}