const statusChinese = {
    'fundraising':'募資中',
    'executing':'執行中'
};
const categoryChinese = {
    'tech':'科技產品',
    'design':'設計產品',
    'franchise':'加盟計畫',
    'activity':'活動計畫',
    'others':'其他類型'
};

function getData(status){
    $.ajax({
        method: "GET",
        url: "/web/get-plans/"+status,
        dataType: "json"
    }).done(function(res){
        plans = JSON.parse(res["plans"])
        $("#data-row").html("");
        if(plans.length > 0){
            plans.forEach(function(plan){
                field = plan["fields"];
                percent = Math.round(parseInt(field.current_money)/parseInt(field.threshold_amount)*100);
                var card = `<div class="col">
                    <a class="card-link" href="/web/${field.status}-plan/${plan.pk}">
                        <div class="card h-100">
                            <img src="${field.image}" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">${field.title}</h5>
                                <p class="card-text">${field.content}</p>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: ${percent}%"
                                        aria-valuenow="${percent}" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <p>
                                    <small class="text-primary me-2">${percent}%</small>
                                    <small class="text-primary"></small></p>
                                <span class="badge card-${field.status}">${statusChinese[field.status]}</span>
                                <span class="badge bg-secondary">${field.category}</span>
                            </div>
                        </div>
                    </a>
                </div>`;
                $("#data-row").append(card);
            });
        }else{
            var alert = '<div class="col-12"><div class="alert alert-secondary text-center" role="alert"> 尚無計畫 </div></div>';
            $("#data-row").append(alert);
        }
       
        // res.plans.forEach(plan => {
        //     console.log(plan.id);
  
        // });

    });
}

getData("all");

$(".status-btns").on("click",function(e){
    var status = $(this).attr("status");
    $(".status-btns").removeClass("bg-danger");
    $(this).addClass("bg-danger");
    getData(status);
});