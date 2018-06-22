<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<div class="layui-form-item">
					<label class="layui-form-label">用户</label>
					<div class="layui-input-block">
						<input type="text" value="${entity.userId }"  readonly="readonly" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
                    <label class="layui-form-label">商户</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.merchantId }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
				<div class="layui-form-item">
                    <label class="layui-form-label">购买类型</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.objTypeOutput }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">购买对象</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.objId }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">总费用</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.totalFeeOutput }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">总优惠</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.discountFeeOutput }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">支付费用</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.payFeeOutput }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">支付方式</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.payMethodOutput }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">支付状态</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.payStatusOutput }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">支付时间</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.payTimeOutput }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">邮寄地址</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.deliverAddr }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">快递类型</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.expressTypeOutput }"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">快递单号</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.expressNo}"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-block">
                        <textarea readonly="readonly" class="layui-textarea">${entity.remark}</textarea>
                    </div>
                </div>
                
                 <div class="layui-form-item">
                    <label class="layui-form-label">状态</label>
                    <div class="layui-input-block">
                        <input type="text" value="${entity.statusOutput}"  readonly="readonly" autocomplete="off" class="layui-input">
                    </div>
                </div>
			</form>
		</div>
	</body>
</html>
