/// <reference path="../dep/assets/js/jquery.js" />
/// <reference path="../dep/assets/js/jquery.gritter.js" />

//#region 程序功能相关


//#region 消息提醒

function showErr(info) {
    var unique_id = $.gritter.add({
        title: '(T＿T)#',
        text: info,
        sticky: false,
        time: '2400',
        class_name: 'gritter-error'// + ($('.light-login').length === 0 ? '' : ' gritter-light')
    });
    return unique_id;
}

function showWarn(info) {
    var unique_id = $.gritter.add({
        title: '(-_-)',
        text: info,
        sticky: false,
        time: '2400',
        class_name: 'gritter-warning'// + ($('.light-login').length === 0 ? '' : ' gritter-light')
    });
    return unique_id;
}

function showInfo(info) {
    var unique_id = $.gritter.add({
        title: '\\^O^/',
        text: info,
        sticky: false,
        time: '2400',
        class_name: 'gritter-success'// + ($('.light-login').length === 0 ? '' : ' gritter-light')
    });
    return unique_id;
}

//#endregion 消息提醒


//#region 设置面包屑导航

function SetSecondCrumb(value) {
    $('#crumb2').html(value);
}

//#endregion 设置面包屑导航


//#region 激活导航菜单

function ActiveMenu(menuId) {
    $('#' + menuId).addClass("active");
}

function ActiveSubMenu(menuId) {
    var ele = document.getElementById(menuId);
    if (ele) {
        ele.className = "active";
        ele.parentNode.parentNode.className = "active open";
    }
}

//#endregion 激活导航菜单


//#endregion 程序功能相关



//#region 通用方法


//#region 编码解码

//create a in-memory div, set it's inner text(which jQuery automatically encodes)
//then grab the encoded contents back out.  The div never exists on the page.
function htmlEncode(value) {
    return $('<div/>').text(value).html();
}

function htmlDecode(value) {
    return $('<div/>').html(value).text();
}

//#endregion 编码解码



//#region UUID

function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c == 'x' ? r : (r & 0x7 | 0x8)).toString(16);
    });
    return uuid;
};

//#endregion UUID



//#region IE8之下无此方法

//OR jQuery.inArray( value, array [, fromIndex ] )  version added: 1.2
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (obj, start) {
        for (var i = (start || 0), j = this.length; i < j; i++) {
            if (this[i] === obj) { return i; }
        }
        return -1;
    }
}

//#endregion IE8之下无此方法





//#region 过滤HTML标签以及&nbsp;

function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
    str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
    str = str.replace(/\n[\s| | ]*\r/g, '\n'); //去除多余空行
    str = str.replace(/&nbsp;/ig, '');//去掉&nbsp;
    return str;
}

//#endregion 过滤HTML标签以及&nbsp;





//#endregion 通用方法