package com.twshop.adminweb.controller.base;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.twshop.entity.base.BaseMerchant;
import com.twshop.enums.admin.EnumSysUserType;
import com.twshop.service.base.IMerchantSerivce;

/**
 * @classname: MerchantController
 * @description: 商户控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/merchant")
public class MerchantController extends SysBaseController {

	private static final String _VIEW_LIST = "/base/merchant/list";
	private static final String _VIEW_EDIT = "/base/merchant/edit";

	@Resource
	private IMerchantSerivce merchantService;

	@RequestMapping(value = "/list")
	public String handleList(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/list.json")
	public void handleList(BaseMerchant entity, HttpServletRequest request, HttpServletResponse response,
			Integer pageIndex, Integer pageSize) throws Exception {
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			entity.setId(getCurrentMerId());
		}
		AjaxDOList<BaseMerchant> data = merchantService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/toedit")
	public String handleToEdit(Long merchantId, String code, HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		if (null != merchantId) {
			BaseMerchant entity = merchantService.getById(merchantId);
			model.addAttribute("entity", entity);
		}
		return _VIEW_EDIT;
	}

	@RequestMapping(value = "/save.json")
	public void handleSave(BaseMerchant entity, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		merchantService.save(entity);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/deletebyid.json")
	public void handleDeleteById(Long merchantId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		merchantService.deleteById(merchantId);
		ajaxSuccess(response);
	}

}
