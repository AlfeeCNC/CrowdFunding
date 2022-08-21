var resultModal = new bootstrap.Modal(document.getElementById('result-modal'));
var currentProductNumber = 1;

// 若865<發文手續費，跳出modal引導至購買頁面
(async () => {
    const accounts = await web3.eth.getAccounts();
    if(accounts[0]!=undefined){
        const balanceOfTx = await PlatformTokenContract.methods.balanceOf(accounts[0]).call()
        .then(userBalance => {
            console.log(userBalance)
            if(userBalance < 50){
                $("#balance-alert").show();
            }else{
                $("#balance-alert").hide();
            }
            $("#wallet_address").val(accounts[0]);
            console.log($("#wallet_address").val());
            $("#wallet-alert").hide();
        });
    }else{
        $("#wallet-alert").show();
    }
})();
//偵測預計發行商品數下拉選單，產生對應之商品編輯cards
$("#product_number").on('change',function(){
    var number = $(this).find("option:selected").attr("value");
    console.log(number);
    if(number != currentProductNumber){
        console.log("true");
        $(`input[id*='product'], textarea[id*='product']`).attr("disabled", true);

        switch(number){
            case "1":
                $(`input[id*='product'], textarea[id*='product']`).attr("disabled", true);
                $(`input[id*='product1'], textarea[id*='product1']`).attr("disabled", false);
                currentProductNumber = 1;
                break;
            case "2":
                $(`input[id*='product'], textarea[id*='product']`).attr("disabled", true);
                $(`input[id*='product1'], textarea[id*='product1']`).attr("disabled", false);
                $(`input[id*='product2'], textarea[id*='product2']`).attr("disabled", false);
                currentProductNumber = 2;
                break;
            case "3":
                $(`input[id*='product'], textarea[id*='product']`).attr("disabled", true);
                $(`input[id*='product1'], textarea[id*='product1']`).attr("disabled", false);
                $(`input[id*='product2'], textarea[id*='product2']`).attr("disabled", false);
                $(`input[id*='product3'], textarea[id*='product3']`).attr("disabled", false);
                currentProductNumber = 3;
                break;
            case "4":
                $(`input[id*='product'], textarea[id*='product']`).attr("disabled", true);
                $(`input[id*='product1'], textarea[id*='product1']`).attr("disabled", false);
                $(`input[id*='product2'], textarea[id*='product2']`).attr("disabled", false);
                $(`input[id*='product3'], textarea[id*='product3']`).attr("disabled", false);
                $(`input[id*='product4'], textarea[id*='product4']`).attr("disabled", false);
                currentProductNumber = 4;
                break;
        }
    }
});

$("#create-plan-for-product-form").on('submit',function(e){
    e.preventDefault()
    /*
        如果865夠發文
        1. 取得資料: (1)錢包地址 (2)表單資料
        2. 發送至後端: 
            (1) 更新用戶865數量
            (2) 呼叫合約，發erc721，取得721 plan token id & etherscan url 
            (3) 721資訊及計畫資訊紀錄至MySQL
        3. 顯示成功or失敗modal視窗
        否則
        跳出modal引導至購買頁面
    */
        var formData = new FormData(this);
        $.ajax({
            method: "POST",
            url: "create-fundraising-product-plan",
            data: formData,
            processData: false,
            contentType : false,
            dataType: "json",
            beforeSend:function(){
                $("#overlay-loading").css("display","block");
            }
        }).done(function(res){
            $("#overlay-loading").css("display","none");
            $("#result-msg").html(res.message);
            $("#etherscan-link").attr("href",res.etherscan_url)
            resultModal.show();
        });
        
});
