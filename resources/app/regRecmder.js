;
$(function() {

	// ContextPath
	var sContextPath = dayspring.getContextPath();

	var codeKey;

	var oValidator = $("#pageForm").validate(dayspring.getValidationOption());
	var oModalValidator = $("#sendMsgModalForm").validate(
			dayspring.getValidationOption());
	

	// 60秒倒计时
	var iCountdown = 60;

	// 实现60秒倒计时
	function setCountdownTime($obj, sBtnText) {
		if (iCountdown < 0) {
			$obj.forbid("disabled", false);
			$obj.val("重发验证码");
			iCountdown = 60;
			return;
		} else {
			$obj.forbid("disabled", true);
			if (sBtnText == "重发验证码") {
				$obj.val("已重发(" + iCountdown + ")");
			} else {
				$obj.val("已发送(" + iCountdown + ")");
			}
			iCountdown--;
		}
		setTimeout(function() {
			setCountdownTime($obj, sBtnText)
		}, 1000);
	}

	$("#mobileNumber").blur(
					function() {
						// 验证手机号格式是否正确
						if (!oValidator.element("#mobileNumber")) {
							$("#getMobileCaptcha").attr("disabled", "disabled");
							$("#next").attr("disabled", "disabled");
							return false;
						}
						var phone = $("#mobileNumber").val();
						var oAjaxOption = {
							type : "GET",
							url : sContextPath
									+ "/rest/recmder/findAccByTelNo/" + phone,
							contentType : "application/json",
							dataType : "json",
							success : function(json) {
								dayspring.checkAuth(json);
								if (json.code != 200) {
									$("#mobileNumber")
											.after(
													'<label id="mobileNumber-error" class="error" for="mobileNumber">'
															+ json.message
															+ '</label>');
									$("#getMobileCaptcha").attr("disabled",
											"disabled");
									$("#next").attr("disabled", "disabled");
								} else {
									$("#getMobileCaptcha").removeAttr(
											"disabled");
									$("#next").removeAttr("disabled");
								}
							},
							error : function(oData, oStatus, eErrorThrow) {
							},
							complete : function(oXmlHttpRequest, oStatus) {
							}
						};
						$.ajax(oAjaxOption);
					})

					
	// 获取验证码
	var getChkCode = function() {
		codeKey = Math.uuid(20);
		$("#img_captcha").attr("src",sContextPath + "/rest/getPicValidationCode/" + codeKey);
	}

	getChkCode();

	// 更新验证码
	 $("#chgCaptcha,#img_captcha").click(function(){
	 getChkCode();
	 })

						
	// 【获取短信验证码】按钮点击事件绑定
	$("#getMobileCaptcha").click(
			function() {
				// 验证手机号格式是否正确
				 if(!oValidator.element("#mobileNumber")) {
				 return false;
				 }
				 // 验证码图片刷新
				 $("#chgCaptcha").trigger("click");
				 // 验证码清除
				 $("#input-jcaptchaCode").val("");
				 // 发送短信验证码模态打开
				 $("#sendMsgModal").modal();
				
			});
	 
	 

	// 发送手机验证码模态【发送】按钮点击事件绑定
	 $("#sendMobileCaptcha").click(function() {
		 // 单项目验证
		 if (!$("#sendMsgModalForm").valid()) {
			 return false;
		 }
		
		 var codeValue = $("#input-jcaptchaCode").val();
			var _data = {
				codeKey : codeKey,
				codeValue : codeValue
			}
		var oAjaxOption = {
			type : "POST",
			url : sContextPath + "/rest/validationPicValidationCode/",
			data : JSON.stringify(_data),
			contentType:"application/json",
			success : function(json) {
				dayspring.checkAuth(json);
				if (json.code != 200) {
					swal("操作提示", json.message, "warning");
					// 验证码图片刷新
					 $("#chgCaptcha").trigger("click");
					return;
				} 
				var phone = $("#mobileNumber").val();
				var oAjaxOption = {
					type : "GET",
					url : sContextPath + "/rest/recmder/getSmsValidationCode/"
							+ phone,
					contentType : "application/json",
					dataType : "json",
					success : function(json) {
						dayspring.checkAuth(json);
						if (json.code != 200) {
							$("#verificationCode").next("span").after(
									'<label id="mobileNumber-error" class="error" for="mobileNumber">'
											+ json.message + '</label>');
							$("#sendMsgModal").modal("hide");
						} else {
							$("#verificationCode").next("span").next("label")
									.remove();

							// 发送手机验证码模态关闭
							 $("#sendMsgModal").modal("hide");

							// 画面60秒倒计时设定
							setCountdownTime($("#getMobileCaptcha"), $(
									"#getMobileCaptcha").val());
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
			},
			error : function(oData, oStatus, eErrorThrow) {

			},
			complete : function(oXmlHttpRequest, oStatus) {
				$.unblockUI();
			}
		};
		$.blockUI(dayspring.getBlockOption());
		$.ajax(oAjaxOption);
		 
	 
	 });

	// 【下一步】按钮按下事件绑定
	$("#next").click(function() {
		// TODO 密码一致性校验

		// 单项目验证
		if (!$("#pageForm").valid()) {
			return false;
		}
		// 异步数据提交
		var oAjaxOption = {
			type : "PUT",
			url : sContextPath + "/rest/recmder/register",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify($("#pageForm").form2object()),
			success : function(json) {
				dayspring.checkAuth(json);
				if (json.code != 200) {
					swal("注册提示", json.message, "warning");
				} else {
					swal({
						title : "注册提示",
						text : "恭喜你，注册成功",
						type : "success",
					}, function() {
						location.href = sContextPath + "/rest/login";
					});
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
	});
	
	$("body").on("keydown",function(e){
		if(e.keyCode==13){
			var modalShow = $("#sendMsgModal").css("display");
			if(modalShow == "block"){				
				$("#sendMobileCaptcha").click();
			}
			else{
				$("#next").click();
			}
			
		}
	})

});