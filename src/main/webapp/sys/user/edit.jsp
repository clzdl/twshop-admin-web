<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<input type="hidden" name="id" value="${ entity.id  }">
				<input type="hidden" name="userPwd" value="${entity.userPwd }">
				<input type="hidden" name="userType" value="0">
				<div class="layui-form-item">		
					<label class="layui-form-label">姓名</label>
					<div class="layui-input-block">
						<input type="text" name="userName" value="${entity.userName}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">登录名</label>
					<div class="layui-input-block">
						<input type="text" name="userLogin" value="${ entity.userLogin }" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">邮箱</label>
					<div class="layui-input-inline">
						<input type="text" name="userEmail" value="${ entity.userEmail }" lay-verify="email" autocomplete="off" class="layui-input">
					</div>
				</div> 
				<div class="layui-form-item">
					<label class="layui-form-label">手机</label>
					<div class="layui-input-block">
						<input type="tel" name="userTel" value="${ entity.userTel }" lay-verify="phone" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">性别</label>
					<div class="layui-input-block">
						<input type="radio" name="userSex" value="1" title="男" <c:if test="${entity.userSex == 1 }">checked="schecked"</c:if> >
						<input type="radio" name="userSex" value="0" title="女" <c:if test="${entity.userSex == 0 }">checked="checked"</c:if> >
					</div>
				</div>
				<div class="layui-form-item">
                    <label class="layui-form-label">所属机构</label>
                    <div class="layui-input-block">
                         <div id="orgId" class="layui-form-select select-tree"></div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">商户</label>
                    <div class="layui-input-block">
                        <select name="merchantId">
                            <option value="">--请选择--</option>
                            <c:forEach var="result" items="${merchantList}" >
                            <option value="${result.id }"  <c:if test="${entity.merchantId == result.id }">selected="selected"</c:if> >${result.name }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">类型</label>
                    <div class="layui-input-block">
                        <select name="userType">
                            <option value="">--请选择--</option>
                            <c:forEach var="result" items="${userTypeList}" >
                            <option value="${result.code }"  <c:if test="${entity.userType == result.code }">selected="selected"</c:if> >${result.name }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
				<div class="layui-form-item">
					<label class="layui-form-label">角色</label>
					<div class="layui-input-block">
						<c:forEach items="${sysRoles }" var="result" >
		 				<input type="checkbox" name="roleIds" value="${result.id }" title="${result.roleName }" <c:if test="${result.checked }">checked="checked"</c:if>/>
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
		<script type="text/javascript" src="${domain_s }/admin/plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['form', 'layedit', 'laydate','common','ddtree'], function() {
				var $ = layui.jquery,
				    form = layui.form,
					layer = layui.layer,
					layedit = layui.layedit,
					common = layui.common,
					laydate = layui.laydate,
					ddtree = layui.ddtree();
				
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					var roleIds = "";
					$("input[name='roleIds']").each(function(){
						if($(this).prop("checked")){
							roleIds += $(this).val();
							roleIds += ",";
						}
					});
					if(roleIds.length > 0){
						roleIds = roleIds.substr( 0 , roleIds.length-1);
					}
					data.field.roleIds = roleIds;
					$.post('/sysuser/save.json', data.field, function(res){
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
				
				form.on('select(user-type-filter)', function(data){
					if(data.value == 1){
						$("#mer-div").show();
					}else{
						$("#mer-div").hide();
					}
				});      
				
				$.post('/sysorg/tree.json', {}, function(res){
                    if(res.flag && res.flag === 1){
                    	ddtree.init({
                            treeid: "orgId",
                            isMultiple: false,
                            chkboxType: {"Y": "ps", "N": "s"},
                            showLine: false,
                            selId: "${entity.orgId}",
                            data: res.data
                        });
                        return true;
                    }
                    else {
                        common.msgError(res.errorMsg);
                    }
                }, 'json');
				
			});
		</script>
	</body>
</html>
