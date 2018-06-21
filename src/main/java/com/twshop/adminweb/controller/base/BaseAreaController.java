package com.twshop.adminweb.controller.base;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.twshop.entity.base.BaseArea;
import com.twshop.enums.base.EnumAreaType;
import com.twshop.service.base.IAreaSerivce;
import com.twshop.vo.base.AreaTreeNodeVO;

/**
 * @classname: AreaController
 * @description: 地区控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/area")
public class BaseAreaController extends SysBaseController {

	private static final String _VIEW_LIST = "/base/area/list";
	private static final String _VIEW_EDIT = "/base/area/edit";
	private static final String _VIEW_INDEX = "/base/area/index";

	@Resource
	private IAreaSerivce areaService;

	@RequestMapping(value = "/index")
	public String handleIndex(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		return _VIEW_INDEX;
	}

	@RequestMapping(value = "/list")
	public String handleList(Long id, String code, HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		model.addAttribute("parentId", id);
		model.addAttribute("code", code);
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/tree.json")
	public void handleTree(HttpServletRequest request, HttpServletResponse response, Integer pageIndex,
			Integer pageSize) throws Exception {
		List<AreaTreeNodeVO> data = areaService.buildTree();
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/list.json")
	public void handleList(BaseArea entity, HttpServletRequest request, HttpServletResponse response, Integer pageIndex,
			Integer pageSize) throws Exception {
		AjaxDOList<BaseArea> data = areaService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/toedit")
	public String handleToEdit(Long id, Long parentId, Integer areaType, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		if (null != id) {
			BaseArea entity = areaService.getById(id);
			model.addAttribute("entity", entity);
		} else if (null != areaType) {
			BaseArea entity = new BaseArea();
			entity.setAreaType(areaType);
			model.addAttribute("entity", entity);
		}
		model.addAttribute("parentId", parentId);
		model.addAttribute("areaTypeList", EnumAreaType.values());
		return _VIEW_EDIT;
	}

	@RequestMapping(value = "/save.json")
	public void handleSave(BaseArea entity, HttpServletRequest request, HttpServletResponse response) throws Exception {
		areaService.save(entity);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/deletebyid.json")
	public void handleDeleteById(Long id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		areaService.deleteById(id);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/listbyparentandtype.json")
	public void handleListByParentAndType(String parentCode, Integer type, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<BaseArea> data = areaService.listByParentCodeAndType(parentCode, type);
		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/citylist.json")
	public void handleCityList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> data = areaService.cityList();
		ajaxSuccess(response, data);
	}

}
