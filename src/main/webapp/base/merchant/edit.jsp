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
                        <input type="text" name="name" value="${entity.name }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
				</div>
				<div class="layui-form-item">
                    <label class="layui-form-label">LOGO</label>
                    <div class="layui-input-block">
                        <img alt="" src="${domain_img }${entity.logoUrl }" class="upload-file-img" style="width:30%;">
                        <input type="hidden" name="logoUrl"  value="${entity.logoUrl }" class="upload-file-hid">
                        <button type="button" class="layui-btn" id="upload-btn">
                          <i class="layui-icon">&#xe67c;</i>上传图片
                        </button>
                    </div>
                </div>
                <div class="layui-form-item">       
                    <label class="layui-form-label">联系人</label>
                    <div class="layui-input-block">
                        <input type="text" name="contactMan" value="${entity.contactMan }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">       
                    <label class="layui-form-label">联系电话</label>
                    <div class="layui-input-block">
                        <input type="text" name="contactPhone" value="${entity.contactPhone }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">地区</label>
                    <input type="hidden" name="cityCode" value="${entity.cityCode }"  lay-verify="required">
                    <div id="city-div">
                        <div class="layui-inline">
                        <select lay-filter="province"></select>
                        </div>
                        <div class="layui-inline">
                        <select lay-filter="city"></select>
                        </div>
                        <div class="layui-inline">
                        <select lay-filter="area"></select>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">       
                    <label class="layui-form-label">详细地址</label>
                    <div class="layui-input-block">
                        <input type="text" name="address" value="${entity.address }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">       
                    <label class="layui-form-label">维度</label>
                    <div class="layui-input-block">
                        <input type="text" name="latitude" value="${entity.latitude }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                <div class="layui-form-item">       
                    <label class="layui-form-label">经度</label>
                    <div class="layui-input-block">
                        <input type="text" name="longitude" value="${entity.longitude }"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                
                 <div class="layui-form-item">
                    <label class="layui-form-label">简介</label>
                    <div class="layui-input-block">
                        <textarea name="description"  lay-verify="required"  cols="100" rows="8" style="width:100%;height:400px;visibility:hidden;" ><c:out value="${entity.description}" escapeXml="true" /></textarea>
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
			}).use(['form', 'laydate','common','upload','city'], function() {
				var $ = layui.jquery,
				    form = layui.form,
				    laydate = layui.laydate,
					common = layui.common;			
				
				//监听提交
				form.on('submit(form-submit-btn)', function(data) {
					$.post('/merchant/save.json', data.field, function(res){
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
                handleImg();
                layui.upload.render({
                    elem:"#upload-btn",
                    url: '/file/upload.json',
                    ext: 'jpg|png|gif',
                    done: function(res){
                        var _parent = $("#upload-btn").parent();
                        _parent.find('img').attr('src', res.data.path);
                        _parent.find('img').show();
                        _parent.find('input[type="hidden"]').val(res.data.fileName);
                    }
                });  
                
                
                $('#city-div').citys({
                	code: '${entity.cityCode}',
                	dataUrl: '/area/citylist.json',
                    onChange:function(data){
                        $('input[name="cityCode"]').val(data['code']);
                	}
                });
			});
			
			KindEditor.ready(function(K) {
                var editor1 = K.create('textarea[name="description"]', {
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
