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
						<label class="layui-form-label">ID</label>
						<div class="layui-input-inline">
                            <input type="text" name="id"  placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
					</div>
					
					<a href="javascript:;" class="layui-btn layui-btn-small" lay-submit="" lay-filter="form-submit-btn">
						<i class="layui-icon">&#xe615;</i> 搜索
					</a>
					<a href="javascript:;" data-opt="add" class="layui-btn layui-btn-small" >
                        <i class="layui-icon">&#xe608;</i> 添加
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
									<th>类型</th>
									<th>APPID</th>
									<th>名称</th>
									<th>秘钥</th>
									<th>商户号</th>
									<th>商户支付秘钥</th>
									<th>回调地址</th>
									<th>TOKEN</th>
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
                <td>{{ item.appTypeOutput }}</td>
				<td>{{ item.appId }}</td>
				<td>{{ item.appName }}</td>
                <td>{{ item.appSecret }}</td>
                <td>{{ item.merchantPayNo }}</td>
                <td> {{ item.merchantPayKey }} </td>
                <td> {{ item.notifyUrl }} </td>
                <td> {{ item.token }} </td>
                <td> {{ item.createTimeOutput }} </td>
                <td>
                    <div class="layui-btn-group">
                    <a href="javascript:;" data-id="{{ item.id }}" data-opt="edit" class="layui-btn layui-btn-mini">编辑</a>
                    <a href="javascript:;" data-id="{{ item.id }}" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a>
                    </div>
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
					url: '/wxaccount/list.json', //地址
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
		 						content: '/wxaccount/toedit?accountId=' + id,
		 						area: ['700px', '500px']
		 					});
						});
						
						$('a[data-opt="del"]').on('click', function() {
							var id = $(this).attr('data-id');	
							layer.confirm('确定该操作吗？', {icon: 3, title:'提示'}, function(index){
								$.post('/wxaccount/deletebyid.json', {"accountId": id}, function(res){
									if(res.flag && res.flag === 1){
										paging.get(
                                            common.serializeObject($(".layui-form")),
                                            true
                                        );  
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
                    var id = $(this).attr('data-id');   
                    layer.open({
                        title: '编辑',
                        maxmin: true,
                        type: 2,
                        content: '/wxaccount/toedit?merchantId=${merchantId}',
                        area: ['700px', '500px']
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
