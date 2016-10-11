
$(document).ready(function(){
		$("#zzsc").find(".pre").hide();//初始化为第一版
		var page=1;//初始化当前的版面为1
		var $show=$("#zzsc").find(".zzsc_box");//找到图片展示区域
		var page_count=$show.find("ul").length;
		var $width_box=$show.parents("#wai_box").width();//找到图片展示区域外围的div
		//显示title文字
		$show.find("li").hover(function(){
			$(this).find(".title").show();								
		},function(){
			$(this).find(".title").hide();
		})
		function nav(){
			if(page==1){
				$("#zzsc").find(".pre").hide().siblings(".next").show();
			}else if(page==page_count){
				$("#zzsc").find(".next").hide().siblings(".pre").show();
			}else{
				$("#zzsc").find(".pre").show().siblings(".next").show();
			}
		}
		$("#zzsc").find(".next").click(function(){
			//首先判断展示区域是否处于动画
			if(!$show.is(":animated")){
				$show.animate({left:'-='+$width_box},"normal");
				page++;
				nav();
				$number=page-1;
				$("#zzsc").find(".nav a:eq("+$number+")").addClass("now").siblings("a").removeClass("now");
				return false;
			}
		})
		$("#zzsc").find(".pre").click(function(){
		if(!$show.is(":animated")){
			$show.animate({left:'+='+$width_box},"normal");
			page--;
			nav();
			$number=page-1;
			$("#zzsc").find(".nav a:eq("+$number+")").addClass("now").siblings("a").removeClass("now");
			}
			return false;
		})
		$("#zzsc").find(".nav a").click(function(){
				$index=$(this).index();
				page=$index+1;
				nav();
				$show.animate({left:-($width_box*$index)},"normal");	
				$(this).addClass("now").siblings("a").removeClass("now");
				return false;
		})
						   
});
