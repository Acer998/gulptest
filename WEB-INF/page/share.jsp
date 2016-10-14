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
    	body{
    	background-color: #fff;
    	}
    	#shareBtn{
    		width:256px;
    	}
    	#qrcode canvas{
            display: none;
        }
    </style>
</head>
<body>
    <div class="container" style="margin-top:120px;">
        <div class="row">
        	<div class="col-sm-12 text-center" style="font-size:1.5em;line-height:1.5em;margin-bottom:10px;">
        	扫一扫二维码，立刻注册班步<br />
        	开启便捷人事办公之旅
        	</div>
            <div class="col-sm-12 text-center" id="qrcode" style="line-height:1.5em;margin-bottom:10px;"></div>
            <div class="col-sm-12 text-center">
            	<input type="button" class="btn btn-primary" id="shareBtn" value="开启注册" />
            </div>
        </div>
    </div>
    <script src="/resources/lib/jquery.min.js" type="text/javascript"></script>
    <script src="/resources/lib/jquery.qrcode.min.js" type="text/javascript"></script>
    <script>
        //根据QueryString参数名称获取值
        function getQueryStringByName(name){
            var result = location.search.match(new RegExp("[\?\&]" + name+ "=([^\&]+)","i"));
            if(result == null || result.length < 1){
                return "";
            }
            return result[1];
        }
        ;$(function(){
        	$("#shareBtn").click(function(){
        		location.href = 'https://hr.ibanbu.com/comp/apply/wizard/index?invite=<%=request.getAttribute("userInviteCode") %>';
        	})
            $('#qrcode').qrcode({
            	width: 256,
            	height: 256,
            	text: 'https://hr.ibanbu.com/comp/apply/wizard/index?invite=<%=request.getAttribute("userInviteCode") %>'
            })
            // Converts canvas to an image
				function convertCanvasToImage(canvas) {
					var image = new Image();
					image.src = canvas.toDataURL("image/png");
					return image;
				}

				var canvsQrcode = $("#qrcode").find("canvas")[0];
				var imgQrcode = convertCanvasToImage(canvsQrcode);
				$("#qrcode").append(imgQrcode);
        })
    </script>
    <%@include file="inc/baiduStatistics.jsp"%>
</body>
</html>