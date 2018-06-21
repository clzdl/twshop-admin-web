<%@page contentType="text/html;charset=utf-8" %>
<!DOCTYPE HTML>

<html>
  <%@ include file="/includes/head.jsp"%>
  <body>
		<div class="layui-layout layui-layout-admin">
			<div class="layui-header header header-demo">
				<div class="layui-main">
					<div class="admin-login-box">
						<a class="logo" style="left: 0;" href="/">
							<span style="font-size: 20px;">书法小状元管理系统</span>
						</a>
						<div class="admin-side-toggle">
							<i class="fa fa-bars" aria-hidden="true"></i>
						</div>
					</div>
					<ul class="layui-nav admin-header-item">
						<li class="layui-nav-item">
							<a href="javascript:;" class="admin-header-user">
								<img src="${domain_s }/admin/images/0.jpg" />
								<span>${userName }</span>
							</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="/logout"><i class="fa fa-sign-out" aria-hidden="true"></i> 注销</a>
								</dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
			<div class="layui-side layui-bg-black" id="admin-side">
				<div class="layui-side-scroll" id="admin-navbar-side" lay-filter="side"></div>
			</div>
			<div class="layui-body" style="bottom: 0;border-left: solid 2px #1AA094;" id="admin-body">
				<div class="layui-tab admin-nav-card layui-tab-brief" lay-filter="admin-tab">
					<ul class="layui-tab-title">
						<li class="layui-this">
							<i class="fa fa-dashboard" aria-hidden="true"></i>
							<cite>控制面板</cite>
						</li>
					</ul>
					<div class="layui-tab-content" style="min-height: 150px; padding: 5px 0 0 0;">
						<div class="layui-tab-item layui-show">
							<!-- <div style="float:left;width:50%"><iframe src="/report/order/list"></iframe></div> -->
						</div>
					</div>
					
				</div>
			</div>
		</div>	
		<script type="text/javascript" src="${domain_s }/admin/plugins/layui/layui.js"></script>
		<script type="text/javascript">
		layui.config({
			base: '${domain_s }/admin/js/'
		}).use(['element', 'layer', 'navbar', 'tab'], function() {
			var element = layui.element,
				$ = layui.jquery,
				layer = layui.layer,
				navbar = layui.navbar(),
				tab = layui.tab({
					autoRefresh: true,
					elem: '.admin-nav-card' //设置选项卡容器
				});
			//iframe自适应
			$(window).on('resize', function() {
				var $content = $('.admin-nav-card .layui-tab-content');
				$content.height($(this).height() - 147);
				$content.find('iframe').each(function() {
					$(this).height($content.height());
				});
			}).resize();

			//设置navbar
			navbar.set({
				spreadOne: true,
				elem: '#admin-navbar-side',
				cached: false,
				url: '/sysmenu/tree.json'
			});
			//渲染navbar
			navbar.render();
			//监听点击事件
			navbar.on('click(side)', function(data) {
				tab.tabAdd(data.field);
			});

			$('.admin-side-toggle').on('click', function() {
				var sideWidth = $('#admin-side').width();
				if(sideWidth === 200) {
					$('#admin-body').animate({
						left: '0'
					}); //admin-footer
					$('#admin-footer').animate({
						left: '0'
					});
					$('#admin-side').animate({
						width: '0'
					});
				} else {
					$('#admin-body').animate({
						left: '200px'
					});
					$('#admin-footer').animate({
						left: '200px'
					});
					$('#admin-side').animate({
						width: '200px'
					});
				}
			});
		});
		</script>
	</body>
</html>
