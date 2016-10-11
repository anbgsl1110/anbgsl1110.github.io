$(document).ready(function () {
    //份数计数框事件
    var MAX_NUM = 1000;

    $('.num_minus').css('cursor', 'pointer');
    $('.num_plus').css('cursor', 'pointer');
    $('.num_minus').live('click', function () {
        var txtnum = $(this).next('input');
        var num = CheckNum(txtnum.val());
        if (num-- <= 1) num = 1;
        if (num >= MAX_NUM) num = MAX_NUM;
        txtnum.val(num);
    });
    $('.num_plus').live('click', function () {
        var txtnum = $(this).prev('input');
        var num = CheckNum(txtnum.val());
        if (num++ >= MAX_NUM) num = MAX_NUM;
        txtnum.val(num);
    });
    $('#txtCount, #txtKuan').live('blur', function () {
        var num = CheckNum($(this).val());
        if (num <= 1) num = 1;
        if (num >= MAX_NUM) num = MAX_NUM;
        $(this).val(num);
    });
    //检查并转换数字
    function CheckNum(value) {
        if (!isNaN(value)) {
            return parseInt(value, 10);
        } else {
            return 1;
        }
    }
})