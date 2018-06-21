<%@page contentType="text/html;charset=utf-8" %>


<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div class="admin-main">
			<blockquote class="layui-elem-quote">
			<form class="layui-form">
				<div class="layui-form-item">
					<a href="javascript:;" data-opt="clear-m-web" class="layui-btn layui-btn-small" >
                        <i class="layui-icon">&#xe639;</i> 清理缓存
                    </a>
				</div>
			</form>
				
			</blockquote>
		</div>
		<script type="text/javascript" src="${domain_s}/admin/plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['paging', 'code', 'layer','common','form'], function() {
				layui.code();
				var $ = layui.jquery,
					common = layui.common;

				$('a[data-opt="clear-m-web"]').on('click', function() {
                    layer.confirm('确定该操作吗？', {icon: 3, title:'提示'}, function(index){
                        $.post('/cache/clearmweb.json', {}, function(res){
                            if(res.flag && res.flag === 1){
                            	common.msgSuccess("清理成功!"); 
                            }
                            else {
                                common.msgError(res.errorMsg);
                            }
                        }, 'json');
                    });
                });
			});
		</script>
	</body>

</html>
