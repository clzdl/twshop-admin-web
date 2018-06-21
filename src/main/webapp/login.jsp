<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <link rel="stylesheet" href="${domain_s }/admin/css/login.css" />
  <body class="beg-login-bg">
		<div class="beg-login-box">
			<header>
				<h1>系统登录</h1>
			</header>
			<div class="beg-login-main">
				<form action="" class="layui-form" method="get">
					<div class="layui-form-item">
						<label class="beg-login-icon">
                        <i class="layui-icon">&#xe612;</i>
                    	</label>
						<input type="text" name="userLogin" lay-verify="required" autocomplete="off" placeholder="这里输入登录名" class="layui-input">
					</div>
					<div class="layui-form-item">
						<label class="beg-login-icon">
                        <i class="layui-icon">&#xe642;</i>
                    	</label>
						<input type="password" name="userPwd" lay-verify="required" autocomplete="off" placeholder="这里输入密码" class="layui-input">
					</div>
                       
					
					<div class="layui-form-item">
						<div class="beg-pull-right">
                            <button class="layui-btn layui-btn-big layui-btn-primary layui-btn-radius"  lay-submit lay-filter="login">
                            	<i class="layui-icon">&#xe650;</i> 登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录
                            </button>
                            <input type="checkbox" name="rememberMe" title="记住我?" checked>
						</div>
						<div class="beg-clear"></div>
						
					</div>
				</form>
			</div>
			
		</div>
		
		<script type="text/javascript" src="${domain_s}/admin/plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['layer', 'form', 'common','md5'], function() {
				var layer = layui.layer,
					$ = layui.jquery,
					common = layui.common,
					form = layui.form;
				
				form.on('submit(login)',function(data){
					var data = {
							"userLogin": data.field.userLogin,
							"userPwdMd5":$.md5(data.field.userPwd),
							"rememberMe": data.field.rememberMe
					};
					
					$.post('/login.json', data, function(res){
						if(res.flag && res.flag === 1){
							location.href = '/';
							return true;
						}
						else {
							common.msgError(res.errorMsg);
						}
					}, 'json');
					
					return false;
				});
				
			 	if (window != top){
			  		top.location = self.location;
			  	}
			});
		</script>
	</body>

</html>
