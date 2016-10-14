;$(function(){

    // ContextPath
    var sContextPath = dayspring.getContextPath();

	var _href = location.href;
	var _str  = "/";
	var _index  = _href.lastIndexOf(_str);
	var _id = _href.substring(_index+1);
	var _phone;

	$("#scoreDet,#excRec,#recCpy").addClass("disabled");
	$("#getPasswordModal").find(".reset-modal").remove();
	var updateScoreForm = $("#updateScoreForm").validate(dayspring.getValidationOption());

	function renderPage(){
		var oAjaxOption = {
			type: "GET",
			url: sContextPath + "/rest/admin/findRecomderBaseDetail/" + _id,
			contentType : "application/json",
			dataType : "json",
			success: function(json) {
				dayspring.checkAuth(json);
				if(json.code != 200){
					return false;
				}
				var addressInfo = json.data.addressInfo;
				var recmderInfo = json.data.recmderInfo;
				_phone = recmderInfo.hostTel;
				$("#scoreDet,#excRec,#recCpy").removeClass("disabled");
				$("#name").html(recmderInfo.hostName);
				$("#regTime").html(new Date(recmderInfo.createdTime).Format("yyyy-MM-dd HH:mm:ss"));
				$("#phone").html(recmderInfo.hostTel);
				$("#recCode").html(recmderInfo.userInviteCode);
				$("#sellCode").html(recmderInfo.sellerInviteCode);
				$("#selName").html(recmderInfo.sellerName);
				if(recmderInfo.companyName && recmderInfo.companyTitle){
					$("#cpyInfo").html(recmderInfo.companyName + "/" + recmderInfo.companyTitle);
				}
				if(recmderInfo.regOrigin == 1){
					$("#regOrigin").html("销售渠道(" + recmderInfo.sellerName + ")");
				}else{
					$("#regOrigin").html("外部渠道");
				}
				if(addressInfo){
					$("#address").html(addressInfo.contacter + "/" + addressInfo.contactTel + "/" + addressInfo.address);
				}
			},
			error: function(oData, oStatus, eErrorThrow) {
			},
			complete: function (oXmlHttpRequest, oStatus) {
				$.unblockUI();
			}
		};
		$.blockUI(dayspring.getBlockOption());
		$.ajax(oAjaxOption);
	}
	renderPage();

	function renderTable(){
		var oAjaxOption = {
			type: "GET",
			url: sContextPath + "/rest/admin/findRecomderStatDetail/" + _id,
			contentType : "application/json",
			dataType : "json",
			success: function(json) {
				dayspring.checkAuth(json);
				if(json.code != 200){
					return false;
				}
				$("#cpyNum").html(json.data.totalCompRegs);
				$("#empInNum").html(json.data.totalEntries);
				$("#empLogNum").html(json.data.totalLogins);
				$("#totSco").html(json.data.totalRecIntegral);
				$("#calSco").html(json.data.totalCost);
				$("#updSco").html(json.data.totalAdjusted);
				$("#letSco").html(json.data.totalIntegral);
			},
			error: function(oData, oStatus, eErrorThrow) {
			},
			complete: function (oXmlHttpRequest, oStatus) {
				$.unblockUI();
			}
		};
		$.blockUI(dayspring.getBlockOption());
		$.ajax(oAjaxOption);
	}
	renderTable();

	$("#editPassword").click(function(){
		swal({
			title:"操作提示", 
			text:"请确认您的操作，该操作无法更改！", 
			type:"warning",
			showCancelButton: true,
			confirmButtonText: "确认操作",
			cancelButtonText: "点错了，取消",
			},function(){
				var oAjaxOption = {
					type: "PUT",
					url: sContextPath + "/rest/admin/resetRecomderPassword/" + _id,
					contentType : "application/json",
					dataType : "json",
					success: function(json) {
						dayspring.checkAuth(json);
						if(json.code != 200){
							return false;
						}
						
						$("#nameMod").html($("#name").html());
						$("#mobMod").html($("#phone").html());
						$("#newPas").html(json.data);
						$("#getPasswordModal").modal("show");
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

	$("#editScore").click(function(){
		$("#updateScoreModal").modal("show");
	})

	$(".reset-modal").click(function(){
		updateScoreForm.resetForm();
	})

	$("#updateScoreCfm").click(function(){
		if($("#updateScoreForm").valid()){
			var isAdd = $("#addSco").is(':checked');
			var _adjustedValue = $("#adjustedValue").val();
			var _remark = $("#updScoMark").val();
			var oAjaxOption = {
				type: "PUT",
				url: sContextPath + "/rest/admin/adjustedRecomderIntegral",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({
					hostId:_id,
					adjustedType:isAdd,
					adjustedValue:_adjustedValue,
					remark:_remark
				}),
				success: function(json) {
					dayspring.checkAuth(json);
					if(json.code == 1022){
						swal("操作提示", json.message, "error");
						return false;
					}
					
					renderTable();
					$("#updateScoreModal").modal("hide");
				},
				error: function(oData, oStatus, eErrorThrow) {
				},
				complete: function (oXmlHttpRequest, oStatus) {
					$.unblockUI();
				}
			};
			$.blockUI(dayspring.getBlockOption());
			$.ajax(oAjaxOption);
		}
	})

	$("#scoreDet").click(function(){
		localStorage.setItem("phone",_phone);
		location.href= sContextPath + "/rest/admin/integralRecord";
	})

	$("#excRec").click(function(){
		localStorage.setItem("phone",_phone);
		location.href= sContextPath + "/rest/admin/exchangedRecord";
	})

	$("#recCpy").click(function(){
		localStorage.setItem("phone",_phone);
		location.href= sContextPath + "/rest/admin/recmderCompanyList";
	})
	
	$("#backStep").click(function(){
		location.href = sContextPath + "/rest/admin/findRecmderStatPage";
	})

})