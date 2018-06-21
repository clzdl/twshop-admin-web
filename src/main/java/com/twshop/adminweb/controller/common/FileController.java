package com.twshop.adminweb.controller.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.base.exception.BizException;
import com.base.mvc.controller.SysBaseController;
import com.base.util.conf.PropUtil;
import com.base.util.json.JsonUtil;
import com.base.util.string.StringUtil;
import com.twshop.ExceptionMessage;
import com.twshop.service.common.IFileService;
import com.twshop.vo.common.UploadResultVO;

/**
 * @ClassName: FileController
 * @Description: 文件上传接口
 * @date 2015-3-31 下午4:38:14
 * 
 */
@Controller
@RequestMapping("/file")
public class FileController extends SysBaseController {
	private static List<String> extList = new ArrayList<String>(); // 定义允许上传的文件扩展名
	private static final String _WXCERT_FILE_PATH = PropUtil.getInstance().get("wx.certfile.path.linux");
	static {
		extList.add("gif");
		extList.add("jpg");
		extList.add("jpeg");
		extList.add("png");
		extList.add("bmp");
	}

	@Resource
	private IFileService imgService;

	/**
	 * 删除图片
	 * 
	 * @param file_name
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/del.json")
	public void handleDel(String file_name, HttpServletRequest request, HttpServletResponse response) throws Exception {
		imgService.del(file_name);
		ajaxSuccess(response);
	}

	/**
	 * 上传图片
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/upload.json")
	public void handleUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UploadResultVO data = null;
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iter = multiRequest.getFileNames();
		if (iter.hasNext()) {
			MultipartFile file = multiRequest.getFile(iter.next());
			// 验证附件格式和大小
			checkFile(file);

			data = imgService.insertImgFile(file);
		}
		ajaxSuccess(response, data);
	}

	/**
	 * 上传图片（富文本编辑器）
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/upload4layedit.json")
	public void handleUpload4Layedit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileName = null;
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iter = multiRequest.getFileNames();
		if (iter.hasNext()) {
			MultipartFile file = multiRequest.getFile(iter.next());
			// 验证附件格式和大小
			checkFile(file);

			fileName = imgService.insertImgFile(file).getFileName();
		}

		Map<String, Object> dataMap = new HashMap<String, Object>();
		if (StringUtil.isNotBlank(fileName)) {
			Map<String, String> data = new HashMap<String, String>();
			data.put("src", PropUtil.getInstance().get("img.site.name") + fileName);
			dataMap.put("code", 0);
			dataMap.put("msg", "success");
			dataMap.put("data", data);
		} else {
			dataMap.put("code", 1);
			dataMap.put("msg", "fail");
		}
		JsonUtil.reponseUtf8JsonMsg(response, dataMap);
	}

	@RequestMapping(value = "/uploadWxCertFile.json")
	public void handleUploadWxCertFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iter = multiRequest.getFileNames();
		String uploadFile = null;
		if (iter.hasNext()) {
			MultipartFile file = multiRequest.getFile(iter.next());
			uploadFile = imgService.insertNorFile(file, _WXCERT_FILE_PATH);
			if (StringUtil.isNotBlank(uploadFile)) {
				uploadFile = _WXCERT_FILE_PATH + uploadFile;
			}
		}
		ajaxSuccess(response, uploadFile);
	}

	private void checkFile(MultipartFile file) throws Exception {
		String fileName = file.getOriginalFilename();
		String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
		if (!extList.contains(fileExt)) {
			throw new BizException(ExceptionMessage.FILE_NAME_EXT_ERROR);
		}
	}

}
