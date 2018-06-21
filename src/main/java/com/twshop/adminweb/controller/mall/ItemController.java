package com.twshop.adminweb.controller.mall;

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
import com.twshop.entity.mall.MallItem;
import com.twshop.enums.admin.EnumSysUserType;
import com.twshop.enums.common.EnumYesOrNo;
import com.twshop.enums.mall.EnumMallItemStatus;
import com.twshop.service.base.IMerchantSerivce;
import com.twshop.service.mall.IMallItemSerivce;

/**
 * @classname: ItemController
 * @description: 商品控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/mall/item")
public class ItemController extends SysBaseController {

	private static final String _VIEW_LIST = "/mall/item/list";
	private static final String _VIEW_EDIT = "/mall/item/edit";

	@Resource
	private IMallItemSerivce itemService;
	@Resource
	private IMerchantSerivce merchantService;

	@RequestMapping(value = "/list")
	public String handleList(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/list.json")
	public void handleList(MallItem entity, HttpServletRequest request, HttpServletResponse response, Integer pageIndex,
			Integer pageSize) throws Exception {
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			entity.setMerchantId(getCurrentMerId());
		}
		AjaxDOList<MallItem> data = itemService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/toedit")
	public String handleList(Long itemId, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		if (null != itemId) {
			MallItem entity = itemService.getById(itemId);
			model.addAttribute("entity", entity);
		}
		model.addAttribute("yesOrNoList", EnumYesOrNo.values());
		model.addAttribute("statusList", EnumMallItemStatus.values());
		List<BaseMerchant> merchantList = null;
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			merchantList = new ArrayList<>();
			merchantList.add(merchantService.getById(getCurrentMerId()));
		} else {
			merchantList = merchantService.listAll();
		}
		model.addAttribute("merchantList", merchantList);
		return _VIEW_EDIT;
	}

	@RequestMapping(value = "/save.json")
	public void handleSave(MallItem entity, HttpServletRequest request, HttpServletResponse response) throws Exception {
		itemService.save(entity);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/deletebyid.json")
	public void handleDeleteById(Long itemId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		itemService.deleteById(itemId);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/changeshelve.json")
	public void handleChangeshelve(Long itemId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		itemService.changeShelve(itemId);
		ajaxSuccess(response);
	}

}
