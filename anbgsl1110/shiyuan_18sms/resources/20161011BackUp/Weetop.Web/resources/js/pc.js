
 /************【合作伙伴轮播】*************/
function DY_scroll(jt_prev,jt_next,li,speed,or)
 { 
  var prev = $(jt_prev);
  var next = $(jt_next);
  var li = $('.rongyu').find('ul');
  var w = li.find('li').outerWidth(true);
  var dist=0;
  var s = speed;
  var maxSize=-w*(li.find('li').size()-1);
  next.click(function()
       {
		   if(dist>maxSize)
			{
			   dist-=w;
			   
				li.stop(true).animate({'margin-left':dist});
			}
        });
  prev.click(function()
       {
        if(dist<0)
		{
			dist+=w;
        	li.stop(true).animate({'margin-left':dist});
        	//img.animate({'margin-left':0});
		}
        });

 }
 DY_scroll('.jt_prev','.jt_next','.rongyu',1,false);// true为自动播放，不加此参数或false就默认不自
 /************【合作伙伴轮播】*************/
 
 
/*****右侧随滚动客户等。。。。*****/
function Mouseevents(obj2){
	$(obj2).each(function(){
		var theSpan = $(this);
		var theMenu = theSpan.find("div.fdlayer");
		var tarHeight = theMenu.height();
		theMenu.css({height:0,opacity:0});
		theSpan.hover(
			function(){
				theMenu.stop().show().animate({height:tarHeight,opacity:1},200);
			},
			function(){
				theMenu.stop().animate({height:0,opacity:0},200,function(){
					$(this).css({display:"none"});
				});
			}
		);
	});
};

$(document).ready(function(){
	Mouseevents(".ficon04");
});