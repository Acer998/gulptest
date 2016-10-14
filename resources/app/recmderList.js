;$(function(){

    // ContextPath
    var sContextPath = dayspring.getContextPath();

	$("#criteriaBeginDate").datepicker(dayspring.getDatePickerOption());
	$("#criteriaEndDate").datepicker(dayspring.getDatePickerOption());
	
	//获取dt查询参数
	function setDtparams(){
		var hostName = $("#nameFilter").val();
		var regOrigin = $("#regOrigin").val();
		var hostTel = $("#criteriaPhone").val();
		var userInviteCode = $("#invCode").val();
		var sellerName = $("#invName").val();
		var sellerInviteCode = $("#sellsCode").val();
		var beginRegTime = $("#criteriaBeginDate").val();
		var endRegTime = $("#criteriaEndDate").val();
		var _data = {};
		_data.hostName = hostName;
		_data.regOrigin = regOrigin;
		_data.hostTel = hostTel;
		_data.userInviteCode = userInviteCode;
		_data.sellerName = sellerName;
		_data.sellerInviteCode = sellerInviteCode;
		_data.beginRegTime = beginRegTime;
		_data.endRegTime = endRegTime;
		return _data;
	}

    // 获取积分变动历史记录
	var oDataTableOption = dayspring.getDataTableOption(true);
	oDataTableOption.ajax = {
		type:"POST",
		url: sContextPath + "/rest/admin/findRecmderStatPage",
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
		{data: "userInviteCode"},
		{data: "createdTime"},
		{data: "sellerName"},
        {data: "sellerInviteCode"},
        {data: "totalCompRegs"},
        {data: "totalEntries"},
        {data: "totalLogins"},
        {data: "totalRecIntegral"},
        {data: "totalCost"},
		{data: "totalAdjusted"},
		{data: "totalIntegral"},
		{data: "hostId"},
	];
	oDataTableOption.aoColumnDefs = [
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				$(nTd).html(new Date(oData.createdTime).Format("yyyy-MM-dd HH:mm:ss"));
			},
			aTargets: [3]
		},
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				$(nTd).html('<a href="'+ sContextPath +'/rest/admin/forwardRecomderDetailPage/'+ oData.hostId +'" class="btn btn-white">查看</a>');
			},
			aTargets: [13]
		}
	];
	var oDataTable = $("#recmderList").DataTable(oDataTableOption);
	
	// 添加过滤按钮

    $("#recmderList_wrapper").find(".filter").html("<div class='dataTables_filter'><label><input id='nameFilter' type='search' class='form-control input-sm' placeholder='输入姓名按回车键检索'></label><label><a id='filter' class='btn btn-white btn-sm m-r-xs'><i class='fa fa-filter'></i> 筛选</a></label></div>");

	//custom name filter
	$("#filter").click(function() {
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
		$("#exportList").attr("action", sContextPath + "/rest/admin/exportRecomderStatExcel");
        $("#exportList")[0].submit();
	})

})