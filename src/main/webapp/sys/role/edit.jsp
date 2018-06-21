<%@page contentType="text/html;charset=utf-8" %>


<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
<body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<input type="hidden" name="id" value='${entity.id }'/>
				<div class="layui-form-item">		
					<label class="layui-form-label">角色名称</label>
					<div class="layui-input-block">
						<input type="text" name="roleName" value="${entity.roleName}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">角色说明</label>
					<div class="layui-input-block">
						<input type="text" name="description" value="${ entity.description }" lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">菜单</label>
					
					<div class="layui-input-block" style="height:300px;overflow:auto">
						<input type="checkbox" id="checkAll" title="全选" lay-filter="checkAll"/>
						<c:forEach var="result" items="${sysMenus}" varStatus="status">
							<dd>
								<c:out value="${result.sdecorate }" escapeXml="false"></c:out>
								<input type="checkbox" class="menu${result.id }" name="menuIds"  lay-filter="menuCheck" title="${result.name }" data-opt="menu${result.parentId }" value="${result.id },${result.parentId }"/>
							</dd>
						</c:forEach>
					</div>
				</div>
				
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit="" lay-filter="form-submit-btn">立即提交</button>
						<button type="button" id="close" class="layui-btn layui-btn-primary">取消</button>
					</div>
				</div>
			</form>
		</div>
		<script type="text/javascript" src="${domain_s}/admin/plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['form', 'layedit', 'laydate','common'], function() {
				var $ = layui.jquery,
				    form = layui.form,
					layer = layui.layer,
					layedit = layui.layedit,
					common = layui.common,
					laydate = layui.laydate;
				
				function init(){
					var allFlag = true;
					$(":checkbox[name='menuIds']").each(function(){
			  			
						var id_value = $(this).val().split(",")[0];
			  			var pId_value = $(this).val().split(",")[1];
			  			var flag = false;
			  			<c:forEach items="${sysRoleMenus }" var="result">
			  			
			  				if(parseInt(${result.sysMenu.id }) === parseInt(id_value)){
				  		 		$(this).prop("checked" , true);
				  		 		flag = true;
			  				}
			  			</c:forEach>
			  			
			  			if(!flag){
			  				allFlag = false;
			  			}
				  	});
					
					if(allFlag ){
						$("#checkAll").prop("checked" , true);
					}
					form.render('checkbox');
				}
				
				init();
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					
					var menuSysIds = "";
					$(":checkbox[name='menuIds']").each(function(){
				    	if($(this).prop("checked")){
				    		menuSysIds += $(this).val().split(",")[0];
				    		menuSysIds += ",";
				    	}
				  	});
					
					if(0 >= menuSysIds.length){
						common.msgError("请选择角色权限");
						return false;
					}
					
					var data= {
							"id":data.field.id,
							"menuIds":menuSysIds,
							"roleName":data.field.roleName,
							"description":data.field.description
					};
					
					$.post('/sysrole/save.json', data, function(res){
							if(res.flag && res.flag === 1){
								var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
								parent.layer.close(index); //再执行关闭 
								parent.location.reload(); 
								return true;
							}
							else {
								common.msgError(res.errorMsg);
							}
					}, 'json');
					
					return false;
				});
				
				$('#close').on('click', function() {
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭 
				});
				
				form.on('checkbox(checkAll)', function(data){
					if(data.elem.checked){
						$(":checkbox[name='menuIds']").each(function(){
							$(this).prop("checked" , true);
						});
					}else{
						$(":checkbox[name='menuIds']").each(function(){
							$(this).prop("checked" , false);
						});
					}
					form.render("checkbox");
				});
				////
				form.on('checkbox(menuCheck)', function(data){
					
		  			var id_value = data.value.split(",")[0];
		  			var pId_value = data.value.split(",")[1];
		  			
		  			if(pId_value != '0'){
		  				///child node
		  				///must use prop ,don't attr , why ??
		  				///change parent status
		  				if(!$('.menu'+pId_value).prop('checked')){
		  					$('.menu'+pId_value).prop('checked' , true);
		  				}else{
		  					//judge other child statud
		  					var flag = false;
		  					$(":checkbox[data-opt=menu" + pId_value + "]").each(function(){
		  						
		  						if($(this).prop('checked')){
		  							console.log( $(this).prop('checked'));
		  							flag = true;
		  							//// stop loop 
		  							return false;
		  						}
		  					});
		  					if(!flag){
		  						$('.menu'+pId_value).prop('checked' , false);
		  					}
		  				}
		  			}else{
		  				//parent change child status 
		  				if(data.elem.checked ){
		  					$(":checkbox[data-opt='menu"+id_value+"']").prop('checked' , true);
		  				}
		  				else{
		  					data.value.checked = false;
		  					$(":checkbox[data-opt='menu"+id_value+"']").prop('checked' , false);
		  				}
		  			}
		  			form.render('checkbox');
				});        
				
			});
		</script>
	</body>

</html>
