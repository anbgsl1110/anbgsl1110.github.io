<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Weetop.Web.CMS.Login" %>

<!DOCTYPE html>

<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />

    <meta name="renderer" content="webkit" />

    <meta name="description" content="User login page" />

    <title>管理员登陆</title>


    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="/static/dep/assets/css/bootstrap.css" />
    <link rel="stylesheet" href="/static/dep/assets/css/font-awesome.css" />

    <link rel="stylesheet" href="/static/dep/assets/css/jquery.gritter.css" />

    <!-- text fonts -->
    <link rel="stylesheet" href="/static/dep/assets/css/ace-fonts.css" />

    <!-- ace styles -->
    <link rel="stylesheet" href="/static/dep/assets/css/ace.css" />

    <link href="/static/dep/validator/jquery.validator.css" rel="stylesheet" />

    <link href="/static/css/common.css" rel="stylesheet" />
</head>

<body class="login-layout blur-login">
    <div class="main-container">
        <div class="main-content">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <div class="login-container" style="margin-top: 99px;">
                        <div class="center">
                            <h1>
                                <span class="white" id="id-text2">网站后台管理系统</span>
                            </h1>
                            <sup id="id-ver" style="color: rgba(255, 255, 255, 0.2);"><sup><i>v2.0</i></sup></sup>
                            <h4 class="light-blue" id="id-company-text"><a href="http://www.weetop.com" target="_blank" style="text-decoration: none;">&copy; Weetop</a></h4>
                        </div>

                        <div class="space-6"></div>

                        <div class="position-relative">
                            <div id="login-box" class="login-box visible widget-box no-border">
                                <div class="widget-body">
                                    <div class="widget-main">

                                        <div class="space-6"></div>

                                        <form id="fmlogin">
                                            <fieldset>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <input type="text" id="txtUser" name="txtUser" maxlength="20" class="form-control" placeholder="用户名" />
                                                        <i class="ace-icon fa fa-user"></i>
                                                    </span>
                                                </label>

                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <input type="password" id="txtPwd" name="txtPwd" maxlength="20" class="form-control" placeholder="密码" />
                                                        <i class="ace-icon fa fa-lock"></i>
                                                    </span>
                                                </label>

                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <input type="text" id="valiCode" maxlength="4" name="valiCode" class="form-control" autocomplete="off" placeholder="验证码" style="padding-right: 110px;" />
                                                        <img src="/ashx/hd.ashx?ac=1" alt="验证码" title="点击更换验证码" style="position: absolute; right: 24px; top: 5px;" width="80" height="24" id="codeImg" onclick="this.src='/ashx/hd.ashx?ac=1&rnd=' + Math.random()" />
                                                        <i class="ace-icon fa fa-filter"></i>
                                                    </span>
                                                </label>

                                                <div class="space"></div>

                                                <div class="clearfix">
                                                    <%--<label class="inline">
                                                        <input type="checkbox" class="ace" />
                                                        <span class="lbl">记住我</span>
                                                    </label>--%>

                                                    <button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
                                                        <i class="ace-icon fa fa-key"></i>
                                                        <span class="bigger-110">登陆</span>
                                                    </button>
                                                </div>

                                                <div class="space-4"></div>
                                            </fieldset>
                                        </form>

                                    </div>
                                    <!-- /.widget-main -->

                                </div>
                                <!-- /.widget-body -->
                            </div>
                            <!-- /.login-box -->

                        </div>
                        <!-- /.position-relative -->

                        <div class="navbar-fixed-top align-right">
                            <br />
                            &nbsp;
                                <a id="btn-login-blur" href="javascript:">暗</a>
                            &nbsp;
                                <span class="blue">/</span>
                            &nbsp;
                                <a id="btn-login-light" href="javascript:">灰</a>
                            &nbsp; &nbsp; &nbsp; &nbsp;
                        </div>
                    </div>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.main-content -->
    </div>
    <!-- /.main-container -->

    <!-- basic scripts -->

    <!--[if !IE]><!-->
    <script type="text/javascript">
        window.jQuery || document.write("<script src='/static/dep/assets/js/jquery.js'>" + "<" + "/script>");
    </script>
    <!--<![endif]-->

    <!--[if IE]>
    <script type="text/javascript">
        window.jQuery || document.write("<script src='/static/dep/assets/js/jquery1x.js'>"+"<"+"/script>");
    </script>
    <![endif]-->

    <script type="text/javascript">
        if ('ontouchstart' in document.documentElement) document.write("<script src='/static/dep/assets/js/jquery.mobile.custom.js'>" + "<" + "/script>");
    </script>


    <!-- page specific plugin scripts -->
    <script src="/static/dep/assets/js/jquery.gritter.js"></script>
    <script src="/static/dep/validator/jquery.validator.js"></script>
    <script src="/static/dep/validator/local/zh-CN.js"></script>
    <script src="/static/dep/md5.min.js"></script>
    <script src="/static/js/common.js"></script>

    <!-- inline scripts related to this page -->
    <script type="text/javascript">

        if (typeof jQuery != 'undefined') {
            // jQuery is loaded => print the version
            console.log(jQuery.fn.jquery);
        }

        jQuery(function ($) {

            $('#btn-login-light').on('click', function (e) {
                $('body').attr('class', 'login-layout light-login');
                $('#id-text2').attr('class', 'grey');
                $('#id-company-text').attr('class', 'blue');
                $('#id-ver').css('color', 'rgba(0, 0, 0, 0.2)');
                e.preventDefault();
            });
            $('#btn-login-blur').on('click', function (e) {
                $('body').attr('class', 'login-layout blur-login');
                $('#id-text2').attr('class', 'white');
                $('#id-company-text').attr('class', 'light-blue');
                $('#id-ver').css('color', 'rgba(255, 255, 255, 0.2)');
                e.preventDefault();
            });


            //验证表单
            $('form#fmlogin').validator({
                stopOnError: true,
                theme: 'yellow_right_effect',
                fields: {
                    'txtUser': '用户名:required;username',
                    'txtPwd': '密码:required;password',
                    'valiCode': '验证码:required;length[4]'
                }
            }).on('valid.form', function (e, form) {

                $('form#fmlogin input').attr('readonly', 'readonly');
                $('button[type=submit]').addClass('disabled');

                $.post('', {
                    txtUser: $('#txtUser').val(),
                    txtPwd: md5($('#txtPwd').val()),
                    valiCode: $('#valiCode').val()
                }, function (jdata) {
                    switch (jdata.code) {
                        case 'OK':
                            showInfo(jdata.message);
                            setTimeout(function () {
                                window.location = '<%= ConfigurationManager.AppSettings["CMS"] %>';
                            }, 1000);
                            break;
                        case 'Err':
                            showErr(jdata.message);
                            $('#codeImg').click();
                            $('form#fmlogin input').removeAttr('readonly');
                            $('button[type=submit]').removeClass('disabled');
                            break;
                    }
                }, "json");

            });


        });
    </script>
</body>
</html>
