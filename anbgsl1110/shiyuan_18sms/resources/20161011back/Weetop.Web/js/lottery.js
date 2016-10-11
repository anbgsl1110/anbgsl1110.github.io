$(function () {
    var chnums = $("#ContentPlaceHolder1_chnum").html();
    $(".cgb").click(function () {
        alert("您还未提交信息，请填写信息并确定");
    });
    $.get("Lottery.aspx", { action: "wi" }, function (data) {
        //设置总数量
        $("#countUsr").html(data.message);
        $.each(data.data, function (index, item) {
            $("#demo1").append('<li><div id="pn" >' + item.Phone + '</div><div id="pp">' + item.WinningPrizeName + '</div><div id="pd">' + item.Datetim + '</div></li>');
        });
    }, "json");

    //向后台提交中奖用户信息


    $('.list li:even').css('background', '#313131');
    $('.list li:odd').css('background', '#404040');
    var input = $(".phone")[0];
    input.onfocus = function () {
        if (input.value == "请输入手机号") {
            input.value = "";
        };
    }
    input.onblur = function () {
        if (input.value == "") {
            input.value = "请输入手机号";
        };
    }

    /*滚动*/
    var speed = 40
    var demo = document.getElementById("demo");
    var demo2 = document.getElementById("demo2");
    var demo1 = document.getElementById("demo1");
    demo2.innerHTML = demo1.innerHTML;
    function Marquee() {
        if (demo2.offsetTop - demo.scrollTop <= 859)

            demo.scrollTop -= demo1.offsetHeight
        else {
            demo.scrollTop++;
        }
    }
    var MyMar = setInterval(Marquee, speed)
    demo.onmouseover = function () { clearInterval(MyMar) }
    demo.onmouseout = function () { MyMar = setInterval(Marquee, speed) }

    //抽奖随机滚动
    var lottery = {
        index: -1,	//当前转动到哪个位置，起点位置
        count: 0,	//总共有多少个位置
        timer: 0,	//setTimeout的ID，用clearTimeout清除
        speed: 100,	//初始转动速度
        times: 0,	//转动次数
        cycle: 50,	//转动基本次数：即至少需要转动多少次再进入抽奖环节

        prize: -1,	//中奖位置
        prizeName: "iphone7", //奖品名称
        retimes: 0, //剩余次数
        phone: "189****1234", //中奖号码
        date: "2016/10/09", //中奖日期
        init: function (id) {
            if ($("#" + id).find(".lottery-unit").length > 0) {
                $lottery = $("#" + id);
                $units = $lottery.find(".lottery-unit");
                this.obj = $lottery;
                this.count = $units.length;
                $lottery.find(".lottery-unit-" + this.index).addClass("active");
            };
        },
        roll: function () {
            var index = this.index;
            var count = this.count;
            var lottery = this.obj;
            $(lottery).find(".lottery-unit-" + index).removeClass("active");
            index += 1;
            if (index > count - 1) {
                index = 0;
            };
            $(lottery).find(".lottery-unit-" + index).addClass("active");
            this.index = index;
            return false;
        },
        stop: function (index) {
            this.prize = index;
            return false;
        }
    };
    function roll() {
        lottery.times += 1;
        lottery.roll();
        if (lottery.times > lottery.cycle + 10 && lottery.prize == lottery.index) {
            var x = lottery.prize;
            popUp(lottery.prize, lottery.prizeName, lottery.phone, lottery.retimes, lottery.date);
            clearTimeout(lottery.timer);
            lottery.prize = -1;
            lottery.times = 0;
            click = false;

        } else {
            if (lottery.times < lottery.cycle) {
                lottery.speed -= 10;
            } else if (lottery.times == lottery.cycle) {
                var index = lottery.prize | 0;
                lottery.prize = index;
            } else {
                if (lottery.times > lottery.cycle + 10 && ((lottery.prize == 0 && lottery.index == 7) || lottery.prize == lottery.index + 1)) {
                    lottery.speed += 110;
                } else {
                    lottery.speed += 20;
                }
            }
            if (lottery.speed < 40) {
                lottery.speed = 40;
            };
            lottery.timer = setTimeout(roll, lottery.speed);
        }
        return false;
    }
    var click = false;
    window.onload = function () {
        lottery.init('left');
        $("#start").click(function () {
            $(".coverf").css({ display: "block" });
            if (click) {
                return false;
            } else {
                lotterys();
            }
        });
        function lotterys() {
            $.get("Lottery.aspx", { action: "lt" }, function (data) {
                if (data.code === "OK") {
                    var arr = data.message.split(",");
                    lottery.speed = 200;
                    lottery.prize = arr[0];
                    lottery.prizeName = arr[1];
                    lottery.retimes = arr[2];
                    lottery.phone = arr[3];
                    lottery.date = arr[4];
                    $("#ContentPlaceHolder1_dateTimes").val(arr[5]);
                    $("#ContentPlaceHolder1_chnum").html(arr[2]);
                    roll();
                    click = true;
                    $(".show").html("正在抽奖");
                    return false;
                } else {

                    $(".coverf").css({ display: "none" });
                    alert(data.message);
                }
            }, "json");
        }
    };

    function popUp(p, x, y, z, d) {
        setTimeout(function () {
            //测试
            var he = $(document.body).height() - 200;
            $(".sj_mask").css("height", he + "px");
            $(".sj_mask").css("display", "block");
            //弹出层效果
            $('.btn_gb').click(function () {
                $('.sj_mask').css("display", "none");
                $(".sj_form").css("display", "none");
                $(".sj_form2").css("display", "none");
                $(".coverf").css({ display: "none" });
                $('.form_bottom').css("display", "none");
                $('.form_bottom2').css("display", "none");
                $('.form_bottom3').css("display", "none");
                if (z > 0) {
                    $(".show").html("继续抽奖");
                } else {
                    $(".show").html("感谢参与");
                }
                //$("#demo1").append('<li><div id="pn" >' + y + '</div><div id="pp">' + x + '</div><div id="pd">' + d + '</div></li>');
            });
            console.log(p);
            if (p == 0 || p == 3 || p == 8) {
                $(".ts span").html(y);
                $(".ts label").html(x);
                $('.dj').click(function () {
                    console.log(p);
                    if (p == 0) {
                        $('.form_bottom').css("display", "block");
                    } else if (p == 3) {
                        $('.form_bottom3').css("display", "block");
                        $(".color li").click(function () {
                            var miniArr = ["银色", "深空灰"];
                            $(this).css("background", 'url("../images/xz.png")').siblings().css("background", 'url("../images/wxz.png")');
                            $("#michco").val(miniArr[$(this).index()]);
                        });
                    } else {
                        $('.form_bottom2').css("display", "block");
                        $(".color li").click(function () {
                            var earArr = ["黑色", "白色", "金色", "红色", "灰色", "银色", "玫瑰金", "蓝色"];
                            $(this).css("background", 'url("../images/xz.png")').siblings().css("background", 'url("../images/wxz.png")');
                            $("#earchco").val(earArr[$(this).index()]);
                        });
                    }
                });
                $(".sj_form").css("display", "block");
                //实物奖品，iPhone，iPad，beats
                $(".sure").click(function () {
                    var name;
                    var tell;
                    var job;
                    var co;
                    var add;

                    switch (p) {
                        case 0:
                            name = $(".name1").val();
                            tell = $(".tell1").val();
                            job = $(".job1").val();
                            co = $(".co1").val();
                            add = $(".add1").val();
                            break;
                        case 3:
                            name = $(".name3").val() + $("#michco").val();
                            tell = $(".tell3").val();
                            job = $(".job3").val();
                            co = $(".co3").val();
                            add = $(".add3").val();
                            break;
                        case 8:
                            name = $(".name2").val() + $("#earchco").val();
                            tell = $(".tell2").val();
                            job = $(".job2").val();
                            co = $(".co2").val();
                            add = $(".add2").val();
                            break;
                        default:

                    }

                    $.get("Lottery.aspx", { action: "ut", type: "s", name: name, tel: tell, job: job, co: co, add: add, dates: $("#ContentPlaceHolder1_dateTimes").val() }, function (data) {
                        if (data.code == "OK") {
                            alert(data.message);
                            $('.btn_gb').click();
                        }

                    }, "json");
                });

            } else {
                $("#user").html(y);
                $("#awards").html(x);
                $(".sj_form2").css("display", "block");
                //虚拟奖品，话费流量
                $("#vsure").click(function () {
                    var reg = /^1[3578]\d{9}$/g;
                    if (reg.test($(this).prev().val())) {
                        $.get("Lottery.aspx", { action: "ut", type: "x", tel: $(".phone").val(), dates: $("#ContentPlaceHolder1_dateTimes").val() }, function (data) {
                            if (data.code == "OK") {
                                alert(data.message);
                                $('.btn_gb').click();
                                $(".phone").val("");
                            }

                        }, "json");

                    } else {
                        alert("号码格式不正确");
                    }
                });
            }
        }, 500);

    }

});





