package com.twshop.adminweb.controller.wechat;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.twshop.entity.wechat.WechatAccount;
import com.twshop.enums.admin.EnumSysUserType;
import com.twshop.enums.wechat.EnumWechatAppType;
import com.twshop.service.wechat.IWechatAccountSerivce;

/**
 * @classname: WechatAccountController
 * @description: 地区控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/wxaccount")
public class AccountController extends SysBaseController {

	private static final String _VIEW_LIST = "/wechat/account/list";
	private static final String _VIEW_EDIT = "/wechat/account/edit";

	@Resource
	private IWechatAccountSerivce wechatAccountService;

	@RequestMapping(value = "/list")
	public String handleList(Long merchantId, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		model.addAttribute("merchantId", merchantId);
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/list.json")
	public void handleList(WechatAccount entity, HttpServletRequest request, HttpServletResponse response,
			Integer pageIndex, Integer pageSize) throws Exception {
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			entity.setMerchantId(getCurrentMerId());
		}
		AjaxDOList<WechatAccount> data = wechatAccountService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/toedit")
	public String handleToEdit(Long accountId, Long merchantId, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		if (null != accountId) {
			WechatAccount entity = wechatAccountService.getById(accountId);
			model.addAttribute("entity", entity);
		} else {
			WechatAccount entity = new WechatAccount();
			entity.setMerchantId(merchantId);
			model.addAttribute("entity", entity);
		}
		model.addAttribute("appTypeList", EnumWechatAppType.values());
		return _VIEW_EDIT;
	}

	@RequestMapping(value = "/save.json")
	public void handleSave(WechatAccount entity, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		wechatAccountService.save(entity);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/deletebyid.json")
	public void handleDeleteById(Long accountId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		wechatAccountService.deleteById(accountId);
		ajaxSuccess(response);
	}
}
