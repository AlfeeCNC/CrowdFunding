var resultModal = new bootstrap.Modal(document.getElementById('result-modal'));
var currentProductNumber = 1;

// 若865<發文手續費，跳出modal引導至購買頁面
(async () => {
    const accounts = await web3.eth.getAccounts();
    if(accounts[0]!=undefined){
        const balanceOfTx = await platformTokenContract.methods.balanceOf(accounts[0]).call()
        .then(userBalance => {
            console.log(userBalance)
            if(userBalance < 50){
                $("#balance-alert").show();
            }else{
                $("#balance-alert").hide();
            }
            $("#wallet_address").val(accounts[0]);
            $("#wallet-alert").hide();
        });
    }else{
        $("#wallet-alert").show();
    }
})();

//偵測預計發行商品數下拉選單，產生對應之商品編輯cards
$("#store_number").on('change',function(){
    console.log($("#profit_sharing_start_date").val());
    var number = $(this).find("option:selected").attr("value");
    console.log(number);
    if(number != currentProductNumber){
        console.log("true");
        $(`input[id*='store'], textarea[id*='store']`).attr("disabled", true);

        switch(number){
            case "1":
                $(`input[id*='store'], textarea[id*='store']`).attr("disabled", true);
                $(`input[id*='store1'], textarea[id*='store1']`).attr("disabled", false);
                currentProductNumber = 1;
                break;
            case "2":
                $(`input[id*='store'], textarea[id*='store']`).attr("disabled", true);
                $(`input[id*='store1'], textarea[id*='store1']`).attr("disabled", false);
                $(`input[id*='store2'], textarea[id*='store2']`).attr("disabled", false);
                currentProductNumber = 2;
                break;
            case "3":
                $(`input[id*='store'], textarea[id*='store']`).attr("disabled", true);
                $(`input[id*='store1'], textarea[id*='store1']`).attr("disabled", false);
                $(`input[id*='store2'], textarea[id*='store2']`).attr("disabled", false);
                $(`input[id*='store3'], textarea[id*='store3']`).attr("disabled", false);
                currentProductNumber = 3;
                break;
            case "4":
                $(`input[id*='store'], textarea[id*='store']`).attr("disabled", true);
                $(`input[id*='store1'], textarea[id*='store1']`).attr("disabled", false);
                $(`input[id*='store2'], textarea[id*='store2']`).attr("disabled", false);
                $(`input[id*='store3'], textarea[id*='store3']`).attr("disabled", false);
                $(`input[id*='store4'], textarea[id*='store4']`).attr("disabled", false);
                currentProductNumber = 4;
                break;
        }
    }
});

$("#create-plan-for-store-form").on('submit',function(e){
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
            url: "create-fundraising-store-plan",
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
