package com.twshop.adminweb.controller.mall;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.twshop.entity.mall.MallItemSku;
import com.twshop.service.mall.IMallItemSkuSerivce;

/**
 * @classname: ItemSkuontroller
 * @description: 商品sku控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/mall/sku")
public class ItemSkuController extends SysBaseController {

	private static final String _VIEW_LIST = "/mall/sku/list";
	private static final String _VIEW_EDIT = "/mall/sku/edit";

	@Resource
	private IMallItemSkuSerivce skuService;

	@RequestMapping(value = "/list")
	public String handleList(Long itemId, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		model.addAttribute("itemId", itemId);
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/list.json")
	public void handleList(MallItemSku entity, HttpServletRequest request, HttpServletResponse response,
			Integer pageIndex, Integer pageSize) throws Exception {
		AjaxDOList<MallItemSku> data = skuService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/toedit")
	public String handleList(Long skuId, Long itemId, HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		if (null != skuId) {
			MallItemSku entity = skuService.getById(skuId);
			model.addAttribute("entity", entity);
		} else {
			MallItemSku entity = new MallItemSku();
			entity.setItemId(itemId);
			model.addAttribute("entity", entity);
		}
		return _VIEW_EDIT;
	}

	@RequestMapping(value = "/save.json")
	public void handleSave(MallItemSku entity, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		skuService.save(entity);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/deletebyid.json")
	public void handleDeleteById(Long skuId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		skuService.deleteById(skuId);
		ajaxSuccess(response);
	}
}
