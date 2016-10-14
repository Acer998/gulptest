;
$(function() {

	var sContextPath = dayspring.getContextPath();

	var codeKey;

	// 获取验证码
	var getChkCode = function() {
		codeKey = Math.uuid(20);
		$("#jcaptchaCode").attr("src",
				sContextPath + "/rest/getPicValidationCode/" + codeKey);
	}

	getChkCode();

	// 点击获取验证码
	$(".jcaptcha-btn,#jcaptchaCode").click(function() {
		getChkCode();
	})
	
	$("#regedit").click(function(){
		location.href = sContextPath + "/rest/recmder/register";
	})

	// 提交登录
	$("#submit").click(function() {
		var userName = $("#username").val();
		var password = $("#password").val();
		var codeValue = $("#input-jcaptchaCode").val();
		var _data = {
			loginId : userName,
			password : password,
			codeKey : codeKey,
			codeValue : codeValue
		}

		$.ajax({
			type : "POST",
			url : sContextPath + "/rest/login",
			data : JSON.stringify(_data),
			contentType:"application/json",
			success : function(json) {
				dayspring.checkAuth(json);
				if (json.code != 200) {
					$("#errMsg").css("display", "block");
					$("#errMsg").html(json.message);
					$(".jcaptcha-btn").click();
					return;
				} 
				
				if(json.data == 1 || json.data == 2){
					location.href = sContextPath + "/rest/admin/findRecmderStatPage";
				}else if(json.data == 3){
					location.href = sContextPath + "/rest/recmder/home";
				}
			}
		})
	})

	$("body").on("keydown",function(e){
		if(e.keyCode==13){
			$("#submit").click();
		}
	})

})