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
    <style>
        #exchange{
            margin-left: 20px;
            color: #1ab394;
        }
        #editAddress,#editPassword,#editCompany{
            color: #1ab394;
        }
        #editAddress:hover,#editPassword:hover,#editCompany:hover{
            cursor: pointer;
        }
        #qrcode{
            width: 100%;
            margin-bottom: 15px;
        }
        #name{
            font-size:1.2em;
            font-weight:bold;
            color: #1ab394;
        }
        #qrcode canvas{
            display: none;
        }
        #shareBtn{
            width:128px;
            margin:10px 0;
        }
        #scroeHistory_filter input[type="search"]{
            display:none!important;
        }
        #scroeHistory_filter label:after{
            display:none!important;
        }
        .begin-date{
            width: 40%;display:inline-block;margin-right:15px;
        }
        .end-date{
            width: 40%;display:inline-block;margin-left:15px;
        }

    </style>
</head>
<body class="fixed-sidebar fixed-nav">
    <div id="wrapper">
        <%@include file="inc/menu.jsp"%>

        <div id="page-wrapper" class="gray-bg">

            <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-md-12">
                    <ol class="breadcrumb" style="margin-top: 15px;">
                        <li class="activeMenu">兑换管理</li>
                        <li class="active">
                            <strong>兑换记录</strong>
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
                                                        <table id="exchangeRecord" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%">
                                                            <thead>
                                                            <tr>
                                                                <th style="width: 8%;">姓名</th>
                                                                <th style="width: 10%;">手机号</th>
                                                                <th style="width: 10%;">兑换内容</th>
                                                                <th style="width: 7%;">积分扣除</th>
                                                                <th style="width: 3%;">联系人</th>
                                                                <th style="width: 10%;">联系电话</th>
                                                                <th style="width: 17%;">收货地址/收款账号</th>
                                                                <th style="width: 15%;">订单生成时间</th>
                                                                <th style="width: 5%;">订单状态</th>
                                                                <th style="width: 10%;">备注</th>
                                                                <th style="width: 5%;">操作</th>
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
                                <label class="col-sm-3 control-label">日期：</label>
                                <div class="col-sm-9">
                                    <input type="text" id="criteriaBeginDate" class="form-control begin-date">-
                                    <input type="text" id="criteriaEndDate" class="form-control end-date">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">状态：</label>
                                <div class="col-sm-9">
                                    <select type="text" id="criteriaStatus" class="form-control">
                                        <option value="-1">未选择</option>
                                        <option value="1">待审核</option>
                                        <option value="2">处理中</option>
                                        <option value="4">已完成</option>
                                        <option value="3">已取消</option>
                                    </select>
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

    <!-- 订单处理模态 -->
    <div class="modal fade" id="handleModal">
        <form id="handleForm">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">姓名：</label>
                                <div class="col-sm-3 control-text" id="modalName"></div>
                                <label class="col-sm-3 control-label">手机号：</label>
                                <div class="col-sm-3 control-text" id="modalPhone"></div>
                            </div>
                        </div>
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">兑换内容：</label>
                                <div class="col-sm-9 control-text" id="modalGoods"></div>
                            </div>
                        </div>
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">消耗积分：</label>
                                <div class="col-sm-9 control-text" id="modalScroe"></div>
                            </div>
                        </div>
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">收货/收款信息：</label>
                                <div class="col-sm-9 control-text" id="modalAddress"></div>
                            </div>
                        </div>
                        <div class="form-horizontal">
                            <div class="form-group status1">
                                <label class="col-sm-3 control-label">*处理内容：</label>
                                <div class="col-sm-9">
                                    <select id="modalHandle1" class="form-control">
                                        <option value="0">--------</option>
                                        <option value="1">订单确认</option>
                                        <option value="2">订单取消</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group status2">
                                <label class="col-sm-3 control-label">*处理内容：</label>
                                <div class="col-sm-9">
                                    <select id="modalHandle2" class="form-control">
                                        <option value="0">--------</option>
                                        <option value="3">订单完成</option>
                                        <option value="2">订单取消</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">备注：</label>
                                <div class="col-sm-9">
                                    <textarea type="text" id="reMark" class="form-control" id="modalRemark"></textarea>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-lg-12">
                                <a class="btn btn-primary" href="javascript:;" id="handleConfirm">确认</a>
                                <a href="javascript:;" class="btn btn-white" data-dismiss="modal">取消</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <jsp:include page="inc/bottom.jsp"></jsp:include>
    <script src="/resources/app/exchangedRecord.js" type="text/javascript"></script>

</body>
</html>