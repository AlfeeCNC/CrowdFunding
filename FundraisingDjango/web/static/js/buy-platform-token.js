$(document).ready(function(){

    (async () => {
        const accounts = await web3.eth.getAccounts();
        if(accounts[0]!=undefined){
            // const balance = await web3.eth.getBalance(accounts[0]);
            // console.log("balance", web3.utils.fromWei(balance, "ether"));
            $("#wallet_address").val(accounts[0]);
            // 取得token balance
            // const tokenInst = new web3.eth.Contract(erc865Token.abi, erc865Token.address);
            // const balance = await tokenInst.methods.balanceOf(accounts[0]).call() 
            }    
    })();

    $('#checkout-btn').on('click',function(e){
        var amount = $('#erc-amount-input').val();
        if($("#wallet_address").val() == ''){
            alert('請先連結Metamask');
        }else if(amount == 0){
            alert('請輸入購買金額');
        }else{
            // var address = $('#inv_acc').val();
            // var contract = $('#ERC865Address').val();
            var data = {
                // 'ERC_address': contract,
                'ERC_amount': amount,
                'wallet_address': $("#wallet_address").val()
            }
            $.ajax({
                method: "POST",
                url: "post-buy-erc865",
                data: data,
                dataType: "html"
            }).done(function(res){
                $("#ecpay-form").html(res);
            });
        }
    });
});
