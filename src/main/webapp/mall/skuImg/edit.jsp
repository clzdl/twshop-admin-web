<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<input type="hidden" name="id" value="${ entity.id  }">
				<input type="hidden" name="skuId" value="${ entity.skuId }">
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">图片</label>
						<div class="layui-input-inline">
							<img alt="" src="${entity.imgUrlOutput }" class="upload-file-img" style="width:100%;">
							<input type="hidden" name="imgUrl"  value="${entity.imgUrl }" class="upload-file-hid">
							<button type="button" class="layui-btn" id="upload-square-btn">
							  <i class="layui-icon">&#xe67c;</i>上传图片
							</button>
							
						</div>
						<div class="layui-form-mid layui-word-aux">推荐尺寸:400*400</div>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">排序号</label>
					<div class="layui-input-inline">
						<input type="text" name="sortNo" value="${entity.sortNo }"  placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
                    <label class="layui-form-label">类型</label>
                    <div class="layui-input-inline">
                        <select name="imgType">
                            <option value="">--请选择--</option>
                            <c:forEach var="result" items="${imgTypeList}" >
                            <option value="${result.code }"  <c:if test="${entity.imgType == result.code }">selected="selected"</c:if> >${result.name }</option>
                            </c:forEach>
                        </select>
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
			}).use(['form', 'common','laytpl','upload'], function() {
				var $ = layui.jquery,
				    form = layui.form,
					layer = layui.layer,
					laytpl = layui.laytpl,
					common = layui.common;
				
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					$.post('/mall/skuimg/save.json', data.field, function(res){
						if(res.flag && res.flag === 1){
							var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							parent.layer.close(index); //再执行关闭 
							parent.layui.paging().get(common.serializeObject(parent.$(".layui-form")),true);
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
				
				// 处理图片显示
				function handleImg(){
					$(".upload-file-hid").each(function(){
						if($(this).val() && $(this).val() != ''){
							$(this).siblings("img").show();
						}else{
							$(this).siblings("img").hide();
						}
					});
				}
				
				// 上传图片的参数
				handleImg();
				layui.upload.render({
                    elem:"#upload-square-btn",
                    url: '/file/upload.json',
                    ext: 'jpg|png|gif',
                    done: function(res){
                        var _parent = $("#upload-square-btn").parent();
                        _parent.find('img').attr('src', res.data.path);
                        _parent.find('img').show();
                        _parent.find('input[type="hidden"]').val(res.data.fileName);
                    }
                }); 
			});
			
		</script>
	</body>
</html>
