var resultModal = new bootstrap.Modal(document.getElementById('detail-modal'));

$(".invest-detail-btns").on("click",function(e){
    var planId = $(this).attr("plan-id");
    var productId = $(this).attr("product-id");
    $.ajax({
        method: "POST",
        url: "get-user-investments-by-plan-product-id",
        data: {
            'plan_id':planId,
            'product_id':productId
        },
        dataType: "json",
    }).done(function(res){
        var investRecord = JSON.parse(res["invest_record"])
        var plan = JSON.parse(res["plan"])
        var product = JSON.parse(res["product"])
        $("#plan-title-modal").text(plan[0]["fields"]["title"])
        $("#product-title-modal").text(product[0]["fields"]["title"])
        $("#invest-record-body").html("")
        investRecord.forEach(record => {
            var field = record["fields"];
            switch(field.type){
                case "transfer":
                    field.amount = "轉出" + field.amount;
                    break;
                case "invest":
                    field.amount = "投資" + field.amount;
                    break;
                case "receive":
                    field.amount = "轉入" + field.amount;
                    break;
            }
     
            var createDate = moment(field.created_at).format('YYYY-MM-DD HH:mm');
            var row = `  <tr>
                            <td>${createDate}</td>
                            <td>${field.amount}</td>
                            <td><a href='${field.etherscan_url}' class='etherscan-url' target='_blank'>前往Etherscan紀錄</a></td>
                        </tr>`
            $("#invest-record-body").append(row);
        });
        $("#profit-record-body").html(` <tr>
                <td colspan="4">計畫結束後進行分潤</td>
            </tr>`);
        if(plan[0]["fields"]["status"] == 'closed'){
            var data = JSON.parse(res["profit"])
            var profitCreateDate = moment(data[0]["fields"]["created_at"]).format('YYYY-MM-DD HH:mm');
            var profitRow = `  <tr>
                                <td>${data[0]["fields"]["plan"]}</td>
                                <td>${product[0]["fields"]["title"]}</td>
                                <td>${data[0]["fields"]["profit"]}</td>
                                <td>${profitCreateDate}</td>
                            </tr>`
            $("#profit-record-body").html(profitRow);
        }
        resultModal.show();
    });
});