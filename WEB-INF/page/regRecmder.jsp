<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="renderer" content="webkit" />
    <title>班步合伙人</title>
    <jsp:include page="inc/header.jsp"></jsp:include>
    <style type="text/css">
        .modal-sm {
            width: 360px;
        }
    </style>
</head>
<body class="mini-navbar">
<div id="wrapper">


    <div id="page-wrapper" class="gray-bg" style="margin: 0;">

        <div class="row wrapper border-bottom white-bg page-heading" style="background: #ffffff;">
            <div class="col-lg-12">
                <h2><span id="breadcrumbsTitle" style="color: #242A30;">注册班步合伙人</span></h2>
            </div>
        </div>

        <div class="wrapper wrapper-content animated fadeInRight">
            <form id="pageForm">
                <div class="row">
                    <div class="col-lg-12">

                        <div class="ibox m-b-none">
                            <div class="ibox-content">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">*手机：</label>
                                        <div class="col-lg-3">
                                            <input id="mobileNumber" name="loginId" type="text" class="form-control" placeholder="输入手机号码" data-rule-requiredEx="true" data-rule-phoneCN="mobile"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">*验证码：</label>
                                        <div class="col-lg-3">
                                            <div class="input-group">
                                                <input id="verificationCode" type="text" name="validationCode" placeholder="输入手机验证码" class="form-control" data-rule-requiredEx="true">
                                                <!-- <span class="input-group-btn">
                                                    <a href="javascript:;" id="getMobileCaptcha" class="btn btn-primary" style="width:124px;">获取短信验证码</a>
                                                </span> -->
                                                <span class="input-group-btn">
                                                <input type="button" id="getMobileCaptcha" class="btn btn-primary" style="width:124px;" value="获取短信验证码" disabled="disabled" />
                                            	</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">*姓名：</label>
                                        <div class="col-lg-3">
                                            <input id="name" name="hostName" type="text" class="form-control" placeholder="输入姓名" data-rule-requiredEx="true" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">*密码：</label>
                                        <div class="col-lg-3">
                                            <input id="passWord" name="confirmPassword1" type="password" class="form-control" placeholder="输入密码" data-rule-minlength="6" data-rule-maxlength="20" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">*确认密码：</label>
                                        <div class="col-lg-3">
                                            <input id="repPassWord" name="confirmPassword2" type="password" class="form-control" placeholder="请重复密码" data-rule-requiredEx="true" data-rule-equalTo="#passWord" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">邀请码：</label>
                                        <div class="col-lg-3">
                                            <input id="invCode" name="sellerInviteCode" type="text" class="form-control" placeholder="请输入邀请码，非必填" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="ibox">
                            <div class="ibox-content">
                                <div class="form-horizontal">
                                    <div class="form-group m-b-none">
                                        <div class="col-lg-10 col-lg-offset-2">
                                        	<input type="button" id="next" class="btn btn-primary" value="完成" disabled="disabled" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>


    </div>
</div>

<!-- 模态 -->
<div class="modal fade" id="sendMsgModal">
    <form id="sendMsgModalForm">
        <div class="modal-dialog modal-sm" >
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">发送手机验证码</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-lg-12">
                                        <div class="input-group">
                                            <input type="text" name="jcaptchaCode" id="input-jcaptchaCode" style="width:120px;font-size:16px; height: 42px; margin-right: 10px;" placeholder="输入验证码"  data-rule-digitalLetterVerification="true"  class="form-control" data-rule-requiredEx="true">
                                            <img class="jcaptcha-btn jcaptcha-img" id="img_captcha" src="" title="点击更换验证码" style="border: 1px solid #AAA; margin-right: 10px; cursor: pointer;">
                                            <a class="jcaptcha-btn" href="javascript:;" id="chgCaptcha">换一张</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-lg-12">
                            <a class="btn btn-primary" href="javascript:;" id="sendMobileCaptcha">发送</a>
                            <a href="javascript:;" class="btn btn-white" data-dismiss="modal">取消</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

    <jsp:include page="inc/bottom.jsp"></jsp:include>
    <script src="/resources/lib/uuid.js" type="text/javascript"></script>
    <script src="/resources/app/regRecmder.js" type="text/javascript"></script>

</body>
</html>