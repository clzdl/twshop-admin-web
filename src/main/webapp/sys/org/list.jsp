<%@page contentType="text/html;charset=utf-8" %>


<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div class="admin-main">
			<blockquote class="layui-elem-quote">
				<a href="javascript:;" data-opt="add" data-id="" class="layui-btn layui-btn-small" >
					<i class="layui-icon">&#xe608;</i> 添加机构
				</a>
			</blockquote>
			<fieldset class="layui-elem-field">
				<div class="layui-field-box">
					<div>
						<table class="site-table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>机构名称</th>
									<th>父节点ID</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<!--内容容器-->	
							<tbody id="con"></tbody>
						</table>
						<!--分页容器-->
						<div id="paged"></div>
					</div>
				</div>
			</fieldset>
			
		</div>
		<!--模板-->
		<script type="text/html" id="conTemp">
			{{# layui.each(d.list, function(index, item){ }}
			<tr>
				<td>{{ item.id }}</td>
				<td>{{ item.orgName }}</td>
				<td>{{ item.parentId }}</td>
				<td>{{ item.createTimeOutput }}</td>
				<td>
					<a href="javascript:;" data-id="{{ item.id }}" data-opt="edit" class="layui-btn layui-btn-mini">编辑</a>
					<a href="javascript:;" data-id="{{ item.id }}" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/javascript" src="${domain_s}/admin/plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['paging', 'code', 'layer','common'], function() {
				layui.code();
				var $ = layui.jquery,
					paging = layui.paging(),
					layer = layui.layer,
					common = layui.common,
					laytpl = layui.laytpl;

				paging.init({
					url: '/sysorg/list.json', //地址
					elem: '#con', //内容容器
					params: { //发送到服务端的参数
						"id":"${entity.id }",
					},
					tempElem: '#conTemp', //模块容器
					pageConfig: { //分页参数配置
						elem: 'paged' //分页容器
					},
					fail: function(msg) { //获取数据失败的回调
						//alert('获取数据失败')
					},
					complate: function() { //完成的回调
						//alert('处理完成');
						$('a[data-opt="edit"]').on('click', function() {
							var id = $(this).attr('data-id');
							layer.open({
		 						title: '编辑',
		 						maxmin: true,
		 						type: 2,
		 						content: '/sysorg/edit?id=' + id+'&parentId=${entity.id }',
		 						area: ['400px', '200px']
		 					});
						});
						
						$('a[data-opt="del"]').on('click', function() {
							var id = $(this).attr('data-id');	
							layer.confirm('确定该操作吗？', {icon: 3, title:'提示'}, function(index){
								$.post('/sysorg/delete.json', {"id": id}, function(res){
									if(res.flag && res.flag === 1){
										//location.reload(); 
										parent.location.reload();
									}
									else {
										common.msgError(res.errorMsg);
									}
								}, 'json');
							  	layer.close(index);
							});
							
						});
					}
				});
				
				$('a[data-opt="add"]').on('click', function() {
					layer.open({
 						title: '编辑',
 						maxmin: true,
 						type: 2,
 						content: '/sysorg/edit?parentId=${entity.id }',
 						area: ['400px', '200px']
 					});
				});
				
			});
		</script>
	</body>

</html>
