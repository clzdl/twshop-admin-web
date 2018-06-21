package com.twshop.adminweb.controller.admin;

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
import com.twshop.entity.admin.SysUser;
import com.twshop.enums.admin.EnumSysUserType;
import com.twshop.service.admin.ISysOrgService;
import com.twshop.service.admin.ISysRoleService;
import com.twshop.service.admin.ISysRoleUserService;
import com.twshop.service.admin.ISysUserService;
import com.twshop.service.base.IMerchantSerivce;

/**
 * @ClassName: SysUserController
 * @Description:
 * 
 */
@Controller
@RequestMapping("/sysuser")
public class SysUserController extends SysBaseController {

	private static final String _VIEW_LIST = "/sys/user/list";
	private static final String _VIEW_EDIT = "/sys/user/edit";
	private static final String _VIEW_EDITPWD = "/sys/user/editpwd";
	private static final String _VIEW_ADDMERUSER = "/sys/user/addMerUser";

	@Resource
	private ISysUserService sysUserService;
	@Resource
	private ISysOrgService sysOrgService;
	@Resource
	private ISysRoleService sysRoleService;
	@Resource
	private ISysRoleUserService sysRoleUserService;
	@Resource
	private IMerchantSerivce merchantService;

	@RequiresPermissions("/sysuser/list")
	@RequestMapping(value = "/list.json")
	public void handleList(SysUser entity, Integer pageIndex, Integer pageSize, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		AjaxDOList<SysUser> data = sysUserService.listAjaxData(entity, pageIndex, pageSize);
		ajaxSuccess(response, data);
	}

	@RequiresPermissions("/sysuser/list")
	@RequestMapping(value = "/list")
	public String handleList(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		model.addAttribute("sysOrgs", sysOrgService.findDecorateOrgs());
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/edit")
	public String handleToEdit(Long id, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		SysUser entity = null;
		if (id != null) {
			entity = sysUserService.getById(id);
			entity.setSysOrg(sysOrgService.getById((long) entity.getOrgId().intValue()));
		}
		model.addAttribute("entity", entity);
		model.addAttribute("sysOrgs", sysOrgService.findDecorateOrgs());
		model.addAttribute("sysRoles", sysRoleUserService.findListBySysUserId(id));
		model.addAttribute("userTypeList", EnumSysUserType.values());
		model.addAttribute("merchantList", merchantService.listAll());
		return _VIEW_EDIT;
	}

	@BussinessLog(value = "添加或编辑系统用户")
	@RequestMapping(value = "/save.json")
	public void handleSave(SysUser entity, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		sysUserService.save(entity);
		ajaxSuccess(response);
	}

	@BussinessLog(value = "删除系统用户")
	@RequestMapping(value = "/delete.json")
	public void handleDelete(Long id, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		sysUserService.deleteById(id);
		ajaxSuccess(response);
	}

	@RequestMapping(value = "/toeditpwd")
	public String handleEditPwd(HttpServletResponse response, Model model) throws Exception {
		return _VIEW_EDITPWD;
	}

	@BussinessLog(value = "修改系统用户密码")
	@RequestMapping(value = "/editpwd.json")
	public void handleEditPwd(String oldPwd, String newPwd, HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		Long sysUserId = getCurrentUserId();
		sysUserService.updateUserPwd(sysUserId, oldPwd, newPwd);
		ajaxSuccess(response);
	}

}
