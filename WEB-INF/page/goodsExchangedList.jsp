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
    <link href="/resources/css/goodsexchangedlist.css" rel="stylesheet" type="text/css" />
</head>
<body class="fixed-sidebar fixed-nav">
<div id="wrapper">
    <%@include file="inc/menu.jsp"%>

    <div id="page-wrapper" class="gray-bg">

        <div class="row wrapper border-bottom white-bg page-heading">
            <div class="col-md-12">
                <ol class="breadcrumb" style="margin-top: 15px;">
                    <li>首页</li>
                    <li class="active activeMenu">
                        <strong>积分兑换</strong>
                    </li>
                </ol>
            </div>
        </div>

        <div class="wrapper wrapper-content animated fadeInRight">

            <div class="row">
                <div class="col-md-12">
                    <div class="ibox">
                        <div class="ibox-content">

                            <div class="form-horizontal">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row text-group">
                                            <div class="col-md-6">
                                                <span id="name"></span>您好，注册时间：<span id="regTime"></span>
                                            </div>
                                            <div class="col-md-6">
                                                注册来源：<span id="recommendedPerson"></span>
                                            </div>
                                        </div>
                                        <div class="row text-group">
                                            <div class="col-md-6">
                                                当前可用积分：<span id="score"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                        <div class="row" id="goodsList">
                        </div>

                </div>

            </div>
        </div>
    </div>
</div>

<!-- 编辑收货地址模态 -->
<div class="modal fade" id="editAddressModal">
    <form id="editAddressForm">
        <div class="modal-dialog" >
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title addressModalTitle"></h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">*收货联系人：</label>
                            <div class="col-sm-9">
                                <input type="text" name="contacter" id="orderName"  placeholder="收货联系人"  class="form-control" data-rule-requiredEx="true">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">*联系电话：</label>
                            <div class="col-sm-9">
                                <input type="text" name="contactTel" id="orderPhone"  placeholder="请输入手机号"  class="form-control" data-rule-requiredEx="true" data-rule-phoneCN="mobile">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">*收货地址：</label>
                            <div class="col-sm-9">
                                <input type="text" name="address" id="orderAddress"  placeholder="收货地址"  class="form-control" data-rule-requiredEx="true">                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-primary" href="javascript:;" id="confirmEditAddress">确认</a>
                            <a href="javascript:;" class="btn btn-white" data-dismiss="modal">取消</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- 拒绝兑换模态 -->
<div class="modal fade" id="denyChange">
    <form id="editCompanyForm">
        <div class="modal-dialog" >
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">操作提示</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 text-center" style="font-size:1.5em;line-height:1.5em;margin-bottom:10px;">
                            您的积分不够兑换
                        </div>
                        <div class="col-sm-12 text-center" id="qrcode"></div>
                        <div class="col-sm-12 text-center">
                            推荐他人获得更多积分
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-primary" href="javascript:;" id="shareBtn">推荐</a>
                            <a href="javascript:;" class="btn btn-white" data-dismiss="modal">取消</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- 商品详情模态 -->
<div class="modal fade" id="goodsDetails">
    <form id="goodsDetailsForm">
        <div class="modal-dialog" >
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">详情</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12" style="font-size:1.5em;line-height:1.5em;margin-bottom:10px;">
                            <span id="goodsTitle"></span>
                            <input type="button" class="btn btn-primary pull-right" value="兑 换" id="modalChangeBtn" />
                        </div>
                        <div class="col-sm-12" style="margin-bottom:10px;">
                            <span id="goodsTxt"></span>
                        </div>
                        <div class="col-sm-12 text-center goodsDetailsImg">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <a href="javascript:;" class="btn btn-white" data-dismiss="modal">关闭</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="inc/bottom.jsp"></jsp:include>
<script src="/resources/app/goodsExchangedList.js" type="text/javascript"></script>

</body>
</html>