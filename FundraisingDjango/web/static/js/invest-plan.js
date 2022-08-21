var resultModal = new bootstrap.Modal(document.getElementById('result-modal'));

$("input").on("input",function(e){
    var sum = 0;
    $("input").each(function(){
        if($(this).val() != ""){
            var value = parseFloat($(this).val());
            sum += value;
        }
    })
    $("#invest-total").text(sum);
});

(async () => {
    const accounts = await web3.eth.getAccounts();
    if(accounts[0]!=undefined){
        $("#wallet_address").val(accounts[0]);
        }    
})();

$("#invest-products-form").on('submit',function(e){
    e.preventDefault()
    var userToken = parseInt($("#user-token-amount").text());
    var investTotal = parseInt($("#invest-total").text());
    var planId = $(this).attr("plan-id");
    if(userToken<investTotal){
        alert("請先儲值平台幣");
    }else if(investTotal == 0){
        alert("請輸入投資金額");
    }
    else{
        var formData = new FormData(this);
        ethereum.request({ method: 'eth_requestAccounts' }).then(async function(){
            web3.eth.getAccounts()
            .then(accounts =>{
                var nonce = Math.round(+new Date()/1000);
                console.log(nonce);
                var hashToSign = createSig(investTotal, nonce);
                console.log(hashToSign);
                web3.eth.sign(hashToSign, accounts[0],function(err,signature){
                    console.log(signature);
                    formData.append("signature",signature);
                    formData.append("amount",investTotal);
                    formData.append("sigNonce",nonce);
                    formData.append("wallet_address",accounts[0])
                    if(!err){
                        $.ajax({
                            method: "POST",
                            url: `${planId}/invest-fundraising-products`,
                            // url: 'post-transfer-token',
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
                            resultModal.show();
                        });
                    }
                })
                  
            });
            
        });
    
    }
});

function createSig(price, nonce) {
    var hashToSign = web3.utils.soliditySha3({
        type: 'bytes4',
        value: "48664c16"
    }, {
        type: 'address',
        value: PlatformTokenContractAddress
    }, {
        type: 'address',
        value: "0x6b45771c0502bA39f933D1037cB4f59B635eb906"
    }, {
        type: 'uint256',
        value: price
    }, {
        type: 'uint256',
        value: 0
    }, {
        type: 'uint256',
        value: nonce
    });
    return hashToSign;
}
