<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
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
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/resources/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div id="page-container" class="fade in">
        <div class="login">
            <!-- start left -->
            <div class="news-feed">
                <div class="news-image"></div>
                <div class="news-feed">
                    <div class="news-image carousel carousel-fade" id="inSlider" data-ride="carousel" data-interval="10000">
                    <!-- <div class="news-image carousel carousel-fade" id="inSlider"  data-ride="carousel" data-interval="10000"> -->
                        <!--carousel start-->
                        <div class="carousel-inner" role="listbox">
                            <div class="item active">
                                <div class="header-back one"></div>
                                <div class="news-caption">
                                    <div class="title">
                                        <p class="lg">邀请伙伴注册班步,<br />免费畅游迪士尼</p>
                                        <!--<p class="sm">简单易用，让HR轻松应对人事烦恼</p>-->
                                    </div>
                                    <div class="qrcode">
                                        <img src="/resources/img/qrcode_index.png">
                                    </div>
                                    <div class="text">
                                        扫一扫<br>更精彩
                                    </div>
                                </div>
                            </div>
                            
                            
                            
                            <div class="item">
                                <div class="header-back two"></div>
                                <div class="news-caption">
                                    <div class="title">
                                        <p class="lg">邀请伙伴注册班步,<br />免费畅游迪士尼</p>
                                        <!--<p class="sm">简单易用，让HR轻松应对人事烦恼</p>-->
                                    </div>
                                    <div class="qrcode">
                                        <img src="/resources/img/qrcode_index.png">
                                    </div>
                                    <div class="text">
                                        扫一扫<br>更精彩
                                    </div>
                                </div>
                            </div>
                            <ol class="carousel-indicators">
                                <li data-target="#inSlider" data-slide-to="0" class=""></li>
                                <li data-target="#inSlider" data-slide-to="1" class="active"></li>
                            </ol>
                            <a class="left carousel-control" href="#inSlider" role="button" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="right carousel-control" href="#inSlider" role="button" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a> 
                            
                            
                            
                            
                        </div>
                        <!--carousel end-->
                    </div>

                </div>
            </div>
            <!-- end left -->
            <!-- start right -->
            <div class="right-content">
                <div class="login-header">
                    <div class="brand">欢迎加入班步合伙人</div>
                </div>

                <div class="login-content tab-content">
                    <div class="tab-pane fade in active" id="company_user">

                            <div id="errMsg" class="alert alert-error input-medium controls"></div>

                            <div class="form-group m-b-15">
                                <input name="username" id="username" type="text" class="form-control input-lg" placeholder="手机号" style="font-size: 16px">
                            </div>
                            <input name="type" type="hidden" value="1">
                            <div class="form-group m-b-15">
                                <input name="password" id="password" type="password" class="form-control input-lg" placeholder="请输入密码" style="font-size: 16px">
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <input type="text" name="jcaptchaCode" id="input-jcaptchaCode" style="width: 140px; font-size: 16px; height: 42px; margin-right: 10px;" placeholder="请输入验证码" class="form-control" required="required" maxlength="4">
                                    <img class="jcaptcha-btn jcaptcha-img" id="jcaptchaCode" src="" title="点击更换验证码" style="border: 1px solid #AAA; margin-right: 10px; cursor: pointer;">
                                    <a class="jcaptcha-btn" href="javascript:;">换一张</a>
                                </div>
                            </div>
                            <div class="login-buttons">
                                <button type="submit" id="submit" class="btn btn-primary btn-block btn-lg btn-submit btn-green">登录</button>
                            </div>
                            <hr>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    没有账号，赶快<a href="javascript:;" id="regedit">注册</a>吧。
                                </div>
                            </div>

                    </div>
                </div>

            </div>
            <!-- end right -->
        </div>
    </div>

    <script src="/resources/lib/jquery.min.js" type="text/javascript"></script>
    <script src="/resources/lib/bootstrap.min.js" type="text/javascript"></script>
    <script src="/resources/lib/toastr.min.js" type="text/javascript"></script>
    <script src="/resources/lib/dayspring.min.js" type="text/javascript"></script>
    <script src="/resources/lib/dayspring.theme.min.js" type="text/javascript"></script>
    <script src="/resources/lib/uuid.js" type="text/javascript"></script>
    <script src="/resources/app/login.js" type="text/javascript"></script>
    <%@include file="inc/baiduStatistics.jsp"%>

</body>
</html>