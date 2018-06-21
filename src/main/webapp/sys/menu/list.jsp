<%@page contentType="text/html;charset=utf-8" %>


<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div class="admin-main">
			<blockquote class="layui-elem-quote">
			<form class="layui-form">
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">层级</label>
						<div class="layui-input-inline">
							<select name="level">
		 						<option value="">--请选择--</option>
		 						<c:forEach var="result" items="${sysMenuLevelTypes }" >
			 					<option value="${result.code }" >${result.name }</option>
			 					</c:forEach>
		 					</select>
						</div>
					</div>
					
					<a href="javascript:;" class="layui-btn layui-btn-small" lay-submit="" lay-filter="form-submit-btn">
						<i class="layui-icon">&#xe615;</i> 搜索
					</a>
					<shiro:hasRole name="admin">
					<a href="javascript:;" data-opt="add-menu" data-id="" class="layui-btn layui-btn-small" >
						<i class="layui-icon">&#xe608;</i> 添加菜单
					</a>
					</shiro:hasRole>
				</div>
			</form>
				
			</blockquote>
			<fieldset class="layui-elem-field">
				<div class="layui-field-box">
					<div>
						<table class="site-table table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>名称</th>
									<th>url</th>
									<th>层级</th>
									<th>排序号</th>
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
				<td>{{ item.name }}</td>
				<td>{{ item.href }}</td>
				<td>{{ item.levelOutput}} </td>
				<td> {{ item.sortNo }} </td>
				<td>
                    <shiro:hasRole name="admin">
					<a href="javascript:;" data-id="{{ item.id }}" data-opt="edit" class="layui-btn layui-btn-mini">编辑</a>
					<a href="javascript:;" data-id="{{ item.id }}" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a>
                    </shiro:hasRole>
				</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/javascript" src="${domain_s}/admin/plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['paging', 'code', 'layer','common','form'], function() {
				layui.code();
				var $ = layui.jquery,
					paging = layui.paging(),
					layer = layui.layer,
					common = layui.common,
					form = layui.form,
					laytpl = layui.laytpl;

				paging.init({
					url: '/sysmenu/list.json', //地址
					elem: '#con', //内容容器
					params: { //发送到服务端的参数
						
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
		 						content: '/sysmenu/edit?id=' + id,
		 						area: ['600px', '500px']
		 					});
						});
						
						$('a[data-opt="del"]').on('click', function() {
							var id = $(this).attr('data-id');	
							layer.confirm('确定该操作吗？', {icon: 3, title:'提示'}, function(index){
								$.post('/sysmenu/delete.json', {"id": id}, function(res){
									if(res.flag && res.flag === 1){
										location.reload(); 
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
				//alert('处理完成');
				$('a[data-opt="add-menu"]').on('click', function() {
					var id = $(this).attr('data-id');	
					layer.open({
 						title: '编辑',
 						maxmin: true,
 						type: 2,
 						content: '/sysmenu/edit?id=' + id,
 						area: ['600px', '500px']
 					});
				});
				form.on('submit(form-submit-btn)', function(data) {
					paging.get(
						data.field
					); 
				});
			});
		</script>
	</body>

</html>
