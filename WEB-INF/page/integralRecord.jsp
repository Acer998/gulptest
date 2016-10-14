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
    <link href="/resources/css/integralRecord.css" rel="stylesheet" type="text/css" />
</head>
<body class="fixed-sidebar fixed-nav">
    <div id="wrapper">
        <%@include file="inc/menu.jsp"%>

        <div id="page-wrapper" class="gray-bg">

            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-md-12">
                    <ol class="breadcrumb" style="margin-top: 15px;">
                        <li class="activeMenu">推荐管理</li>
                        <li class="active">
                            <strong>积分记录</strong>
                        </li>
                    </ol>
                </div>
            </div>

            <div class="wrapper wrapper-content animated fadeInRight">

                    <div class="row">

                        <div class="col-lg-12">
                            <div class="ibox m-b-none">
                                <div class="ibox-content">

                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="row text-group" style="margin-bottom:0;">
                                                <div class="col-lg-12">
                                                    <div class="table-responsive">
                                                        <table id="scoreList" class="table table-striped table-bordered table-hover">
                                                            <thead>
                                                            <tr>
                                                                <th>姓名</th>
                                                                <th>手机号</th>
                                                                <th>推荐人邀请码</th>
                                                                <th>销售姓名</th>
                                                                <th>销售邀请码</th>
                                                                <th>积分变动</th>
                                                                <th>变动原因</th>
                                                                <th>被推荐公司</th>
                                                                <th>变动后积分</th>
                                                                <th>变动时间</th>
                                                                <th>备注</th>
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
                        	<div class="ibox m-b-none ibox-foot">
                                  <div class="ibox-content">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="row text-group" style="margin-bottom: 0px;">
                                                    <div class="col-lg-12">
                                                        <form id="exportList" action="" method = "post" style="display:none;">
                                                            <input type="hidden" name="hiddenText" id="hiddenText" />
                                                        </form>
                                                        <button type="button" class="btn btn-primary" id="export"><i class="glyphicon glyphicon-save"></i>导出</button>
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
                                <label class="col-sm-3 control-label">手机号：</label>
                                <div class="col-sm-9">
                                    <input type="text" id="criteriaPhone" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">推荐人邀请码：</label>
                                <div class="col-sm-9">
                                    <input type="text" id="invCode" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">销售姓名：</label>
                                <div class="col-sm-9">
                                    <input type="text" id="invName" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">销售邀请码：</label>
                                <div class="col-sm-9">
                                    <input type="text" id="sellsCode" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">被推荐公司：</label>
                                <div class="col-sm-9">
                                    <input type="text" id="recCpy" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">变动日期：</label>
                                <div class="col-sm-9">
                                    <input type="text" id="beginChangedTime" class="form-control begin-date">-
                                    <input type="text" id="endChangedTime" class="form-control end-date">
                                </div>
                            </div>

                            
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-lg-12">
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
    <script src="/resources/app/integralRecord.js" type="text/javascript"></script>

</body>
</html>