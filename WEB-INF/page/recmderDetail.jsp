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
    <link href="/resources/css/awesome-bootstrap-checkbox.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/recmderdetail.css" rel="stylesheet" type="text/css" />
</head>
<body class="fixed-sidebar fixed-nav">
    <div id="wrapper">
		<%@include file="inc/menu.jsp"%>

        <div id="page-wrapper" class="gray-bg">

            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-md-12">
                    <ol class="breadcrumb" style="margin-top: 15px;">
                        <li class="activeMenu">推荐管理</li>
                        <li class="active activeMenu">
                            <strong>推荐人查看</strong>
                        </li>
                    </ol>
                </div>
            </div>

            <div class="wrapper wrapper-content animated fadeInRight">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="ibox m-b-none">
                                <div class="ibox-content">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="row text-group">
                                                <div class="col-md-6">
                                                    <h4>基本信息</h4>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-horizontal">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <div class="row text-group">
                                                    <div class="col-md-6">
                                                        姓名:<span id="name"></span>
                                                    </div>
                                                    <div class="col-md-6">
                                                        注册时间：<span id="regTime"></span>
                                                    </div>
                                                </div>
                                                <div class="row text-group">
                                                    <div class="col-md-6">
                                                        手机号：<span id="phone"></span>
                                                    </div>
                                                    <div class="col-md-6">
                                                        推荐人邀请码：<span id="recCode"></span>
                                                    </div>
                                                </div>
                                                <div class="row text-group">
                                                    <div class="col-md-6">
                                                        注册来源：<span id="regOrigin"></span>
                                                    </div>
                                                    <div class="col-md-6">
                                                        销售姓名：<span id="selName"></span>
                                                    </div>
                                                </div>
                                                <div class="row text-group">
                                                    <div class="col-md-6">
                                                        销售邀请码：<span id="sellCode"></span>
                                                    </div>
                                                </div>
                                                <div class="row text-group">
                                                    <div class="col-md-6">
                                                         公司信息：<span id="cpyInfo"></span>
                                                    </div>
                                                </div>
                                                <div class="row text-group">
                                                    <div class="col-md-6">
                                                        收货信息：<span id="address"></span>
                                                    </div>
                                                </div>
                                                <div class="row text-group">
                                                    <div class="col-md-6">
                                                        <a class="btn btn-primary" href="javascript:;" id="editPassword">重置密码</a>
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
                                                    <h4>公司及积分信息</h4>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="row text-group">
                                                <div class="col-md-12">
                                                    <div class="table-responsive">
                                                        <table id="cpyScroe" class="table table-striped table-bordered table-hover">
                                                            <thead>
                                                            <tr>
                                                                <th>推荐公司数</th>
                                                                <th>录入员工数</th>
                                                                <th>员工登录app数</th>
                                                                <th>共获得积分</th>
                                                                <th>消费扣除</th>
                                                                <th>人工调整</th>
                                                                <th>当前积分</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <tr>
                                                                <td><span id="cpyNum"></span></td>
                                                                <td><span id="empInNum"></span></td>
                                                                <td><span id="empLogNum"></span></td>
                                                                <td><span id="totSco"></span></td>
                                                                <td><span id="calSco"></span></td>
                                                                <td><span id="updSco"></span></td>
                                                                <td><span id="letSco"></span></td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="row text-group">
                                                <div class="col-md-12">
                                                    <a class="btn btn-primary" href="javascript:;" id="editScore">调整积分</a>
                                                    <a class="btn btn-primary" href="javascript:;" id="scoreDet">积分明细</a>
                                                    <a class="btn btn-primary" href="javascript:;" id="excRec">兑换记录</a>
                                                    <a class="btn btn-primary" href="javascript:;" id="recCpy">推荐公司列表</a>
                                                    <a class="btn btn-white" href="javascript:;" id="backStep">返回</a>
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

    <!-- 重置密码模态 -->
    <div class="modal fade" id="getPasswordModal">
        <form id="getPasswordForm">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">重置密码</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-3 control-label">姓名：</label>
                                <div class="col-md-9">
                                    <span id="nameMod"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">手机:</label>
                                <div class="col-md-9">
                                    <span id="mobMod"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">新密码：</label>
                                <div class="col-md-9">
                                    <span id="newPas"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <a class="btn btn-primary" href="javascript:;" data-dismiss="modal">确认</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- 调整积分模态 -->
    <div class="modal fade" id="updateScoreModal">
        <form id="updateScoreForm">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">调整积分</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group">

                                <div class="radio radio-success radio-inline col-md-2">
                                    <input type="radio" id="addSco" value="" name="updateScroe" checked>
                                    <label for="addSco"> 增加 </label>
                                </div>
                                <div class="radio radio-success radio-inline col-md-2">
                                    <input type="radio" id="calcSco" value="" name="updateScroe">
                                    <label for="calcSco"> 减少 </label>
                                </div>
                                <label for="adjustedValue" class="control-label col-md-1">*</label>
                                <div class="col-md-4">
                                    <input type="text" value="" class="form-control" id="adjustedValue" data-rule-min="0" data-rule-max="10000" />
                                </div>
                                <label for="adjustedValue" class="control-label col-md-1">分</label>
                            </div>

                        </div>
                        <div class="form-horizontal">
                            <div class="form-group">
                                <br />
                                <label>调整原因：</label>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" rows="5" id="updScoMark"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <a class="btn btn-primary" href="javascript:;" id="updateScoreCfm">确认</a>
                                <a href="javascript:;" class="btn btn-white" data-dismiss="modal">取消</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

	<jsp:include page="inc/bottom.jsp"></jsp:include>
    <script src="/resources/app/recmderDeatil.js" type="text/javascript"></script>
</body>
</html>