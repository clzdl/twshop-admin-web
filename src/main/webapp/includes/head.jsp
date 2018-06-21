<%@page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<head>
	<title>天问商城-管理系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">  
	
	<c:set var="domain_s" value="http://s.twshop.cn"/>
	<c:set var="domain_img" value="http://img.twshop.cn/"/>
	<c:set var="domain_manager" value="http://manager.twshop.cn/"/>
	
	<!--  全局css -->
	<link rel="stylesheet" href="${domain_s }/admin/plugins/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${domain_s }/admin/css/global.css" media="all">
	<link rel="stylesheet" href="${domain_s }/admin/plugins/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="${domain_s }/admin/zTree_v3-master/css/zTreeStyle/zTreeStyle.css">	 
	
	<!--  全局js -->
	<script type="text/javascript" src="${domain_s }/admin/plugins/layui/layui.js"></script>
	
	<script type="text/javascript" src="${domain_s }/admin/plugins/jquery-3.3.1.min.js"></script> 
	<script type="text/javascript" src="${domain_s }/admin/zTree_v3-master/js/jquery.ztree.all.min.js"></script>
	
</head>