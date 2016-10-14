;$(function(){

	var $phone = localStorage.getItem("phone");
	if($phone){
		$("#criteriaPhone").val($phone);
		localStorage.removeItem("phone");
	}

    // ContextPath
    var sContextPath = dayspring.getContextPath();

	$("#beginChangedTime").datepicker(dayspring.getDatePickerOption());
	$("#endChangedTime").datepicker(dayspring.getDatePickerOption());
	
	//获取dt查询参数
	function setDtparams(){
		var hostName = $("#nameFilter").val();
		var hostTel = $("#criteriaPhone").val();
		var userInviteCode = $("#invCode").val();
		var sellerName = $("#invName").val();
		var sellerInviteCode = $("#sellsCode").val();
		var companyName = $("#recCpy").val();
		var beginChangedTime = $("#beginChangedTime").val();
    	var endChangedTime = $("#endChangedTime").val();
		var _data = {};
		_data.hostName = hostName;
		_data.hostTel = hostTel;
		_data.userInviteCode = userInviteCode;
		_data.sellerName = sellerName;
		_data.sellerInviteCode = sellerInviteCode;
		_data.companyName = companyName;
		_data.beginChangedTime = beginChangedTime;
		_data.endChangedTime = endChangedTime;
		return _data;
	}

    // 获取积分变动历史记录
	var oDataTableOption = dayspring.getDataTableOption(true);
	oDataTableOption.ajax = {
		type:"post",
		url: sContextPath + "/rest/admin/findIntegralRecordPage",
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
		{data: "detail.userInviteCode"},
		{data: "detail.sellerName"},
		{data: "detail.sellerInviteCode"},
        {data: "changedValue"},
        {data: "changedReason"},
        {data: "companyName"},
        {data: "totalIntegral"},
        {data: "changedTime"},
        {data: "remark"},
	];
	oDataTableOption.aoColumnDefs = [
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				var date = new Date(oData.createdTime).Format("yyyy-MM-dd HH:mm:ss")
				$(nTd).html(date);
			},
			aTargets: [9]
		}
	];
	var oDataTable = $("#scoreList").DataTable(oDataTableOption);
	
	// 添加过滤按钮

    $("#scoreList_wrapper").find(".filter").html("<div class='dataTables_filter'><label><input id='nameFilter' type='search' class='form-control input-sm' placeholder='输入姓名按回车键检索'></label><label><a id='filter' class='btn btn-white btn-sm m-r-xs'><i class='fa fa-filter'></i> 筛选</a></label></div>");



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
		$("#exportList").attr("action", sContextPath + "/rest/admin/exportIntegralChangedHistoryExcel");
        $("#exportList")[0].submit();
	})

})