package com.twshop.adminweb.controller.finance;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.twshop.entity.base.BaseMerchant;
import com.twshop.entity.finance.WebOrder;
import com.twshop.enums.admin.EnumSysUserType;
import com.twshop.service.base.IMerchantSerivce;
import com.twshop.service.finance.IWebOrderSerivce;

/**
 * @classname: ItemController
 * @description: 商品控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/finance/order")
public class WebOrderController extends SysBaseController {

	private static final String _VIEW_LIST = "/finance/order/list";
	private static final String _VIEW_DETAIL = "/finance/order/detail";

	@Resource
	private IWebOrderSerivce webOrderService;
	@Resource
	private IMerchantSerivce merchantService;

	@RequestMapping(value = "/list")
	public String handleList(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		List<BaseMerchant> merchantList = null;
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			merchantList = new ArrayList<>();
			merchantList.add(merchantService.getById(getCurrentMerId()));
		} else {
			merchantList = merchantService.listAll();
		}
		model.addAttribute("merchantList", merchantList);
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/list.json")
	public void handleList(WebOrder entity, HttpServletRequest request, HttpServletResponse response, Integer pageIndex,
			Integer pageSize) throws Exception {
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			entity.setMerchantId(getCurrentMerId());
		}
		AjaxDOList<WebOrder> data = webOrderService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/detail")
	public String handleList(Long orderId, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		WebOrder entity = webOrderService.getById(orderId);
		model.addAttribute("entity", entity);
		return _VIEW_DETAIL;
	}

}
