<%@page contentType="text/html;charset=utf-8" %>


<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
  		<div class="layui-layout layui-layout-admin">
  		    <div class="layui-title" style="top:0px;height:100px;border-bottom: solid 2px #1AA094 ">
			<blockquote class="layui-elem-quote">
                <a href="javascript:;" data-opt="add" data-id="" class="layui-btn layui-btn-small" >
                    <i class="layui-icon">&#xe608;</i> 添加一级分类
                </a>
                <a href="javascript:;" data-opt="first-manager" data-id="" class="layui-btn layui-btn-small" >
                    <i class="layui-icon">&#xe656;</i> 一级分类管理
                </a>
            </blockquote>
            </div>
			<div class="layui-side"  style="top:100px" >
				<ul id="treeMenu"></ul>
			</div>
			<div class="layui-body" style="bottom: 0;border-left: solid 2px #1AA094;top:100px;float:left">
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
								
				$.post('/mall/category/tree.json', null, function(res){
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
				
				$('a[data-opt="add"]').on('click', function() {
                    layer.open({
                        title: '编辑',
                        maxmin: true,
                        type: 2,
                        content: '/mall/category/toedit?parentId=0',
                        area: ['500px', '400px']
                    });
                });
				
				$('a[data-opt="first-manager"]').on('click', function() {
                    layer.open({
                        title: '一级分类管理',
                        maxmin: true,
                        type: 2,
                        content: '/mall/category/list?parentId=0',
                        area: ['800px', '600px']
                    });
                });
			});
		</script>
	</body>

</html>
