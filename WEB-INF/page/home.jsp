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
    <link href="/resources/css/home.css" rel="stylesheet" type="text/css" />
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
                            <strong>个人信息</strong>
                        </li>
                    </ol>
                </div>
            </div>

            <div class="wrapper wrapper-content animated fadeInRight">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="ibox m-b-none">
                                <div class="ibox-content">

                                        <div class="form-horizontal">
                                            <div class="row">
                                                <div class="col-md-9">
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
                                                            当前可用积分：<span id="score"></span><span id="exchange">兑换</span>
                                                        </div>
                                                    </div>
                                                    <div class="row text-group">
                                                        <div class="col-md-6">
                                                            公司信息：<span id="companyInfo"></span>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span id="editCompany">编辑公司信息</span>
                                                        </div>
                                                    </div>
                                                    <div class="row text-group">
                                                        <div class="col-md-6">
                                                            收货信息：<span id="address"></span>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <span id="editAddress">编辑收货信息</span>
                                                        </div>
                                                    </div>
                                                    <div class="row text-group">
                                                        <div class="col-md-6">
                                                            <span id="editPassword">修改密码</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group text-group">
                                                        <div class="col-md-12 text-center">
                                                        <div id="qrcode"></div>
                                                        <input type="button" class="btn btn-primary" id="shareBtn" value="点击分享" />
                                                        <input type="text" class="form-control" placeholder="输入邀请码" id="userInviteCode" readonly="readonly" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="ibox m-b-none">
                                <div class="ibox-content">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="row text-group">
                                                <div class="col-md-6">
                                                    积分变动记录：
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="row text-group">
                                                <div class="col-md-12">
                                                    <div class="table-responsive">
                                                        <table id="scroeHistory" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%">
                                                            <thead>
                                                            <tr>
                                                                <!-- <th style="width: 5%;"></th> -->
                                                                <th style="width: 10%;">变动值</th>
                                                                <th style="width: 25%;">变动原因</th>
                                                                <th style="width: 20%;">被推荐公司</th>
                                                                <th style="width: 20%;">变动后积分</th>
                                                                <th style="width: 20%;">变动时间</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
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
                        <h4 class="modal-title">编辑收货信息</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-3 control-label">*收货联系人：</label>
                                <div class="col-md-9">
                                    <input type="text" name="contacter" id="orderName"  placeholder="收货联系人"  class="form-control" data-rule-requiredEx="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">*手机号码：</label>
                                <div class="col-md-9">
                                    <input type="text" name="contactTel" id="orderPhone"  placeholder="请输入手机号"  class="form-control" data-rule-requiredEx="true" data-rule-phoneCN="mobile">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">*收货地址：</label>
                                <div class="col-md-9">
                                    <input type="text" name="address" id="orderAddress"  placeholder="收货地址"  class="form-control" data-rule-requiredEx="true">
                                    <input type="hidden" name="id" id="addressId">
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

    <!-- 编辑公司信息模态 -->
    <div class="modal fade" id="editCompanyModal">
        <form id="editCompanyForm">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">编辑公司信息</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-3 control-label">*公司名：</label>
                                <div class="col-md-9">
                                    <input type="text" name="companyName" id="companyName"  placeholder="请输入公司名称"  class="form-control" data-rule-requiredEx="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">*职位：</label>
                                <div class="col-md-9">
                                    <input type="text" name="companyTitle" id="companyTitle"  placeholder="请输入职位"  class="form-control" data-rule-requiredEx="true">
                                    <input type="hidden" name="id" id="accountDetailId">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <a class="btn btn-primary" href="javascript:;" id="confirmEditCompany">确认</a>
                                <a href="javascript:;" class="btn btn-white" data-dismiss="modal">取消</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- 修改密码模态 -->
    <div class="modal fade" id="updatePasswordModal">
        <form id="updatePasswordForm">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">修改密码</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-3 control-label">*旧密码：</label>
                                <div class="col-md-9">
                                    <input type="password" name="password" id="oldPassword"  placeholder="请输入旧密码"  class="form-control" data-rule-requiredEx="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">*新密码：</label>
                                <div class="col-md-9">
                                    <input type="password" name="confirmPassword1" id="newPassword"  placeholder="请输入新密码"  class="form-control" data-rule-minlength="6" data-rule-maxlength="20">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">*重复新密码：</label>
                                <div class="col-md-9">
                                    <input type="password" name="confirmPassword2" id="repNewPassword"  placeholder="请重复输入新密码"  class="form-control" data-rule-requiredEx="true" data-rule-equalTo="#newPassword" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <a class="btn btn-primary" href="javascript:;" id="confirmUpdatePassword">确认</a>
                                <a href="javascript:;" class="btn btn-white" data-dismiss="modal">取消</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <!-- 条件筛选模态 -->
    <div class="modal fade" id="criteriaModal">
        <form id="criteriaForm">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">查询条件</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-3 control-label">日期：</label>
                                <div class="col-md-9">
                                    <input type="text" id="criteriaBeginDate" class="form-control begin-date">-
                                    <input type="text" id="criteriaEndDate" class="form-control end-date">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">被推荐公司：</label>
                                <div class="col-md-9">
                                    <input type="text" id="criteriaCpy" class="form-control">
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <a class="btn btn-primary" href="javascript:;" id="confirmcriteriaData">确认</a>
                                <a href="javascript:;" class="btn btn-white" data-dismiss="modal">取消</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

	<jsp:include page="inc/bottom.jsp"></jsp:include>
    <script src="/resources/app/home.js" type="text/javascript"></script>
</body>
</html>