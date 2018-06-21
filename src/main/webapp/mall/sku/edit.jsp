<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<input type="hidden" name="id" value="${ entity.id  }">
				<input type="hidden" name="itemId" value="${ entity.itemId }">
				
				<div class="layui-form-item">
					<label class="layui-form-label">名称</label>
					<div class="layui-input-block">
						<input type="text" name="title" value="${entity.title }"  placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
                    <label class="layui-form-label">库存</label>
                    <div class="layui-input-block">
                        <input type="text" name="quantity" value="${entity.quantity }"  placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">图片</label>
						<div class="layui-input-inline">
							<img alt="" src="${domain_img }${entity.imgUrl }" class="upload-file-img" style="width:100%;">
							<input type="hidden" name="imgUrl"  value="${entity.imgUrl }" class="upload-file-hid">
							<button type="button" class="layui-btn" id="upload-square-btn">
							  <i class="layui-icon">&#xe67c;</i>上传图片
							</button>
							
						</div>
						<div class="layui-form-mid layui-word-aux">推荐尺寸:400*400</div>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">价格</label>
						<div class="layui-input-inline">
							<input type="text" name="price" value="${entity.price }"  placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">市场价</label>
						<div class="layui-input-inline">
							<input type="text" name="marketPrice" value="${entity.marketPrice }"  placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
				
				<div class="layui-form-item">
					<div class="layui-inline">	
						<label class="layui-form-label">关键字</label>
						<div class="layui-input-inline">
							<input type="text" name="keyWord" value="${entity.keyWord }"  placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">排序号</label>
						<div class="layui-input-inline">
							<input type="text" name="sortNo" value="${entity.sortNo }"  placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
				
				<div class="layui-form-item">		
					<div class="layui-inline">
						<label class="layui-form-label">免运费</label>
						<div class="layui-input-inline">
							<select name="freePostfee" lay-filter="ispost-free-filter">
		 						<option value="">--请选择--</option>
		 						<c:forEach var="result" items="${yesOrNoList}" >
			 					<option value="${result.code }"  <c:if test="${entity.freePostfee == result.code }">selected="selected"</c:if> >${result.name }</option>
			 					</c:forEach>
		 					</select>
						</div>
					</div>
					<div class="layui-inline" id="postFee" style='<c:if test="${entity.freePostfee == 1 }"> display:none</c:if>'>
						<label class="layui-form-label">运费</label>
						<div class="layui-input-inline">
							<input type="text" name="postFee" value="${entity.postFee }"  placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
				
				
				<div class="layui-form-item">	
					<div class="layui-inline">	
						<label class="layui-form-label">首页推荐</label>
						<div class="layui-input-inline">
							<select name="recomendTag">
		 						<option value="">--请选择--</option>
		 						<c:forEach var="result" items="${yesOrNoList}" >
			 					<option value="${result.code }"  <c:if test="${entity.recomendTag == result.code }">selected="selected"</c:if> >${result.name }</option>
			 					</c:forEach>
		 					</select>
						</div>
					</div>
					<div class="layui-inline">		
						<label class="layui-form-label">精品</label>
							<div class="layui-input-inline">
								<select name="isSoul">
			 						<option value="">--请选择--</option>
			 						<c:forEach var="result" items="${yesOrNoList}" >
				 					<option value="${result.code }"  <c:if test="${entity.soulTag == result.code }">selected="selected"</c:if> >${result.name }</option>
				 					</c:forEach>
			 					</select>
							</div>
					</div>
				</div>
				
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">参与分销</label>
						<div class="layui-input-inline">
							<select name="distributeTag">
		 						<option value="">--请选择--</option>
		 						<c:forEach var="result" items="${yesOrNoList}" >
			 					<option value="${result.code }"  <c:if test="${entity.distributeTag == result.code }">selected="selected"</c:if> >${result.name }</option>
			 					</c:forEach>
		 					</select>
						</div>
					</div>
					<div class="layui-inline"> 
                        <label class="layui-form-label">状态</label>
                        <div class="layui-input-inline">
                            <select name="status">
                                <option value="">--请选择--</option>
                                <c:forEach var="result" items="${statusList}" >
                                <option value="${result.code }"  <c:if test="${entity.status == result.code }">selected="selected"</c:if> >${result.name }</option>
                                </c:forEach>
                            </select>
                        </div>
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
			}).use(['form', 'common','laytpl','upload','ddtree'], function() {
				var $ = layui.jquery,
				    form = layui.form,
					layer = layui.layer,
					laytpl = layui.laytpl,
					common = layui.common,
					ddtree = layui.ddtree();
				
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					$.post('/mall/item/save.json', data.field, function(res){
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
				
				form.on('select(ispost-free-filter)', function(data){
					if(data.value == 0){
						$("#postFee").show();
					}else{
						$("#postFee").hide();
					}
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
				
				function refreshCategory(merchantId){
					$.post('/mall/category/ddtreelist.json', {'merchantId':merchantId}, function(res){
			                  if(res.flag && res.flag === 1){
			                      ddtree.init({
			                          treeid: "categoryId",
			                          isMultiple: false,
			                          chkboxType: {"Y": "ps", "N": "s"},
			                          showLine: false,
			                          selId: "${entity.categoryId}",
			                          data: res.data
			                      });
			                      return true;
			                  }
			                  else {
			                      common.msgError(res.errorMsg);
			                  }
			              }, 'json');
				}
				if("" != '${entity.merchantId}'){
				    refreshCategory('${entity.merchantId}');
				}
				form.on('select(merchant-filter)', function(data){
					refreshCategory(data.value);
                }); 
				
			});
			
		</script>
	</body>
</html>
