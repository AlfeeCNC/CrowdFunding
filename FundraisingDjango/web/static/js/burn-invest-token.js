var resultModal = new bootstrap.Modal(document.getElementById('result-modal'));


(async () => {
    const accounts = await web3.eth.getAccounts();
    if(accounts[0]!=undefined){
        $("#wallet_address").val(accounts[0]);
        }    
})();

$("#transfer-invest-token-form").on('submit',function(e){
    e.preventDefault()
    var userToken = parseInt($("#invest-token-amount").text());
    var amount = $("#erc-amount-input").val();
    var to = $("#transfer-to-address").val();
    if(userToken<amount){
        alert("僅可轉出低於所擁有的投資憑證數");
    }
    else{
        var formData = new FormData(this);
        ethereum.request({ method: 'eth_requestAccounts' }).then(async function(){
            web3.eth.getAccounts()
            .then(accounts =>{
                var nonce = Math.round(+new Date()/1000);
                console.log(nonce);
                var hashToSign = createSig(to, amount, nonce);
                console.log(hashToSign);
                web3.eth.sign(hashToSign, accounts[0],function(err,signature){
                    console.log(signature);
                    formData.append("signature",signature);
                    formData.append("sigNonce",nonce);
                    formData.append("wallet_address",accounts[0])
                    if(!err){
                        $.ajax({
                            method: "POST",
                            url: `post-burn-invest-token`,
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

function createSig(to, price, nonce) {
    var hashToSign = web3.utils.soliditySha3({
        type: 'bytes4',
        value: "48664c16"
    }, {
        type: 'address',
        value: InvestmentTokenContractAddress
    }, {
        type: 'address',
        value: to
    },{
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
