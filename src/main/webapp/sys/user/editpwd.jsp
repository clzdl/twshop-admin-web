<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<div class="layui-form-item">		
					<label class="layui-form-label">旧密码</label>
					<div class="layui-input-block">
						<input type="password" name="oldPwd" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">新密码</label>
					<div class="layui-input-block">
						<input type="password" name="newPwd" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">确认新密码</label>
					<div class="layui-input-block">
						<input type="password" name="newPwd1"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit="" lay-filter="form-submit-btn">立即提交</button>
						<button type="button" id="close" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['form', 'layedit', 'laydate','md5','common'], function() {
				var $ = layui.jquery,
				    form = layui.form,
					layer = layui.layer,
					common = layui.common,
					layedit = layui.layedit,
					laydate = layui.laydate;
				
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					
					do{
						if(data.field.newPwd != data.field.newPwd1){
							common.msgError("两次密码不一致!");
							break;
						}
						var jsonData={
								"oldPwd": $.md5(data.field.oldPwd),
								"newPwd": $.md5(data.field.newPwd)
						};
						$.post('/sysuser/editpwd.json', jsonData , function(res){
							if(res.flag && res.flag === 1){
								parent.location.href = "/logout";
								return true;
							}
							else {
								common.msgError(res.errorMsg);
							}
						}, 'json');
					}while(false);
					return false;
				});
				$('#close').on('click', function() {
					$(":input[name='oldPwd']").val("");
					$(":input[name='newPwd']").val("");
					$(":input[name='newPwd1']").val("");
				});
				
			});
		</script>
	</body>
</html>
