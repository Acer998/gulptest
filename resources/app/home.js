;$(function(){

    // ContextPath
    var sContextPath = dayspring.getContextPath();
    
    var editAddressForm = $("#editAddressForm").validate(dayspring.getValidationOption());
	var editCompanyForm = $("#editCompanyForm").validate(dayspring.getValidationOption());
	var updatePasswordForm = $("#updatePasswordForm").validate(dayspring.getValidationOption());
	
	$("#criteriaBeginDate").datepicker(dayspring.getDatePickerOption());
	$("#criteriaEndDate").datepicker(dayspring.getDatePickerOption());
	

    $("#editAddress").click(function(){
    	editAddressForm.resetForm();
    	settingAddressInfoModel();
        $("#editAddressModal").modal("show");
    })

	$("#editCompany").click(function(){
		editCompanyForm.resetForm();
		settingCompanyInfoModel();
		$("#editCompanyModal").modal("show");
	})

    $("#editPassword").click(function(){
    	updatePasswordForm.resetForm();
		$('#updatePasswordForm')[0].reset();
        $("#updatePasswordModal").modal("show");
    })
    
    function settingCompanyInfoModel(){
    	var companyInfo = $.trim($("#companyInfo").html());
    	if(companyInfo != ''){
    		companyInfo = companyInfo.split("/");
    		$("#companyName").val(companyInfo[0]);
    		$("#companyTitle").val(companyInfo[1]);
    	}
    }
    
    function settingAddressInfoModel(){
    	var addressInfo = $.trim($("#address").html());
    	if(addressInfo != ''){
    		addressInfo = addressInfo.split("/");
    		$("#orderName").val(addressInfo[0]);
    		$("#orderPhone").val(addressInfo[1]);
    		$("#orderAddress").val(addressInfo[2]);
    	}
    }

    function renderPage(){
        var oAjaxOption = {
            type: "GET",
            url: sContextPath + "/rest/recmder/findHomeData",
            success: function(json) {
            	dayspring.checkAuth(json);
            	
            	if(json.code != 200){
            		return false;
            	}
            	
            	var addressInfo = json.data.addressInfo;
            	var recmderInfo = json.data.recmderInfo;              	
            	
            	$("#menuName").html(recmderInfo.hostName);
            	$("#name").html(recmderInfo.hostName);
            	$("#regTime").html(new Date(recmderInfo.createdTime).Format("yyyy-MM-dd"));
            	$("#score").html(recmderInfo.totalIntegral);            	
            	$("#userInviteCode").val("邀请码：" + recmderInfo.userInviteCode);
            	$("#accountDetailId").val(recmderInfo.id);
            	
            	if(recmderInfo.companyName && recmderInfo.companyTitle){
            		$("#companyInfo").html(recmderInfo.companyName + "/" + recmderInfo.companyTitle); 
            	}
            	
            	if(recmderInfo.regOrigin == 1){
            		$("#recommendedPerson").html("销售渠道(" + recmderInfo.sellerName + ")");
            	}else{
            		$("#recommendedPerson").html("外部渠道");
            	}
            	
            	if(addressInfo){
            		$("#address").html(addressInfo.contacter + "/" + addressInfo.contactTel + "/" + addressInfo.address);
            		$("#addressId").val(addressInfo.id);
            	} 
            	
            	// 推荐人二维码            	
				$('#qrcode').qrcode({
					width: 128,
					height: 128,
					text: "https://hr.ibanbu.com/comp/apply/wizard/index?invite=" + recmderInfo.userInviteCode
				})
				
				$('#shareBtn').click(function(){
					window.open(sContextPath + "/rest/share/" + recmderInfo.userInviteCode);
				})
				
            	// Converts canvas to an image
				function convertCanvasToImage(canvas) {
					var image = new Image();
					image.src = canvas.toDataURL("image/png");
					return image;
				}

				var canvsQrcode = $("#qrcode").find("canvas")[0];
				var imgQrcode = convertCanvasToImage(canvsQrcode);
				$("#qrcode").after(imgQrcode);
				
            },
            error: function(oData, oStatus, eErrorThrow) {
            },
            complete: function (oXmlHttpRequest, oStatus) {
                $.unblockUI();
            }
        };
        //$.blockUI(dayspring.getBlockOption());
        $.ajax(oAjaxOption);
    }

    renderPage();

    // 获取积分变动历史记录
	var oDataTableOption = dayspring.getDataTableOption(true);
	oDataTableOption.ajax = {
		type:"POST",
		url: sContextPath + "/rest/recmder/findIntegralChangedHistroyPage",
		contentType:"application/json",
		data: function (data) {
			var beginChangedTime = $("#criteriaBeginDate").val();
	    	var endChangedTime = $("#criteriaEndDate").val();
	    	var companyName = $("#criteriaCpy").val();
			_data = {};
			_data.draw = data.draw;
			_data.start = data.start;
			_data.length = data.length;
			_data.beginChangedTime = beginChangedTime;
			_data.endChangedTime = endChangedTime;
			_data.companyName = companyName;
			return JSON.stringify(_data);
	    }
	};

	oDataTableOption.columns = [
//		{data: null},
		{data: "changedValue"},
		{data: "changedReason"},
		{data: "companyName"},
		{data: "totalIntegral"},
		{data: "changedTime"}
	];
	oDataTableOption.aoColumnDefs = [
//		{
//			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
//				$(nTd).html(iRow+1);
//			},
//			aTargets: [0]
//		},
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				if(sData>0){
					$(nTd).html("+" +sData);
				}				
			},
			aTargets: [0]
		},
		{
			fnCreatedCell: function(nTd, sData, oData, iRow, iCol) {
				var date = new Date(sData);
				$(nTd).html(date.Format("yyyy-MM-dd HH:mm:ss"));
			},
			aTargets: [4]
		}
	];
	var oDataTable = $("#scroeHistory").DataTable(oDataTableOption);
	
	// 添加过滤按钮
    $("#scroeHistory_wrapper").find(".filter").html("<label class='pull-right'><a id='filter' class='btn btn-white btn-sm m-r-xs'><i class='fa fa-filter'></i> 筛选</a></label>");
    
    $("#filter").click(function() {
		//$("#criteriaForm")[0].reset();
        $("#criteriaModal").modal("show");
    });    
    
    $("#confirmEditAddress").click(function(){
    	// 单项目验证
		if (!$("#editAddressForm").valid()) {
			return false;
		}
		// 异步数据提交
		var oAjaxOption = {
			type : "PUT",
			url : sContextPath + "/rest/recmder/saveAddressInfo",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify($("#editAddressForm").form2object()),
			success : function(json) {
				dayspring.checkAuth(json);
				if (json.code != 200) {
					swal("操作提示", json.message, "error");
				} else {
					$("#addressId").val(json.data.id);
					$("#address").html(json.data.contacter + "/" + json.data.contactTel + "/" + json.data.address);
					$("#editAddressModal").modal("hide");
					swal("操作提示", json.message, "success");
				}
			},
			error : function(oData, oStatus, eErrorThrow) {
				
			},
			complete : function(oXmlHttpRequest, oStatus) {
				$.unblockUI();
			}
		};
		$.blockUI(dayspring.getBlockOption());

		$.ajax(oAjaxOption);
    })

	$("#confirmEditCompany").click(function(){
		// 单项目验证
		if (!$("#editCompanyForm").valid()) {
			return false;
		}
		// 异步数据提交
		var oAjaxOption = {
			type : "PUT",
			url : sContextPath + "/rest/recmder/saveRecmderCompany",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify($("#editCompanyForm").form2object()),
			success : function(json) {
				dayspring.checkAuth(json);
				if (json.code != 200) {
					swal("操作提示", json.message, "error");
				} else {
					$("#companyInfo").html(json.data.companyName + "/" + json.data.companyTitle); 
					$("#editCompanyModal").modal("hide");
					swal("操作提示", json.message, "success");
				}
			},
			error : function(oData, oStatus, eErrorThrow) {

			},
			complete : function(oXmlHttpRequest, oStatus) {
				$.unblockUI();
			}
		};
		$.blockUI(dayspring.getBlockOption());

		$.ajax(oAjaxOption);
	})

    $("#confirmUpdatePassword").click(function(){
    	// 单项目验证
		if (!$("#updatePasswordForm").valid()) {
			return false;
		}
		// 异步数据提交
		var oAjaxOption = {
			type : "PUT",
			url : sContextPath + "/rest/recmder/updateRecmderPwd",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify($("#updatePasswordForm").form2object()),
			success : function(json) {
				dayspring.checkAuth(json);
				if (json.code != 200) {
					swal("操作提示", json.message, "error");
				} else {
					$("#updatePasswordModal").modal("hide");
					swal("操作提示", json.message, "success");
				}
			},
			error : function(oData, oStatus, eErrorThrow) {
				
			},
			complete : function(oXmlHttpRequest, oStatus) {
				$.unblockUI();
			}
		};
		$.blockUI(dayspring.getBlockOption());

		$.ajax(oAjaxOption);

    })
    
    $("#confirmcriteriaData").click(function(){
    	$("#criteriaModal").modal("hide");
    	oDataTable.ajax.reload();
    })

    $("#exchange").click(function(){
        location.href = sContextPath + "/rest/recmder/goodsExchangedList";
    })

})