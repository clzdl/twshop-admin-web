package com.twshop.adminweb.controller.mall;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.exception.BizException;
import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.twshop.ExceptionMessage;
import com.twshop.entity.base.BaseMerchant;
import com.twshop.entity.mall.MallCategory;
import com.twshop.enums.admin.EnumSysUserType;
import com.twshop.service.base.IMerchantSerivce;
import com.twshop.service.mall.IMallCategorySerivce;
import com.twshop.vo.admin.ZTreeNodeVO;
import com.twshop.vo.mall.CategoryTreeVO;

import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.Sqls;

/**
 * @classname: CategoryController
 * @description: 商品分类控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/mall/category")
public class CategoryController extends SysBaseController {

	private static final String _VIEW_INDEX = "/mall/category/index";
	private static final String _VIEW_LIST = "/mall/category/list";
	private static final String _VIEW_EDIT = "/mall/category/edit";

	@Resource
	private IMallCategorySerivce categoryService;

	@Resource
	private IMerchantSerivce merchantService;

	@RequestMapping(value = "/index")
	public String handleIndex(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		return _VIEW_INDEX;
	}

	@RequestMapping(value = "/list")
	public String handleList(Long parentId, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		model.addAttribute("parentId", parentId);
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/list.json")
	public void handleList(MallCategory entity, HttpServletRequest request, HttpServletResponse response,
			Integer pageIndex, Integer pageSize) throws Exception {
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			entity.setMerchantId(getCurrentMerId());
		}
		AjaxDOList<MallCategory> data = categoryService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/toedit")
	public String handleList(Long id, Long parentId, HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		if (null != id) {
			MallCategory entity = categoryService.getById(id);
			model.addAttribute("entity", entity);
		} else {
			MallCategory entity = new MallCategory();
			entity.setParentId(parentId);
			model.addAttribute("entity", entity);
		}

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
	public void handleSave(MallCategory entity, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		categoryService.save(entity);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/deletebyid.json")
	public void handleDeleteById(Long categoryId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (categoryService.countByParentId(categoryId) > 0) {
			throw new BizException(ExceptionMessage.NO_RIGHT_ERROR);
		}
		categoryService.deleteById(categoryId);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/tree.json")
	public void handleTree(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<MallCategory> list = null;
		if (EnumSysUserType.PLAT != EnumSysUserType.getEnum(getCurrentUserType())) {
			list = categoryService.listAllByExample(Example.builder(MallCategory.class)
					.where(Sqls.custom().andEqualTo("merchantId", getCurrentMerId())).build());
		} else {
			list = categoryService.listAll();
		}
		ajaxSuccess(response, CategoryTreeVO.build(list));
	}

	@RequestMapping(value = "/ddtreelist.json")
	public void handleList(Long merchantId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<ZTreeNodeVO> data = categoryService.listZTreeNodeVo(merchantId);

		ajaxSuccess(response, data);
	}
}
