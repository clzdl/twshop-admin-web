package com.twshop.adminweb.controller.home;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.twshop.service.admin.ISysUserService;

/**
 * @classname: HomeController
 * @description: 首页控制器
 * @author java
 *
 */
@Controller
@RequestMapping("")
public class HomeController extends SysBaseController {

	private static final String _VIEW_LOGIN = "/login";

	private static final String _VIEW_INDEX = "/index";

	@Resource
	private ISysUserService sysUserService;

	@RequestMapping(value = "/")
	public String handleIndex(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		model.addAttribute("userName", getCurrentUserContext().getUserName());
		return _VIEW_INDEX;
	}

	@RequestMapping(value = "/tologin")
	public String handleToLogin(HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		return _VIEW_LOGIN;
	}

	@RequestMapping(value = "/login.json")
	public void handleLogin(String userLogin, String userPwdMd5, Boolean rememberMe, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		sysUserService.login(userLogin, userPwdMd5, rememberMe, request, response);

		ajaxSuccess(response);
	}

	@RequestMapping(value = "/logout")
	public String handleLogout(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		Long sysUserId = getCurrentUserId();
		sysUserService.loginOut(sysUserId, request, response);
		return _VIEW_LOGIN;
	}

	@RequestMapping(value = "/clearcache.json")
	public void handleClearCache(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ajaxSuccess(response);
	}

}
