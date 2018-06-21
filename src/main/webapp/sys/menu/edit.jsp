<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<input type="hidden" name="id" value="${ entity.id  }">
				<div class="layui-form-item">		
					<label class="layui-form-label">名称</label>
					<div class="layui-input-block">
						<input type="text" name="name" value="${entity.name}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">请求URI</label>
					<div class="layui-input-block">
						<input type="text" name="href" value="${entity.href }"  placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">显示图标</label>
					<div class="layui-input-inline">
						<input type="text" name="icon" value="<c:out value="${entity.icon }" />"  autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">菜单层级</label>
						<div class="layui-input-inline">
							<input type="radio" name="level" value="0" lay-filter="level-filter" <c:if test="${entity.parentId == null || entity.parentId == 0}">checked</c:if> title="一级"/>
							<input type="radio" name="level" value="1" lay-filter="level-filter" <c:if test="${entity.parentId > 0}">checked</c:if> title="二级"/>
						</div>
				</div>
			    <div class="layui-form-item" style="display:none" id="divSel">
					<label class="layui-form-label">一级菜单</label>
					<div class="layui-input-block " >
						<select name="parentId" lay-verify="" >
	 						<option value="">--请选择--</option>
	 						<c:forEach var="result" items="${firstMenuList }" >
		 					<option value="${result.id }" <c:if test="${entity.parentId == result.id }">selected="selected"</c:if> >${result.sdecorate }${result.name }</option>
		 					</c:forEach>
	 					</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">排序号</label>
					<div class="layui-input-inline">
						<input type="text" name="sortNo" value="${entity.sortNo }"  lay-verify="number" autocomplete="off" class="layui-input">
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
			}).use(['form', 'laydate','common'], function() {
				var $ = layui.jquery,
				    form = layui.form,
					layer = layui.layer,
					common = layui.common,
					laydate = layui.laydate;
			
				
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					if(data.field.parentId == ""){
						data.field.parentId = "0";
					}
					
					$.post('/sysmenu/save.json', data.field, function(res){
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
				
				form.on("radio(level-filter)",function(data){
					if(data.value == "0"){
						$("#divSel").css("display" , "none");
						$("select[name='parentId']").val("0");
					}else{
						$("#divSel").css("display" , "");
					}
				});
				
				
				var pId = ${entity.parentId == null?0:entity.parentId};
				if(pId > 0){
					$("#divSel").css("display" , "");
				}
				
			});
		
		</script>
	</body>
</html>
