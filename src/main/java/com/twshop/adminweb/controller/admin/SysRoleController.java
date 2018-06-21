package com.twshop.adminweb.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.twshop.entity.admin.SysMenu;
import com.twshop.entity.admin.SysRole;
import com.twshop.entity.admin.SysRoleMenu;
import com.twshop.service.admin.ISysMenuSerivce;
import com.twshop.service.admin.ISysRoleMenuService;
import com.twshop.service.admin.ISysRoleService;

/**
 * @ClassName: SysMenuController
 * @Description: 角色管理
 * 
 */
@Controller
@RequestMapping("/sysrole")
public class SysRoleController extends SysBaseController {

	private static final String _VIEW_INDEX = "/sys/role/list";
	private static final String _VIEW_EDIT = "/sys/role/edit";

	@Resource
	private ISysRoleService sysRoleService;
	@Resource
	private ISysMenuSerivce sysMenuService;
	@Resource
	private ISysRoleMenuService sysRoleMenuService;

	@RequiresPermissions("/sysrole/list")
	@RequestMapping(value = "/list")
	public String handleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return _VIEW_INDEX;
	}

	@RequiresPermissions("/sysrole/list")
	@RequestMapping(value = "/list.json")
	public void handleIndex(SysRole entity, Integer pageIndex, Integer pageSize, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {

		AjaxDOList<SysRole> data = sysRoleService.listAjaxData(entity, pageIndex, pageSize);

		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/info.json")
	public void handleToInfo(Long id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SysRole entity = null;
		if (id != null) {
			entity = sysRoleService.getById(id);
		}

		Map<String, Object> data = new HashMap<String, Object>();
		data.put("entity", entity);

		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/edit")
	public String handleToEdit(Long id, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		if (id != null) {
			SysRole entity = sysRoleService.getById(id);
			model.addAttribute("entity", entity);

			List<SysRoleMenu> sysRoleMenus = sysRoleMenuService.findSysRoleMenusBySysRoleId(id);
			model.addAttribute("sysRoleMenus", sysRoleMenus);
		}
		List<SysMenu> sysMenus = sysMenuService.findDecorateMenus();
		model.addAttribute("sysMenus", sysMenus);

		return _VIEW_EDIT;
	}

	@BussinessLog(value = "添加或修改角色")
	@RequestMapping(value = "/save.json")
	public void handleSave(SysRole entity, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {

		String menu_ids[] = request.getParameter("menuIds").split(",");
		List<Long> menuList = new ArrayList<Long>();

		if (menu_ids != null && menu_ids.length > 0) {
			for (String menu_id : menu_ids) {
				menuList.add(Long.valueOf(menu_id));
			}
		}

		if (entity.getId() == null) {
			sysRoleService.insert(entity, menuList);
		} else {
			sysRoleService.update(entity, menuList);
		}
		ajaxSuccess(response);
	}

	@BussinessLog(value = "删除角色")
	@RequestMapping(value = "/delete.json")
	public void handleDelete(Long id, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {

		if (id != null) {
			sysRoleService.deleteById(id);
		}

		ajaxSuccess(response, null);

	}

}
