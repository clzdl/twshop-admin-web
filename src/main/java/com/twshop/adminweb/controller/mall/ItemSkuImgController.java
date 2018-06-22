package com.twshop.adminweb.controller.mall;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.twshop.entity.mall.MallSkuImg;
import com.twshop.enums.mall.EnumMallSkuImgType;
import com.twshop.service.mall.IMallSkuImgSerivce;

/**
 * @classname: ItemSkuImgController
 * @description: 商品sku图片控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/mall/skuimg")
public class ItemSkuImgController extends SysBaseController {

	private static final String _VIEW_LIST = "/mall/skuImg/list";
	private static final String _VIEW_EDIT = "/mall/skuImg/edit";

	@Resource
	private IMallSkuImgSerivce skuImgService;

	@RequestMapping(value = "/list")
	public String handleList(Long skuId, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		model.addAttribute("skuId", skuId);
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/list.json")
	public void handleList(MallSkuImg entity, HttpServletRequest request, HttpServletResponse response,
			Integer pageIndex, Integer pageSize) throws Exception {
		AjaxDOList<MallSkuImg> data = skuImgService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/toedit")
	public String handleList(Long imgId, Long skuId, HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		if (null != imgId) {
			MallSkuImg entity = skuImgService.getById(imgId);
			model.addAttribute("entity", entity);
		} else {
			MallSkuImg entity = new MallSkuImg();
			entity.setSkuId(skuId);
			model.addAttribute("entity", entity);
		}
		model.addAttribute("imgTypeList", EnumMallSkuImgType.values());
		return _VIEW_EDIT;
	}

	@RequestMapping(value = "/save.json")
	public void handleSave(MallSkuImg entity, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		skuImgService.save(entity);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/deletebyid.json")
	public void handleDeleteById(Long imgId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		skuImgService.deleteById(imgId);
		ajaxSuccess(response);
	}
}
