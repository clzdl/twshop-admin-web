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
							<label class="layui-form-label">所属机构</label>
							<div class="layui-input-inline">
			 				     <div id="orgId" class="layui-form-select select-tree"></div>
							</div>
						</div>
						<a href="javascript:;" class="layui-btn layui-btn-small" lay-submit="" lay-filter="form-submit-btn">
							<i class="layui-icon">&#xe615;</i> 搜索
						</a>
						<a href="javascript:;" data-opt="add" data-id="" class="layui-btn layui-btn-small" >
							<i class="layui-icon">&#xe608;</i> 添加用户
						</a>
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
									<th>姓名</th>
									<th>手机号码</th>
									<th>邮箱</th>
									<th>性别</th>
									<th>登录名</th>
									<th>所属机构</th>
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
				<td>{{ item.userName }}</td>
				<td>{{ item.userTel }}</td>
				<td>{{ item.userEmail }}</td>
				<td>{{ item.userSexName }}</td>
				<td>{{ item.userLogin }}</td>
				<td>{{ item.sysOrg.orgName }}</td>
				<td>{{ item.createTimeOutput }}</td>
				<td>
					<a href="javascript:;" data-id="{{ item.id }}" data-opt="edit" class="layui-btn layui-btn-mini">编辑</a>
					<a href="javascript:;" data-id="{{ item.id }}" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		
		<script>
			layui.config({
				base: '${domain_s }/admin/js/'
			}).use(['paging', 'code', 'layer', 'form','ddtree'], function() {
				layui.code();
				var $ = layui.jquery,
					paging = layui.paging(),
					layer = layui.layer,
					laytpl = layui.laytpl,
					form = layui.form,
					ddtree = layui.ddtree();
				paging.init({
					url: '/sysuser/list.json', //地址
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
		 						content: '/sysuser/edit?id=' + id,
		 						area: ['600px', '500px']
		 					});
						});
						$('a[data-opt="del"]').on('click', function() {
							var id = $(this).attr('data-id');	
							layer.confirm('确定该操作吗？', {icon: 3, title:'提示'}, function(index){
								$.post('/sysuser/delete.json', {"id": id}, function(res){
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
						
					},
				});
				
				$('a[data-opt="add"]').on('click', function() {
					layer.open({
 						title: '编辑',
 						maxmin: true,
 						type: 2,
 						content: '/sysuser/edit',
 						area: ['600px', '500px']
 					});
				});
				
			    
			    
				$('#orgName').on('click', function() {
				    var varOffSet = $(this).offset();
				    $("#orgSelDiv").css({
				        left : varOffSet.left + "px",
				        top : varOffSet.top + $(this).outerHeight() + "px"
				    }).slideDown("fast");
	
				});
				
				form.on('submit(form-submit-btn)', function(data) {
					paging.get(
						data.field
					); 
				});
				
				ddtree.init({
		            treeid: "orgId",
		            url: "/sysorg/tree.json",
		            isMultiple: false,
		            chkboxType: {"Y": "ps", "N": "s"},
		            showLine: false
				});
			});
		</script>
	</body>

</html>
