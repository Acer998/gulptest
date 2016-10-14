;$(function(){

	var $phone = localStorage.getItem("phone");
	if($phone){
		$("#criteriaPhone").val($phone);
		localStorage.removeItem("phone");
	}

    // ContextPath
    var sContextPath = dayspring.getContextPath();

	$("#beginRegTime").datepicker(dayspring.getDatePickerOption());
	$("#endRegTime").datepicker(dayspring.getDatePickerOption());
	
	//获取dt查询参数
	function setDtparams(){
		var hostName = $("#nameFilter").val();
		var hostTel = $("#criteriaPhone").val();
		var userInviteCode = $("#invCode").val();
		var sellerName = $("#invName").val();
		var sellerInviteCode = $("#sellsCode").val();
		var companyName = $("#recCpy").val();
		var beginRegTime = $("#beginRegTime").val();
    	var endRegTime = $("#endRegTime").val();
		var refStatus = $("#refStatus").val();
		var _data = {};
		_data.hostName = hostName;
		_data.hostTel = hostTel;
		_data.userInviteCode = userInviteCode;
		_data.sellerName = sellerName;
		_data.sellerInviteCode = sellerInviteCode;
		_data.companyName = companyName;
		_data.beginRegTime = beginRegTime;
		_data.endRegTime = endRegTime;
		_data.refStatus = refStatus;
		return _data;
	}

    // 获取积分变动历史记录
	var oDataTableOption = dayspring.getDataTableOption(true);
	oDataTableOption.ajax = {
		type:"POST",
		url: sContextPath + "/rest/admin/findRecommenderCompanyRefPage",
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
		{data: "companyName"},
		{data: "detail.sellerName"},
        {data: "detail.sellerInviteCode"},
        {data: "entryTotal"},
        {data: "loginedTotal"},
        {data: "increasedTotal"},
        {data: "regTime"},
        {data: "firstEntryTime"},
		{data: "refStatus"},
		{data: "id"}
	];
	oDataTableOption.aoColumnDefs = [
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				var date = new Date(oData.regTime).Format("yyyy-MM-dd HH:mm:ss")
				$(nTd).html(date);
			},
			aTargets: [9]
		},
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				if(oData.firstEntryTime){
					var date = new Date(oData.firstEntryTime).Format("yyyy-MM-dd HH:mm:ss");
					$(nTd).html(date);
				}
			},
			aTargets: [10]
		},
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				if(oData.refStatus==0) $(nTd).html("已解绑");
				else $(nTd).html("正常");
			},
			aTargets: [11]
		},
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				if(oData.refStatus==0){
					$(nTd).html('<a href="javascript:;" class="btn btn-primary updateStatus" data-id="' + oData.id + '">恢复绑定</a>');
				}
				else{
					$(nTd).html('<a href="javascript:;" class="btn btn-primary updateStatus" data-id="' + oData.id + '">解绑</a>');
				}
			},
			aTargets: [12]
		}
	];
	var oDataTable = $("#scoreList").DataTable(oDataTableOption);

	$("body").on("click",".updateStatus",function(){
		var _this = $(this);
		swal({
			title:"操作提示",
			type:"warning",
			showCancelButton: true,
			confirmButtonText: "确认操作",
			cancelButtonText: "取消操作",
		},function(){
			var id = _this.data("id");
			var oAjaxOption = {
				//todo
				type: "PUT",
				url: sContextPath + "/rest/admin/changedBindingState/" + id,
				contentType : "application/json",
				dataType : "json",
				success: function(json) {
					dayspring.checkAuth(json);
					if(json.code != 200){
						return false;
					}
					oDataTable.ajax.reload();
				},
				error: function(oData, oStatus, eErrorThrow) {
				},
				complete: function (oXmlHttpRequest, oStatus) {
					$.unblockUI();
				}
			};
			$.blockUI(dayspring.getBlockOption());
			$.ajax(oAjaxOption);
		});

	})
	
	// 添加过滤按钮
    $("#scoreList_wrapper").find(".filter").html("<div class='dataTables_filter'><label><input id='nameFilter' type='search' class='form-control input-sm' placeholder='输入姓名按回车键检索'></label><label><a id='filter' class='btn btn-white btn-sm m-r-xs'><i class='fa fa-filter'></i> 筛选</a></label></div>");

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
		$("#exportList").attr("action", sContextPath + "/rest/admin/exportRecommenderCompanyRefExcel");
        $("#exportList")[0].submit();
	})

})