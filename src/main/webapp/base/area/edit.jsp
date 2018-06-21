<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<input type="hidden" name="id" value="${ entity.id  }">
				<input type="hidden" name="parentId" value="${ parentId  }">
				<input type="hidden" name="parentCode" value="${ entity.parentCode  }">
				<input type="hidden" name="areaCode" value="${ entity.areaCode  }">
				<input type="hidden" name="areaType" value="${ entity.areaType  }">
				<div class="layui-form-item">		
					<label class="layui-form-label">名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="areaName" value="${entity.areaName }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
				</div>
				<div class="layui-form-item">       
                    <label class="layui-form-label">排序号</label>
                    <div class="layui-input-block">
                        <input type="text" name="sortNo" value="${entity.sortNo }"  lay-verify="required"   placeholder="请输入" autocomplete="off" class="layui-input">
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
		<script type="text/javascript" src="${domain_s }/admin/kindeditor/kindeditor.js"></script>
        <script type="text/javascript" src="${domain_s }/admin/kindeditor/lang/zh_CN.js"></script>
        <script type="text/javascript" src="${domain_s }/admin/kindeditor/plugins/code/prettify.js"></script>
        
		<script>
			layui.config({
				base: '${domain_s}/admin/js/'
			}).use(['form', 'laydate','common','upload'], function() {
				var $ = layui.jquery,
				    form = layui.form,
				    laydate = layui.laydate,
					common = layui.common;			
				
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					$.post('/area/save.json', data.field, function(res){
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
				
			});
			
		</script>
	</body>
</html>
