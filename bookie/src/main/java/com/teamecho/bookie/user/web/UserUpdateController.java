package com.teamecho.bookie.user.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@Controller
@RequestMapping("/user/user_update")
public class UserUpdateController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping
	public String userUpdateForm(HttpServletRequest request, Model model)  throws IOException {
		HttpSession session = request.getSession(false);
		
		if (session == null) {
			model.addAttribute("session", "no");
			return "redirect:login";
		} else {
			if (session.getAttribute("uId") == null) {
				model.addAttribute("session", "no");
				return "redirect:login";
			}
			model.addAttribute("session", "yes");
		}
		
		long uId = (long) session.getAttribute("uId");
		User user = userService.getUserByUid(uId);
		
		model.addAttribute("user", user);
		return "/user/user_update";
	}
	
	@PostMapping
	public String userUpdateForm(Model model, HttpServletRequest request, RedirectAttributes ra) {
		String passwd = null;
		if (request.getParameter("new_passwd") == "") {
			passwd = request.getParameter("old_passwd");
		}else if (request.getParameter("new_passwd") != "") {
			if(request.getParameter("new_passwd").equals(request.getParameter("passwd_check")) == false) {
				ra.addFlashAttribute("msg", "불일치");
				return "redirect:/user/user_update";
			}else {
				passwd = request.getParameter("new_passwd");				
			}
		}
		long uId = Integer.parseInt(request.getParameter("uId"));
		String userId = request.getParameter("userId");
		String name = request.getParameter("name");
		String uType = request.getParameter("uType");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");	
		
		User user =  userService.getUserByUid(uId);
		user.setUserId(userId);
		user.setPasswd(passwd);
		user.setName(name);
		user.setUType(uType.charAt(0));
		user.setPhone(phone);
		user.setManager('N');
		user.setAddr(addr);
		
		model.addAttribute("user", user);
		
		if(userService.getUserByUid(uId).getManager() == 'Y') {
			request.setAttribute("adminPage", "adminPage");
			return "/user/mypage";
		}
		
		userService.updateUser(user);
		
		return "/user/mypage";
	}
}