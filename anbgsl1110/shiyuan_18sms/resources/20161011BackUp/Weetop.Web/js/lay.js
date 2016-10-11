//消息弹出层
var Lay =
{
    showWarn: function (msgContent) {
        return layer.msg(msgContent, { icon: 0 });
    },
    showMsg: function (msgContent) {
        return layer.msg(msgContent, { icon: 1 });
    },
    showErr: function (msgContent) {
        return layer.msg(msgContent, { icon: 2 });
    },
    showLoading: function (msgContent) {
        return layer.msg(msgContent || '加载中', { icon: 16, shade: 0.3, time: 0 });
    },
    close: function (id) {
        layer.close(id);
    }
};