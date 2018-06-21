package com.twshop.adminweb.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.mvc.controller.SysBaseController;
import com.base.util.conf.PropUtil;
import com.base.util.httpclient.HttpSendClientFactory;

/**
 * @classname: CacheController
 * @description: 缓存控制器
 * @author java
 *
 */
@Controller
@RequestMapping("/cache")
public class CacheController extends SysBaseController {
	private static final String _VIEW_LIST = "/common/cache/list";
	private static final String _M_CLEAR_URI = "/cache/clear.json";

	@RequestMapping(value = "/list")
	public String handleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return _VIEW_LIST;
	}

	@RequestMapping(value = "/clearmweb.json")
	public void handleClearMWeb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ip = PropUtil.getInstance().get("m.site.host.list");
		String[] ipList = ip.split(";");
		for (String ipString : ipList) {
			HttpSendClientFactory.getInstance().get(ipString + _M_CLEAR_URI, null);
		}
		ajaxSuccess(response);
	}

}
