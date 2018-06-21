<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE HTML>
<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div style="margin: 15px;">
			<form class="layui-form" action="">
				<input type="hidden" name="id" value="${ entity.id  }">
				<input type="hidden" name="bgcolor" value="${ entity.bgcolor  }">
				<div class="layui-form-item">       
                    <label class="layui-form-label">类型</label>
                     <div class="layui-input-block">
                        <select name="kind" lay-verify="required">
                            <option value="">--请选择--</option>
                            <c:forEach var="result" items="${kindList }" >
                              <option value="${result.code }"  <c:if test="${entity.kind == result.code }">selected="selected"</c:if> >${result.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">BANNER图</label>
                    <div class="layui-input-block">
                        <img alt="" src="${domain_img }${entity.pic }" class="upload-file-img" style="width:30%;">
                        <input type="hidden" name="pic" lay-verify="required"  value="${entity.pic }" class="upload-file-hid">
                        <button type="button" class="layui-btn" id="upload-btn">
                          <i class="layui-icon">&#xe67c;</i>上传图片
                        </button>
                    </div>
                </div>
				<div class="layui-form-item">		
					<label class="layui-form-label">链接</label>
					<div class="layui-input-block">
					   <textarea name="href" required lay-verify="required" placeholder="请输入" class="layui-textarea">${entity.href }</textarea>
					</div>
				</div>
				
				<div class="layui-form-item">       
                    <label class="layui-form-label">发布状态</label>
                     <div class="layui-input-block">
                        <select name="publishFlag" lay-verify="required">
                            <option value="">--请选择--</option>
                            <c:forEach var="result" items="${publishFlagList }" >
                              <option value="${result.code }"  <c:if test="${entity.publishFlag == result.code }">selected="selected"</c:if> >${result.name}</option>
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
					$.post('/banner/save.json', data.field, function(res){
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
                var uploadOptions = {
                    elem:"#upload-btn",
                    url: '/file/upload.json',
                    ext: 'jpg|png|gif',
                    done: function(res){
                        var _parent = $("#upload-btn").parent();
                        _parent.find('img').attr('src', res.data.path);
                        _parent.find('img').show();
                        _parent.find('input[type="hidden"]').val(res.data.fileName);
                    }
                };
                handleImg();
                layui.upload.render(uploadOptions);  
			});
			
			KindEditor.ready(function(K) {
                var editor1 = K.create('textarea[name="activityDetail.detail"]', {
                    items:["source", "|", "justifyleft", "justifycenter", "justifyright", "justifyfull", "insertorderedlist", "insertunorderedlist", "indent", "outdent", "|",  "formatblock", "fontname", "fontsize", "|", "forecolor", "hilitecolor", "bold", "italic", "underline", "strikethrough", "lineheight", "|", "image","multiimage", "table", "hr", "baidumap",  "link", "unlink","clearhtml"],
                    cssPath : '${domain_s }/admin/kindeditor/plugins/code/prettify.css',
                    uploadJson : '/kindeditor/file/upload.json',
                    allowImageUpload  : true,//运行上传图片
                    fileManagerJson : '/kindeditor/file/manager.json',
                    allowFileManager : true,
                    afterCreate : function() {
                        this.sync(); 
                    },
                    afterBlur:function(){ 
                        this.sync(); 
                    }   
                });
                prettyPrint();
            });
		
		</script>
	</body>
</html>
