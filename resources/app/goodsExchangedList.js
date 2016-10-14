;$(function(){

    // ContextPath
    var sContextPath = dayspring.getContextPath();

    $("#denyChange").find(".reset-modal").remove();
    $("#goodsDetails").find(".reset-modal").remove();

    //render the goods list
    function goodsBoxRender(id,data){
        for(var i=0;i<data.length;i++){
            $(id).append(
                '<div class="col-md-6 col-lg-4 col-sm-12 goods-wrapper">'+
                    '<div class="goods-box">'+
                        '<div class="describe">'+
                            '<span class="goods-name">'+ data[i].goodsName +'</span>'+
                            '<span class="goods-price"><span class="orange">'+data[i].integralValue+'</span>积分</span>'+
                            '<input type="button" class="btn btn-primary btn-xs change-btn" value="兑 换" data-id="'+data[i].id+'"data-price='+data[i].integralValue +' />'+
                        '</div>'+
                        '<img src="/resources/integral-goods/'+data[i].coverPicUrl+'" data-id="'+data[i].id+'" data-name="'+data[i].goodsName +'" data-details="'+data[i].contentPicUrl +'" data-detailstxt="'+data[i].goodsContent+'"data-price='+data[i].integralValue +' class="goods" />'+
                    '</div>'+
                '</div>'
            )
        }
    }

    //render the page
    function renderPage(){
        var oAjaxOption = {
            type: "GET",
            url: sContextPath + "/rest/recmder/findIntegralExchangeData",
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
                if(recmderInfo.regOrigin == 1){
                    $("#recommendedPerson").html("销售渠道(" + recmderInfo.sellerName + ")");
                }else{
                    $("#recommendedPerson").html("外部渠道");
                }

                goodsBoxRender("#goodsList",json.data.integralGoodsList);

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

    //confirm to changing goods
    function changeGoodsConfirm(id,price){
        swal({
            title: "<h3>兑换将消耗积分</h3>",
            text: "<h1 class='orange'>"+price+"</h1>",
            html: true,
            showCancelButton: true,
            confirmButtonText:"确定",
            cancelButtonText:"取消"
        },function(){
            checkScore(id);
        }
        );
    }

    //check score
    function checkScore(id){
        $.ajax({
            type: "GET",
            url: sContextPath + "/rest/recmder/exchangeGoods/" + id,
            success: function (json) {
                dayspring.checkAuth(json);

                if (json.code == 1020) {
                    // 推荐人二维码
                    $('#qrcode').qrcode({
                        width: 128,
                        height: 128,
                        text: "https://hr.ibanbu.com/comp/apply/wizard/index?invite=" + json.data
                    })
                    // Converts canvas to an image
                    function convertCanvasToImage(canvas) {
                        var image = new Image();
                        image.src = canvas.toDataURL("image/png");
                        return image;
                    }

                    var canvsQrcode = $("#qrcode").find("canvas")[0];
                    var imgQrcode = convertCanvasToImage(canvsQrcode);
                    $("#qrcode").html(imgQrcode);

                    $('#shareBtn').click(function(){
                        window.open(sContextPath + "/rest/share/" + json.data);
                    })

                    $("#denyChange").modal("show");
                }
                else if(json.code == 200){
                    if(!json.data){
                        $(".addressModalTitle").html("请完善您的收货/收款信息");
                        $("#confirmEditAddress").data("id",id);
                        $("#editAddressModal").modal("show");
                    }
                    else{
                        $(".addressModalTitle").html("请确认您的收货/收款信息");
                        $("#orderName").val(json.data.contacter);
                        $("#orderPhone").val(json.data.contactTel);
                        $("#orderAddress").val(json.data.address);
                        $("#confirmEditAddress").data("id",id);
                        $("#editAddressModal").modal("show");
                    }
                }
            },
            error: function(oData, oStatus, eErrorThrow) {
            },
            complete: function (oXmlHttpRequest, oStatus) {

            }
        })
    }


    $("body").on("click",".change-btn",function(){
        var id = $(this).data("id");
        var price = $(this).data("price");
        changeGoodsConfirm(id,price);
    })

    $("body").on("click","#modalChangeBtn",function(){
        $("#goodsDetails").modal("hide");
        var id = $(this).data("id");
        var price = $(this).data("price");
        changeGoodsConfirm(id,price);
    })

    $("body").on("click",".goods",function(){
        var name = $(this).data("name");
        var id = $(this).data("id");
        var price = $(this).data("price");
        var txt = $(this).data("detailstxt");
        var details = $(this).data("details");
        $("#goodsTitle").html(name);
        $("#modalChangeBtn").data("id",id);
        $("#modalChangeBtn").data("price",price);
        $("#goodsTxt").html(txt);
        $(".goodsDetailsImg").html('<img src="/resources/integral-goods/'+details +'" class="goods-detimg" />');
        $("#goodsDetails").modal("show");
    })

    //confirm the address and change goods
    $("#confirmEditAddress").click(function(){
        // 单项目验证
        if (!$("#editAddressForm").valid()) {
            return false;
        }
        id = $(this).data("id");
        // 异步数据提交
        var oAjaxOption = {
            type : "POST",
            url: sContextPath + "/rest/recmder/exchangeGoodsCommit/" + id,
            contentType : "application/json",
            dataType : "json",
            data : JSON.stringify($("#editAddressForm").form2object()),
            success : function(json) {
                dayspring.checkAuth(json);
                if (json.code != 200) {
                    swal("操作提示", json.message, "error");
                } else {
                    $("#score").html(json.data);
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

    renderPage();

})