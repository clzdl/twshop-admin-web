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
import com.base.mvc.page.PageModel;
import com.base.operationlog.annotation.BussinessLog;
import com.base.util.date.DateUtil;
import com.twshop.entity.admin.SysOrg;
import com.twshop.service.admin.ISysOrgService;
import com.twshop.vo.admin.SysOrgVO;
import com.twshop.vo.admin.ZTreeNodeVO;

/**
 * @ClassName: SysMenuController
 * @Description:组织机构管理
 * 
 */
@Controller
@RequestMapping("/sysorg")
public class SysOrgController extends SysBaseController {

	private static final String _VIEW_INDEX = "/sys/org/index";
	private static final String _VIEW_LIST = "/sys/org/list";
	private static final String _VIEW_EDIT = "/sys/org/edit";

	@Resource
	private ISysOrgService sysOrgService;

	@RequiresPermissions("/sysorg/index")
	@RequestMapping(value = "/index")
	public String handleIndex(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		return _VIEW_INDEX;
	}

	@RequestMapping(value = "/treeNodeData.json")
	public void handleTreeNode(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		List<SysOrg> listSysOrg = sysOrgService.listAll();
		ajaxSuccess(response, SysOrgVO.build(listSysOrg));
	}

	@BussinessLog(value = "获取菜单")
	@RequestMapping(value = "/tree.json")
	public void handleTree(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		List<ZTreeNodeVO> tree = sysOrgService.tree();
		ajaxSuccess(response, tree);
	}

	@RequiresPermissions("/sysorg/index")
	@RequestMapping(value = "/list")
	public String handleList(SysOrg entity, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		model.addAttribute("entity", entity);
		return _VIEW_LIST;
	}

	@RequiresPermissions("/sysorg/index")
	@RequestMapping(value = "/list.json")
	public void handleList(SysOrg entity, Integer pageIndex, Integer pageSize, PageModel<SysOrg> pageModel,
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		AjaxDOList<SysOrg> data = sysOrgService.listAjaxData(entity, pageIndex, pageSize);

		ajaxSuccess(response, data);
	}

	@RequestMapping(value = "/edit")
	public String handleToEdit(Long id, Long parentId, HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		if (id != null) {
			SysOrg entity = sysOrgService.getById(id);
			model.addAttribute("entity", entity);
		}
		model.addAttribute("parentId", parentId);
		return _VIEW_EDIT;
	}

	@BussinessLog(value = "添加或修改组织机构")
	@RequestMapping(value = "/save.json")
	public void handleSave(SysOrg entity, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		if (entity.getId() == null) {
			entity.setCreateTime(DateUtil.getCurrentTimeStamp());
			sysOrgService.insert(entity);
		} else {
			sysOrgService.update(entity);
		}

		ajaxSuccess(response, null);
	}

	@BussinessLog(value = "删除组织机构")
	@RequestMapping(value = "/delete.json")
	public void handleDelete(Long id, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {
		if (id != null) {
			sysOrgService.deleteById(id);
		}

		ajaxSuccess(response, null);
	}

}
