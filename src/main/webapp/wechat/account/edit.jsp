<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<input type="hidden" name="id" value="${ entity.id  }">
				<input type="hidden" name="merchantId" value="${ entity.merchantId  }">
				<input type="hidden" name="accessToken" value="${ entity.accessToken  }">
				<input type="hidden" name="expiresIn" value="${ entity.expiresIn  }">
				<div class="layui-form-item">		
					<label class="layui-form-label">APPID</label>
					<div class="layui-input-block">
					   <input type="text" name="appId" value="${entity.appId }" lay-verify="required"  placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
                    <label class="layui-form-label">类型</label>
                    <div class="layui-input-block">
                        <select name="appType" lay-filter="ispost-free-filter">
                            <option value="">--请选择--</option>
                            <c:forEach var="result" items="${appTypeList}" >
                            <option value="${result.code }"  <c:if test="${entity.appType == result.code }">selected="selected"</c:if> >${result.name }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
				<div class="layui-form-item">       
                    <label class="layui-form-label">名称</label>
                    <div class="layui-input-block">
                       <input type="text" name="appName" value="${entity.appName }" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">       
                    <label class="layui-form-label">公众号秘钥</label>
                    <div class="layui-input-block">
                       <input type="text" name="appSecret" value="${entity.appSecret }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">       
                    <label class="layui-form-label">商户号</label>
                    <div class="layui-input-block">
                       <input type="text" name="merchantPayNo" value="${entity.merchantPayNo }" lay-verify="required"  placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                 <div class="layui-form-item">       
                    <label class="layui-form-label">商户支付秘钥</label>
                    <div class="layui-input-block">
                       <input type="text" name="merchantPayKey" value="${entity.merchantPayKey }" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                 <div class="layui-form-item">       
                    <label class="layui-form-label">回调地址</label>
                    <div class="layui-input-block">
                       <input type="text" name="notifyUrl" value="${entity.notifyUrl }" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">       
                    <label class="layui-form-label">TOKEN</label>
                    <div class="layui-input-block">
                       <input type="text" name="token" value="${entity.token }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
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
				    laydate = layui.laydate,
					common = layui.common;			
				
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					$.post('/wxaccount/save.json', data.field, function(res){
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
