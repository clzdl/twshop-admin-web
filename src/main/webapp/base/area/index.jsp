<%@page contentType="text/html;charset=utf-8" %>


<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
  		<div class="layui-layout layui-layout-admin">
  		    <div class="layui-title" style="top:0px;height:100px;border-bottom: solid 2px #1AA094 ">
			<blockquote class="layui-elem-quote">
                <a href="javascript:;" data-opt="add" data-id="" class="layui-btn layui-btn-small" >
                    <i class="layui-icon">&#xe608;</i> 添加省份
                </a>
                 <a href="javascript:;" data-opt="addspec" data-id="" class="layui-btn layui-btn-small" >
                    <i class="layui-icon">&#xe608;</i> 添加直辖市
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
								
				$.post('/area/tree.json', null, function(res){
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
                        content: '/area/toedit?parentId=0',
                        area: ['400px', '200px']
                    });
                });
				
				$('a[data-opt="addspec"]').on('click', function() {
                    layer.open({
                        title: '编辑',
                        maxmin: true,
                        type: 2,
                        content: '/area/toedit?parentId=0&areaType=0',
                        area: ['400px', '200px']
                    });
                });
			});
		</script>
	</body>

</html>
