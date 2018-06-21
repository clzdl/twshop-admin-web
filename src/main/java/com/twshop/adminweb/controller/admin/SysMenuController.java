package com.twshop.adminweb.controller.admin;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.mvc.page.AjaxDOList;
import com.base.operationlog.annotation.BussinessLog;
import com.base.util.date.DateUtil;
import com.twshop.entity.admin.SysMenu;
import com.twshop.enums.admin.EnumSysMenuLevelType;
import com.twshop.service.admin.ISysMenuSerivce;
import com.twshop.vo.admin.SysMenuVO;

/**
 * @ClassName: SysMenuController
 * @Description:菜单管理
 * 
 */
@Controller
@RequestMapping("/sysmenu")
public class SysMenuController extends SysBaseController {

	final static String _VIEW_LIST = "/sys/menu/list";
	final static String _VIEW_EDIT = "/sys/menu/edit";

	@Resource
	private ISysMenuSerivce sysMenuService;

	@RequiresPermissions("/sysmenu/tree.json")
	@RequestMapping(value = "/tree.json")
	public void handleTree(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		Long sysUserId = getCurrentUserId();
		List<SysMenu> list = sysMenuService.findLoginUserMenus(sysUserId);
		ajaxSuccess(response, SysMenuVO.build(list));
	}

	@RequiresPermissions("/sysmenu/list")
	@RequestMapping(value = "/list")
	public String handleList(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		model.addAttribute("sysMenuLevelTypes", EnumSysMenuLevelType.values());
		return _VIEW_LIST;
	}

	@RequiresPermissions("/sysmenu/list")
	@RequestMapping(value = "/list.json")
	public void handleList(SysMenu entity, Integer pageIndex, Integer pageSize, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		AjaxDOList<SysMenu> list = sysMenuService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, list);
	}

	@RequestMapping(value = "/edit")
	public String handleEdit(Long id, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		if (null != id) {
			SysMenu sysMenu = sysMenuService.getById(id);
			model.addAttribute("entity", sysMenu);
		}

		List<SysMenu> sysMenuList = sysMenuService.findMenuByParent(0L);
		model.addAttribute("firstMenuList", sysMenuList);
		return _VIEW_EDIT;
	}

	@BussinessLog(value = "添加或修改系统菜单")
	@RequestMapping(value = "/save.json")
	public void handleSave(SysMenu entity, HttpServletRequest request, HttpServletResponse response) throws Exception {

		if (entity.getId() == null) {
			entity.setCreateTime(DateUtil.getCurrentTimeStamp());
			sysMenuService.insert(entity);
		} else {
			sysMenuService.update(entity);
		}

		ajaxSuccess(response);
	}

	@BussinessLog(value = "删除系统菜单")
	@RequestMapping(value = "/delete.json")
	public void handleDelete(SysMenu entity, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		if (entity.getId() != null) {
			sysMenuService.deleteById((long) entity.getId().intValue());
		}

		ajaxSuccess(response);
	}

}
