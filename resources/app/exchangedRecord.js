;$(function(){

	var $phone = localStorage.getItem("phone");
	if($phone){
		$("#criteriaPhone").val($phone);
		localStorage.removeItem("phone");
	}

    // ContextPath
    var sContextPath = dayspring.getContextPath();

	$("#criteriaBeginDate").datepicker(dayspring.getDatePickerOption());
	$("#criteriaEndDate").datepicker(dayspring.getDatePickerOption());
	
	//获取dt查询参数
	function setDtparams(){
		var hostName = $("#nameFilter").val();
		var hostTel = $("#criteriaPhone").val();
		var beginOrderTime = $("#criteriaBeginDate").val();
    	var endOrderTime = $("#criteriaEndDate").val();
    	var orderStatus = $("#criteriaStatus").val();
		var _data = {};
		_data.hostName = hostName;
		_data.hostTel = hostTel;
		_data.beginOrderTime = beginOrderTime;
		_data.endOrderTime = endOrderTime;
		_data.orderStatus = orderStatus;
		return _data;
	}

    // 获取积分变动历史记录
	var oDataTableOption = dayspring.getDataTableOption(true);
	oDataTableOption.ajax = {
		//todo
		type:"post",
		url: sContextPath + "/rest/admin/findGoodsExchangedHistoryPage",
		contentType:"application/json",
		data: function (data) {
			var _data = setDtparams();
			_data.draw = data.draw;
			_data.start = data.start;
			_data.length = data.length;
			return JSON.stringify(_data);
	    }
	};

	oDataTableOption.columns = [
		{data: "hostName"},
		{data: "hostTel"},
		{data: "goodsName"},
		{data: "decreaseValue"},
		{data: "contacter"},
        {data: "contactTel"},
        {data: "address"},
        {data: "createdTime"},
        {data: "orderStatus"},
        {data: "remark"},
        {data: "orderStatus"},
	];
	oDataTableOption.aoColumnDefs = [
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				var date = new Date(oData.createdTime).Format("yyyy-MM-dd HH:mm:ss")
				$(nTd).html(date);
			},
			aTargets: [7]
		},
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				if(oData.orderStatus==1){
					$(nTd).html("待审核");
				}
				else if(oData.orderStatus==2){
					$(nTd).html("处理中");
				}
				else if(oData.orderStatus==3){
					$(nTd).html("已取消");
				}
				else if(oData.orderStatus==4){
					$(nTd).html("已完成");
				}
			},
			aTargets: [8]
		},
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				if(oData.orderStatus==1){
					$(nTd).html("<input type='button' class='btn btn-primary btn-sm handle' value='审核' />");
					$(nTd).find("input").data(oData);
				}
				else if(oData.orderStatus==2){
					$(nTd).html("<input type='button' class='btn btn-primary btn-sm handle' value='处理' />");
					$(nTd).find("input").data(oData);
				}
				else{
					$(nTd).html("");
				}
			},
			aTargets: [10]
		}
	];
	var oDataTable = $("#exchangeRecord").DataTable(oDataTableOption);
	
	// 添加过滤按钮

    $("#exchangeRecord_wrapper").find(".filter").html("<div class='dataTables_filter'><label><input id='nameFilter' type='search' class='form-control input-sm' placeholder='输入姓名按回车键检索'></label><label><a id='filter' class='btn btn-white btn-sm m-r-xs'><i class='fa fa-filter'></i> 筛选</a></label></div>");



	//handle the processing modal
	$("body").on("click",".handle",function() {
		var data = $(this).data();
		if(data.orderStatus==1){
			$("#handleForm")[0].reset();
			$("#handleModal").find(".modal-title").html("订单审核");
			$(".status1").css("display","block");
			$(".status2").css("display","none");
			$("#modalName").html(data.hostName);
			$("#modalPhone").html(data.contactTel);
			$("#modalGoods").html(data.goodsName);
			$("#modalScroe").html(data.decreaseValue);
			$("#modalAddress").html(data.address);
			$("#handleConfirm").data("id",data.id);
			$("#handleConfirm").data("status",1);
			$("#reMark").val("");
			$("#handleModal").modal("show");
		}
		else if(data.orderStatus==2){
			$("#handleForm")[0].reset();
			$("#handleModal").find(".modal-title").html("订单处理");
			$(".status1").css("display","none");
			$(".status2").css("display","block");
			$("#modalName").html(data.hostName);
			$("#modalPhone").html(data.contactTel);
			$("#modalGoods").html(data.goodsName);
			$("#modalScroe").html(data.decreaseValue);
			$("#modalAddress").html(data.address);
			$("#handleConfirm").data("id",data.id);
			$("#handleConfirm").data("status",2);
			$("#reMark").val("");
			$("#handleModal").modal("show");
		}
	});

	//confirm the processing modal
	$("#handleConfirm").click(function(){
		var status = $(this).data("status");
		var id = $(this).data("id");
		var remark = $("#reMark").val();
		var processingTyp;
		if(status == 1){
			processingTyp = $("#modalHandle1").val();
			if(processingTyp==0){
				swal("操作提示", "您没有选择操作类型", "error");
				return;
			}
		}
		else if(status == 2){
			processingTyp = $("#modalHandle2").val();
			if(processingTyp==0){
				swal("操作提示", "您没有选择操作类型", "error");
				return;
			}
		}
		var oAjaxOption = {
			type: "post",
			url:  sContextPath + "/rest/admin/confirmOrderReview",
			data:JSON.stringify({id:id,processingTyp:processingTyp,remark:remark}),
			contentType:"application/json",
			success: function(json) {
				dayspring.checkAuth(json);
				if (json.code != 200) {
					$("#handleModal").modal("hide");
					swal("操作提示", json.message, "error");
				}
				else {
					$("#handleModal").modal("hide");
					oDataTable.ajax.reload();
				}

			},
			error: function(oData, oStatus, eErrorThrow) {
			},
			complete: function (oXmlHttpRequest, oStatus) {
			}
		};
		swal({
				title:"操作提示", 
				text:"请确认您的操作，该操作无法更改！", 
				type:"warning",
				showCancelButton: true,
				confirmButtonText: "确认操作",
				cancelButtonText: "我再检查一下",
				},function(){
					$.ajax(oAjaxOption);
			});
	})

	//custom name filter
	$("#filter").click(function() {
		//$("#criteriaForm")[0].reset();
		$("#criteriaModal").modal("show");
	});
	$("body").on("keypress","#nameFilter",function(e) {
		if (e.keyCode == 13 ) {
			oDataTable.ajax.reload();
		}
	})

	//confirm the filter modal
	$("#confirmcriteriaData").click(function(){
		$("#criteriaModal").modal("hide");
		oDataTable.ajax.reload();
	})
	
	//export the list
	$("#export").click(function(){
		var hiddenText = JSON.stringify(setDtparams());
		$("#hiddenText").val(hiddenText);
		$("#exportList").attr("action", sContextPath + "/rest/admin/exportGoodsExchangedHistoryExcel");
        $("#exportList")[0].submit();
	})

})