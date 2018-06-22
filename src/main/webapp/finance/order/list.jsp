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
                    <div class="layui-inline">
	                    <label class="layui-form-label">商户</label>
	                    <div class="layui-input-inline">
	                        <select name="merchantId">
	                            <option value="">--请选择--</option>
	                            <c:forEach var="result" items="${merchantList}" >
	                            <option value="${result.id }" >${result.name }</option>
	                            </c:forEach>
	                        </select>
	                    </div>
                    </div>
                    <a href="javascript:;" class="layui-btn layui-btn-small" lay-submit="" lay-filter="form-submit-btn">
                        <i class="layui-icon">&#xe615;</i> 搜索
                    </a>
				</div>
			</form>
				
			</blockquote>
			<fieldset class="layui-elem-field">
				<div class="layui-field-box">
					<div>
						<table class="site-table table-hover">
						  <colgroup>
						  <col>
						  <col>
						  <col>
						  <col width="100">
						  </colgroup>
							<thead>
								<tr>
									<th>ID</th>
									<th>用户</th>
                                    <th>商户</th>
									<th>购买类型</th>
									<th>购买对象</th>
									<th>金额</th>
									<th>支付方式</th>
									<th>支付状态</th>
									<th>支付时间</th>
									<th>状态</th>
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
                <td>{{ item.userId }}</td>
                <td>{{ item.merchantId }}</td>
				<td>{{ item.objTypeOutput}}</td>
                <td> {{ item.objId }} </td>
                <td> {{ item.payFeeOutput }} </td>
                <td> {{ item.payMethodOutput }} </td>
                <td> {{ item.payStatusOutput }} </td>
                <td> {{ item.payTimeOutput }} </td>
                <td> {{ item.statusOutput }} </td>
                <td> {{ item.createTimeOutput }} </td>
                <td>
                    <div class="layui-btn-group">
                    <a href="javascript:;" data-id="{{ item.id }}" data-opt="detail" class="layui-btn layui-btn-mini">详情</a>
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
					url: '/finance/order/list.json', //地址
					elem: '#con', //内容容器
					params: { //发送到服务端的参数
					},
					tempElem: '#conTemp', //模块容器
					pageConfig: { //分页参数配置
						elem: 'paged' //分页容器
					},
					fail: function(msg) { //获取数据失败的回调
					},
					complate: function() { //完成的回调
						$('a[data-opt="detail"]').on('click', function() {
                            var id = $(this).attr('data-id');   
                            layer.open({
                                title: '编辑',
                                maxmin: true,
                                type: 2,
                                content: '/finance/order/detail?orderId=' + id,
                                area: ['800px', '600px']
                            });
                        });
					}
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
