//当前充值被选中
window.CurProId = 0;

//重新计算左导航高度
function reHeight() {
    var rheight = $("#hy_right").height();
    $("#hy_left1").css("height", rheight + "px");
}

//获取路由字符串
function getPattern() {
    var pathname = window.location.pathname;
    //console.debug(pathname);
    var reg = /\/member\/(\w+)/i;
    reg.test(pathname);
    var route = RegExp.$1;
    //console.debug(route);
    return route.toLowerCase();
}

//高亮菜单
function lightOn(m1, m2) {
    var nav1 = $('.hy_left1 a');
    nav1.eq(m1 - 1).addClass('on').parent().siblings().children('a').removeClass('on');
    var subm = $('.hy_left2 .submenu');
    subm.eq(m1 - 1).fadeIn().siblings().hide();
    var nav2 = $('.hy_left2 .submenu' + m1 + ' a');
    nav2.eq(m2 - 1).addClass('on').parent().siblings().children('a').removeClass('on');
}
function highLight() {

    reHeight();//重新计算左导航高度

    var route = getPattern();//获取路由字符串
    switch (route) {
        case 'account':
            lightOn(1, 1);
            $('title').text('账户管理 - 示远科技');
            break;
        case 'auth':
            lightOn(1, 2);
            $('title').text('认证信息 - 示远科技');
            break;
        case 'recharge':
            lightOn(1, 3);
            $('title').text('充值 - 示远科技');
            break;
        case 'invoice':
            lightOn(1, 4);
            $('title').text('开发票 - 示远科技');
            break;
        case 'award':
            lightOn(1, 5);
            $('title').text('中奖信息 - 示远科技');
            break;
        case 'signtemplate':
            lightOn(2, 1);
            $('title').text('签名模板管理 - 示远科技');
            break;
        case 'smstemplate':
            lightOn(2, 2);
            $('title').text('短信模板管理 - 示远科技');
            break;
        case 'sensitiveword':
            lightOn(2, 3);
            $('title').text('敏感词查询 - 示远科技');
            break;
        case 'smscount':
            lightOn(3, 1);
            $('title').text('验证码发送统计 - 示远科技');
            break;
        case 'intercount':
            lightOn(3, 2);
            $('title').text('国际验证码统计 - 示远科技');
            break;
        case 'voicecount':
            lightOn(3, 3);
            $('title').text('语音短信统计 - 示远科技');
            break;
        case 'rechargelist':
            lightOn(4, 1);
            $('title').text('充值记录详细单 - 示远科技');
            break;
        case 'invoicelist':
            lightOn(4, 2);
            $('title').text('发票申请信息 - 示远科技');
            break;
        case 'consultsrv':
            lightOn(5, 1);
            $('title').text('服务中心 - 示远科技');
            break;
        case 'guide':
            lightOn(6, 1);
            $('title').text('新手指引 - 示远科技');
            break;
    }
}
