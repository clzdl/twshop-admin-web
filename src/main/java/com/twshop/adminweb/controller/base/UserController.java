package com.twshop.adminweb.controller.base;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.twshop.entity.base.BaseUser;
import com.twshop.enums.admin.EnumSysUserType;
import com.twshop.service.base.IUserSerivce;

/**
 * @classname: UserController
 * @description: 地区控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/user")
public class UserController extends SysBaseController {

	private static final String _VIEW_LIST = "/base/user/list";

	@Resource
	private IUserSerivce userService;

	@RequestMapping(value = "/list")
	public String handleList(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/list.json")
	public void handleList(BaseUser entity, HttpServletRequest request, HttpServletResponse response, Integer pageIndex,
			Integer pageSize) throws Exception {
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			entity.setMerchantId(getCurrentMerId());
		}
		AjaxDOList<BaseUser> data = userService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/changegrant.json")
	public void handleChangeGrant(Long userId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		userService.changeGrant(userId);
		ajaxSuccess(response);
	}

}
