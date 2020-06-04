		$(function(){resize();});
		window.onresize = resize;
		function resize(number){
			
			//页面布局：四个相同块田字结构分布
			number = 66;//
			var widthSize = (window.innerWidth);
			var heightSize = (window.innerHeight);
			$('.box_4-1').each(function(){
				$(this).css({width:widthSize,height:heightSize});
			});
			var box_4_1_h1_h=$('.box_4-1 h1').height();
			var tab_content_w=$('.box_4-1').width()-35;
			var tab_content_h=$('.box_4-1').height()-box_4_1_h1_h-34;
			$('.box_4-1 .tab_content').css({width:tab_content_w});
			$('.box_4-1 .tab_menu').css({width:tab_content_w+20});
			var n=$('.box_4-1 .tab_menu span').length;
			$('.box_4-1 .tab_menu span').css({width:(tab_content_w+8)/n});
			$('.box_4-1 .tab_content table td').css({width:(tab_content_w-20)/2});
			var n=$('.box_4-1 .tab_content table tr').length;
			$('.box_4-1 .tab_content table tr').css({height:(tab_content_h-n*2-35)/n});
			
			//页面布局：一块独立
			  //表格
			number = 50;
			widthSize = (window.innerWidth-number );
			heightSize = (window.innerHeight-number+15);
			$('.box_1-1').each(function(){
				$(this).css({width:widthSize,height:heightSize});
				$(this).find("table#table").css({width:widthSize});
				$(this).find("table#table caption").css({width:widthSize});
			});
			  //页面3.html中的信息列表宽度控制
			number = 40;
			widthSize = $('.box_1-1').width()-number;
			heightSize= $('.box_1-1').height()-number;
			$('.box_w1').each(function(){
				$(this).css({width:widthSize/3*1,height:heightSize});
				$(this).find("div.content").css({width:widthSize/3*1,height:heightSize-15});
				$(this).find("div.content,table.check_tbl,table.check_tbl caption").css({width:widthSize/3*1});
			});
			$('.box_w2').each(function(){
				$(this).css({width:widthSize/3*2+25,height:heightSize+30});
				$(this).find("div.box_w2_list_selected,div.box_w2_list").css({width:widthSize/3*2-6});
			});  
			  //页面5.html中的信息列表宽度控制
			number = 30;
			widthSize = $('.box_1-1').width()-number;
			
			$('.box_w3_selected').each(function(){
				$(this).css({width:widthSize});
			});
			$('.box_w3').each(function(){
				$(this).css({width:widthSize});
			});  
			
			//页面布局：一块 分三个选项菜单
			number = 21;
			var height_h1=$('.box_1-3 h1').height();
			widthSize = (window.innerWidth-number);
			heightSize = (window.innerHeight-number-height_h1-47);
			//tab标签的宽度，宽度平均分配
			var n=$('.box_1-3 .tab_menu span').length;
			widthSize_span=(window.innerWidth-number - n*2 -(n-1)*3)/n;
			
			$('.box_1-3').each(function(){
				$(this).css({width:widthSize,height:heightSize});
			});
			$('.box_1-3 .tab_menu').each(function(){
				$(this).css({width:widthSize});
			});
			$('.box_1-3 .tab_menu span').each(function(){
				$(this).css({width:widthSize_span});
			});
			$('.box_1-3 .tab_content').each(function(){
				$(this).css({width:widthSize-2,height:heightSize});
			});
			  //上1下3结构
			number = 37;
			$('.box_1-3 .tab_content .box_w3').each(function(){
				$(this).css({width:widthSize-number,height:(heightSize-number-27)/2});
			});
			$('.box_1-3 .tab_content .box_w1').each(function(){
				$(this).css({width:(widthSize-number-56)/3,height:(heightSize-number-27)/2});
			});
			  //左1右2结构
			number = 65;
			$('.box_1-3 .tab_content .box_h2').each(function(){
				$(this).css({width:(widthSize-number)/2,height:(heightSize-number+30)});
			});
			$('.box_1-3 .tab_content .box_h1').each(function(){
				$(this).css({width:(widthSize-number)/2,height:(heightSize-number+2)/2});
			});
			  //上1左1右2结构
			number = 37;
			var height_box_w3_detailed=$('.box_1-3 .tab_content .box_w3_detailed').height();
			$('.box_1-3 .tab_content .box_w3_detailed').each(function(){
				$(this).css({width:widthSize-number});
			});
			$('.box_1-3 .tab_content .box_h2_detailed').each(function(){
				$(this).css({width:(widthSize-number-28)/5*3,height:(heightSize-number-11-height_box_w3_detailed)});
			});
			$('.box_1-3 .tab_content .box_h1_detailed').each(function(){
				$(this).css({width:(widthSize-number-28)/5*2,height:(heightSize-number-39-height_box_w3_detailed)/2});
			});
			  //上1左4右1下1结构
			number = 37;
			var height_box_w3_dashboard=$('.box_1-3 .tab_content .box_w3_dashboard').height();
			$('.box_1-3 .tab_content .box_w3_dashboard').each(function(){
				$(this).css({width:widthSize-number});
			});
			$('.box_1-3 .tab_content .box_h2_dashboard').each(function(){
				$(this).css({width:(widthSize-number-57)/3,height:(heightSize-number-25-height_box_w3_dashboard*2)});
			});
			$('.box_1-3 .tab_content .box_h1_dashboard').each(function(){
				$(this).css({width:(widthSize-number-56)/3,height:(heightSize-number-53-height_box_w3_dashboard*2)/2});
			});
			
			  
			  //上1中1下1结构  
			number = 22;
			$('.box_1-3 .tab_content .box_w4_map').each(function(){
				$(this).css({width:widthSize-number,height:(heightSize-number-11-height_box_w3_detailed)});
				$(this).find("div.box_w4_h1_map").css({width:widthSize-number});
				$(this).find(".box_w4_h1_map .box_w1_h1_map_list").css({width:(widthSize-number-48)/4});
				var map_height=$(this).height();
				$(this).find("div.box_w4_h2_map").css({width:widthSize-number,height:map_height-130});
			});  
			  
			
			
			
			/*弹出下拉菜单 2013/6/28*/
			var w_w=$(window).width();
			var o_w=$("#drop_down_o_w").width();
			var o_l=(w_w - o_w)/2
			$("#drop_down_o_w").css({"left":o_l});
		}
		

