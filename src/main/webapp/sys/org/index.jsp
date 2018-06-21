<%@page contentType="text/html;charset=utf-8" %>


<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
  		<div class="layui-layout layui-layout-admin">
			
			<div class="layui-side"  style="top:0px" >
				<ul id="treeMenu"></ul>
			</div>
			<div class="layui-body" style="bottom: 0;border-left: solid 2px #1AA094;top:0px;float:left">
				<div class="layui-tab-content" style="height:100%">
					<iframe name='treeContShowFrm' frameborder="0" style="height:100%;width:100%"></iframe>
				</div>
			</div>
			
		</div>
		<script type="text/javascript" src="${domain_s}/admin/plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['tree', 'layer','common'], function() {
				var $ = layui.jquery;
								
				$.post('/sysorg/treeNodeData.json', null, function(res){
					if(res.flag && res.flag === 1){
						layui.tree({
							elem: '#treeMenu', //传入元素选择器
						  	target: 'treeContShowFrm',
						  	nodes: res.data,
						});
					} else {
						common.msgError(res.errorMsg);
					}
				}, 'json');
			});
		</script>
	</body>

</html>
