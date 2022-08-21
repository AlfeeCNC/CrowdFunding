from hexbytes import HexBytes
import json
import math
from toolz.itertoolz import count, diff
from web3 import Web3
from web3.middleware import geth_poa_middleware
from utils import utils
# Models
from django.db.models import Sum
from django.contrib.auth.models import User
from web.models import Test1, FundraisingPlan, Products, Member, InvestmentRecord, ProfitSharingRecord, SalesRecord
# from web.serializers import TestSerializer, FundraisingSerializer
from django.core import serializers
from rest_framework import viewsets
from rest_framework.parsers import JSONParser
from rest_framework import status
from django.contrib.auth.decorators import login_required
from datetime import datetime, date
from django.shortcuts import render, redirect
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView, View
from django.conf import settings

import importlib.util
spec = importlib.util.spec_from_file_location(
    "ecpay_payment_sdk",
    "web/ecpay_payment_sdk.py"
)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class HexJsonEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, HexBytes):
            return obj.hex()
        return super().default(obj)


# Ropsten Account
platform_account_address = "0x6b45771c0502bA39f933D1037cB4f59B635eb906"
private_key = "855700ea3bd9424346cb9260cec95d2c37bead3c26d8dc12324381ed74099eaf"

# Connecting to Infura
infura_url = "https://ropsten.infura.io/v3/c35b8c8620f747a3a6bdd04874ae101e"

# Initializing Web3
web3 = Web3(Web3.HTTPProvider(infura_url))
web3.middleware_onion.inject(geth_poa_middleware, layer=0)

'''
合約地址、平台幣、會員記錄、瀏覽計畫、建立募資計畫、投資計畫、正式計畫、計畫下之ERC1155項目
'''


'''
合約地址
'''

# 平台幣 865token 合約地址
platform_token_contract_address = web3.toChecksumAddress(
    '0x3D51653B9f1558822464cdb356cb53037B024bF5')
with open("web/config/865token/abi.json") as json_file:
    fundraising_plan_contract_abi = json.load(json_file)

platform_token_contract = web3.eth.contract(
    address=platform_token_contract_address, abi=fundraising_plan_contract_abi)


# 募資計畫之合約地址
fundraising_plan_contract_address = web3.toChecksumAddress(
    '0x0c51d8a542f44904d505a3ea4169410b0d3d7592')
with open("web/config/fundraising-plan/abi.json") as json_file:
    fundraising_plan_contract_abi = json.load(json_file)

fundraising_contract = web3.eth.contract(
    address=fundraising_plan_contract_address, abi=fundraising_plan_contract_abi)


# 投資募資計畫之合約地址
fundraising_investment_contract_address = web3.toChecksumAddress(
    '0x43e517B53035e24df132aa350251d468CF0E4a0e')
with open("web/config/investment/fundraising/abi.json") as json_file:
    fundraising_investment_contract_abi = json.load(json_file)

fundraising_investment_contract = web3.eth.contract(
    address=fundraising_investment_contract_address, abi=fundraising_investment_contract_abi)


# 正式計畫之合約地址
official_plan_contract_address = web3.toChecksumAddress(
    '0x794bf3ff3D658Cb054304bd49A3F71C56c8591d2')
with open("web/config/official-plan/abi.json") as json_file:
    official_plan_contract_abi = json.load(json_file)

official_contract = web3.eth.contract(
    address=official_plan_contract_address, abi=official_plan_contract_abi)


# ERC1155產品之合約地址
product_contract_address = web3.toChecksumAddress(
    '0x716c4FA0b6F38bB3283f7D519fE21bFabA1EF67A')
with open("web/config/product/abi.json") as json_file:
    product_contract_abi = json.load(json_file)

product_contract = web3.eth.contract(
    address=product_contract_address, abi=product_contract_abi)


# ERC865投資憑證之合約地址
investment_token_contract_address = web3.toChecksumAddress(
    '0xD8A10B864F45CB8B43E2C484664d7ba812762333')
with open("web/config/investment-token/abi.json") as json_file:
    investment_token_contract_abi = json.load(json_file)

investment_token_contract = web3.eth.contract(
    address=investment_token_contract_address, abi=investment_token_contract_abi)


'''
平台幣
'''


@login_required
def buy_platform_token(request):
    return render(request, "buy-token.html")


@login_required
@csrf_exempt
def buy_erc865(request):
    # context = {}
    if request.POST:
        payment_data = {
            # 訂單資訊
            "MerchantTradeNo": datetime.now().strftime("NO%Y%m%d%H%M%S"),
            "MerchantTradeDate": datetime.now().strftime("%Y/%m/%d %H:%M:%S"),
            "ReturnURL": "http://127.0.0.1:8000/payment/backend/return/",
            "ChoosePayment": "ALL",
            "PaymentType": "aio",
            # 商品資訊
            "TotalAmount": request.POST.get('ERC_amount'),
            "TradeDesc": "Mooba!購買ERC865",
            "ItemName": "ERC865平台幣",
            # === 選填欄位 ===
            "CustomField1": request.POST.get('wallet_address'),
            "OrderResultURL": "http://127.0.0.1:8000/web/get_ecpay_return",
        }

        # payment_data["CheckMacValue"] = createCheckValue(payment_data)

        # context.update({
        #     "ECPAY_API_URL": settings.ECPAY_API_URL,
        #     "formData": payment_data,
        # })
        # print(context)
        # return render(request, "hello_world.html", context)
        # 建立實體
        ecpay_payment_sdk = module.ECPayPaymentSdk(
            MerchantID=settings.ECPAY_MERCHEAT_ID,
            HashKey=settings.ECPAY_API_HASH_KEY,
            HashIV=settings.ECPAY_API_HASH_IV
        )

        try:
            # 產生綠界訂單所需參數
            final_order_params = ecpay_payment_sdk.create_order(payment_data)

            # 產生 html 的 form 格式
            action_url = settings.ECPAY_API_URL  # 測試環境
            # action_url = 'https://payment.ecpay.com.tw/Cashier/AioCheckOut/V5' # 正式環境
            html = ecpay_payment_sdk.gen_html_post_form(
                action_url, final_order_params)
            return HttpResponse(html)
        except Exception as error:
            print('An exception happened: ' + str(error))

# 4311-9522-2222-2222
# 222


@method_decorator(csrf_exempt, name='dispatch')
class PaymentReturnView(View):
    def post(self, request, *args, **kwargs):
        # request.POST 由綠界回傳的付款結果
        res = request.POST.dict()
        if(res['RtnMsg'] == 'Succeeded'):
            # 呼叫平台幣合約 將token發送給用戶帳號
            amount = int(res['TradeAmt'])
            to_address = web3.toChecksumAddress(res['CustomField1'])
            etherscan_url = transfer_865token_from_contract(amount, to_address)
            print(etherscan_url)
            msg = '平台幣購買成功！'
            return render(request, "ecpay-result.html", {'success': True, 'msg': msg, 'etherscan_url': etherscan_url})
        else:
            msg = '平台幣購買未成功，請稍後再試！'
            return render(request, "ecpay-result.html", {'success': False, 'msg': msg})


def transfer_865token_from_contract(amount, to_address):
    '''
    呼叫合約，轉移/發送 865 token
    '''
    # make transaction
    transaction = platform_token_contract.functions.get865FromContract(to_address, amount).buildTransaction({
        'chainId': 3,
        'gas': 700000,
        'nonce': web3.eth.get_transaction_count(platform_account_address),
    })
    signed_tx = web3.eth.account.sign_transaction(
        transaction, private_key)
    tx_hash = web3.eth.send_raw_transaction(signed_tx.rawTransaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(
        tx_hash, timeout=1000)
    tx_json = Web3.toJSON(tx_receipt)
    tx_json_loads = json.loads(tx_json)
    print(tx_json_loads)

    etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
        tx_json_loads["logs"][0]["transactionHash"]
    return etherscan_url


'''
會員記錄
'''


@login_required
def get_member_info(request):
    '''
    會員主頁面
    '''
    # platform_token = Member.objects.get(user_id=request.user.id).platform_token
    user = User.objects.get(username=request.user.username)

    # 提案 募資計畫數目
    fundraising_plan_count = FundraisingPlan.objects.filter(
        initiator_id=user.id, status='fundraising').count()

    # 提案 正式計畫數目
    executing_plan_count = FundraisingPlan.objects.filter(
        initiator_id=user.id, status='executing').count()

    # 投資計畫數
    invest_plan_count = InvestmentRecord.objects.filter(
        user_id=request.user.id).values('plan_id').distinct().count()

    return render(request, "member-info.html", {'user': user, 'fundraising_count': fundraising_plan_count, 'executing_count': executing_plan_count, 'invest_plan_count': invest_plan_count})


@login_required
def member_history_record(request):
    '''
    會員歷史紀錄頁面
    '''

    investments = InvestmentRecord.objects.filter(user_id=request.user.id).values(
        'plan_id', 'product_id').annotate(data_sum=Sum('amount'))

    for invest in investments:

        plan = FundraisingPlan.objects.get(id=invest["plan_id"])

        # 撈出 此計畫此產品 type == transfer for loop 扣除 掉 amount
        transfer_records = InvestmentRecord.objects.filter(
            user_id=request.user.id, plan_id=invest["plan_id"], product_id=invest["product_id"], type='transfer')

        for transfer_record in transfer_records:

            invest["data_sum"] = int(
                invest["data_sum"]) - int(transfer_record.amount)*2

        invest["status"] = plan.status
        invest["plan_title"] = plan.title
        product = Products.objects.get(
            plan_id=invest["plan_id"], product_id=invest["product_id"])
        invest["product_title"] = product.title
        if invest["status"] == 'executing':
            invest["statusChinese"] = '執行中'
        elif invest["status"] == 'fundraising':
            invest["statusChinese"] = '募資中'
        elif invest["status"] == 'closed':
            invest["statusChinese"] = '已結束'

    print(investments)
    return render(request, "member-record.html", {'investments': investments})


@login_required
@csrf_exempt
def get_user_investments_by_plan_product_id(request):
    '''
    會員歷史紀錄->我的投資記錄->點選「查看詳細資訊」
    '''
    data = request.POST.dict()
    plan_id = data["plan_id"]
    product_id = data["product_id"]
    user_id = request.user.id
    # 此用戶某計畫某產品之投資紀錄
    invest = InvestmentRecord.objects.filter(
        user_id=user_id, plan_id=plan_id, product_id=product_id)

    invest_record_json = serializers.serialize("json", invest)

    # plan info
    plan = FundraisingPlan.objects.get(id=plan_id)
    plan_json = serializers.serialize("json", [plan])
    # product info
    product = Products.objects.filter(plan_id=plan_id, product_id=product_id)
    product_json = serializers.serialize("json", product)
    profit_json = []
    if plan.status == 'closed':
        profit = ProfitSharingRecord.objects.get(
            user_id=user_id, plan_id=plan_id, product_id=product_id)
        profit_json = serializers.serialize("json", [profit])

    return JsonResponse({"invest_record": invest_record_json, "plan": plan_json, "product": product_json, "profit": profit_json})


def get_initiator_all_plans(request, username):
    '''
    user之所有提案
    '''
    user = User.objects.get(username=username)
    fundraising_plans = FundraisingPlan.objects.filter(
        initiator_id=user.id, status='fundraising')
    executing_plans = FundraisingPlan.objects.filter(
        initiator_id=user.id, status='executing')
    closed_plans = FundraisingPlan.objects.filter(
        initiator_id=user.id, status='closed')

    plan_sum = FundraisingPlan.objects.filter(
        initiator_id=user.id).count()
    return render(request, "initiator-all-plans.html", context={"fundraising_plans": fundraising_plans, "executing_plans": executing_plans, "user": user, "plan_sum": plan_sum, "closed_plans": closed_plans})


'''
瀏覽計畫
'''


@csrf_exempt
def index(request):
    return render(request, "index.html")


@csrf_exempt
def get_plans_by_status(request, status):
    if(status == "all"):
        plans = FundraisingPlan.objects.exclude(status='closed')
    elif status == "計畫及商品" or status == "加盟及分店":
        plans = FundraisingPlan.objects.filter(category=status)
    else:
        plans = FundraisingPlan.objects.filter(status=status)

    ajax_data = serializers.serialize("json", plans)
    return JsonResponse({"plans": ajax_data})


def get_one_fundraising_plan(request, id):
    '''
    瀏覽特定募資計畫頁面
    '''
    fundraising_plan = FundraisingPlan.objects.get(id=id)
    initiator = User.objects.get(id=fundraising_plan.initiator_id)
    products = Products.objects.filter(plan_id=id)
    countdown = get_countdown_to_a_certain_day(
        fundraising_plan.fundraising_end_date)

    fundraising_plan.fundraising_start_date = fundraising_plan.fundraising_start_date.strftime(
        '%Y-%m-%d %H:%M')
    fundraising_plan.fundraising_end_date = fundraising_plan.fundraising_end_date.strftime(
        '%Y-%m-%d %H:%M')
    fundraising_plan.execution_start_date = fundraising_plan.execution_start_date.strftime(
        '%Y-%m-%d %H:%M')

    if fundraising_plan.category == '加盟及分店':
        fundraising_plan.profit_sharing_start_date = fundraising_plan.profit_sharing_start_date.strftime(
            '%Y-%m-%d %H:%M')
    else:
        fundraising_plan.execution_end_date = fundraising_plan.execution_end_date.strftime(
            '%Y-%m-%d %H:%M')

    progress = round(fundraising_plan.current_money /
                     fundraising_plan.threshold_amount*100, 2)

    investors = InvestmentRecord.objects.filter(
        plan_id=id).values('user_id').distinct().count()
    invest_records = InvestmentRecord.objects.filter(plan_id=id)

    return render(request, "fundraising-plan-page.html", context={"plan": fundraising_plan, "products": products, "countdown": countdown, "progress": progress, "investors": investors, "invest_records": invest_records, 'initiator': initiator.username})


def get_one_executing_plan(request, id):
    '''
    瀏覽特定執行中計畫頁面
    '''
    plan = FundraisingPlan.objects.get(id=id)
    initiator = User.objects.get(id=plan.initiator_id)
    products = Products.objects.filter(plan_id=id)
    countdown = get_countdown_to_a_certain_day(
        plan.execution_end_date)

    plan.fundraising_start_date = plan.fundraising_start_date.strftime(
        '%Y-%m-%d %H:%M')
    plan.fundraising_end_date = plan.fundraising_end_date.strftime(
        '%Y-%m-%d %H:%M')
    plan.execution_start_date = plan.execution_start_date.strftime(
        '%Y-%m-%d %H:%M')
    plan.execution_end_date = plan.execution_end_date.strftime(
        '%Y-%m-%d %H:%M')
    progress = round(plan.current_money /
                     plan.threshold_amount*100, 2)

    investors = InvestmentRecord.objects.filter(
        plan_id=id).values('user_id').distinct().count()
    invest_records = InvestmentRecord.objects.filter(plan_id=id, type='invest')

    for invest in invest_records:
        product = Products.objects.get(
            plan_id=invest.plan_id, product_id=invest.product_id)
        invest.product_title = product.title
        print(invest)

    sales_records = SalesRecord.objects.filter(plan721_id=plan.plan721_id)
    for record in sales_records:
        product = Products.objects.get(product_1155_id=record.product1155_id)
        record.product_title = product.title

    return render(request, "executing-plan-page.html", context={"plan": plan, "products": products, "countdown": countdown, "progress": progress, "investors": investors, "invest_records": invest_records, 'initiator': initiator.username, 'sales_records': sales_records})


def get_one_closed_plan(request, id):
    '''
    瀏覽特定已結束計畫頁面
    '''
    plan = FundraisingPlan.objects.get(id=id)
    initiator = User.objects.get(id=plan.initiator_id)
    products = Products.objects.filter(plan_id=id)
    countdown = get_countdown_to_a_certain_day(
        plan.execution_end_date)

    plan.fundraising_start_date = plan.fundraising_start_date.strftime(
        '%Y-%m-%d %H:%M')
    plan.fundraising_end_date = plan.fundraising_end_date.strftime(
        '%Y-%m-%d %H:%M')
    plan.execution_start_date = plan.execution_start_date.strftime(
        '%Y-%m-%d %H:%M')
    plan.execution_end_date = plan.execution_end_date.strftime(
        '%Y-%m-%d %H:%M')
    progress = round(plan.current_money /
                     plan.threshold_amount*100, 2)

    investors = InvestmentRecord.objects.filter(
        plan_id=id).values('user_id').distinct().count()
    invest_records = InvestmentRecord.objects.filter(plan_id=id, type='invest')

    for invest in invest_records:
        product = Products.objects.get(
            plan_id=invest.plan_id, product_id=invest.product_id)
        invest.product_title = product.title
        print(invest)

    sales_records = SalesRecord.objects.filter(plan721_id=plan.plan721_id)
    for record in sales_records:
        product = Products.objects.get(product_1155_id=record.product1155_id)
        record.product_title = product.title

    return render(request, "closed-plan-page.html", context={"plan": plan, "products": products, "countdown": countdown, "progress": progress, "investors": investors, "invest_records": invest_records, 'initiator': initiator.username, 'sales_records': sales_records})


'''
建立募資計畫
'''


def choose_plan_to_create(request):
    return render(request, "choose-plan-to-create.html")


@login_required
def create_plan_for_product(request):
    user = User.objects.get(username=request.user.username)
    return render(request, "create-plan-for-product.html", {'user': user})


@login_required
def create_plan_for_store(request):
    user = User.objects.get(username=request.user.username)
    return render(request, "create-plan-for-store.html", {'user': user})


@csrf_exempt
def post_create_fundraising_product_plan(request):
    '''
    Create new fundraising plan for products
    '''
    data = request.POST.dict()
    user_addr = data['wallet_address']
    # issue 721 token for new plan and return id of the new token
    estimate_gas = fundraising_contract.functions.createFundRaisingPlan(
        user_addr, '').estimateGas()
    tx = fundraising_contract.functions.createFundRaisingPlan(user_addr, '').buildTransaction({
        'gas': estimate_gas,
        'nonce': web3.eth.get_transaction_count(platform_account_address),
    })
    signed_tx = web3.eth.account.sign_transaction(tx, private_key)
    tx_hash = web3.eth.send_raw_transaction(signed_tx.rawTransaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(tx_hash, timeout=1000)
    tx_json = Web3.toJSON(tx_receipt)
    tx_json_loads = json.loads(tx_json)
    new_plan721_id = int(tx_json_loads["logs"][0]["topics"][3], 16)

    etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
        tx_json_loads["logs"][0]["transactionHash"]

    # get form data
    initiator_id = int(data["initiator_id"])
    plan721_id = new_plan721_id
    title = data["title"]
    threshold_amount = int(data["threshold_amount"])
    target_amount = int(data["target_amount"])
    category = "計畫及商品"

    plan_start_date = data["fundraising_start_date"]
    plan_start_date_formatted = datetime.strptime(plan_start_date, '%Y-%m-%d')
    plan_start_date_datetime = datetime.combine(
        plan_start_date_formatted, datetime.min.time())

    plan_end_date = data["fundraising_end_date"]
    plan_end_date_formatted = datetime.strptime(plan_end_date, '%Y-%m-%d')
    plan_end_date_datetime = datetime.combine(
        plan_end_date_formatted, datetime.max.time())

    execution_start_date = data["execution_start_date"]
    execution_start_date_formatted = datetime.strptime(
        execution_start_date, '%Y-%m-%d')
    execution_start_date_datetime = datetime.combine(
        execution_start_date_formatted, datetime.min.time())

    execution_end_date = data["execution_end_date"]
    execution_end_date_formatted = datetime.strptime(
        execution_end_date, '%Y-%m-%d')
    execution_end_date_datetime = datetime.combine(
        execution_end_date_formatted, datetime.max.time())

    # revenue_standard = int(data["revenue_standard"])
    profitsharing_investor = int(data["profitsharing_investor"])
    profitsharing_initiator = int(data["profitsharing_initiator"])
    profitsharing_platform = int(data["profitsharing_platform"])
    content = data["content"]
    product_number = data["product_number"]
    image = data["cover_image"]
    wallet_address = data["wallet_address"]
    liquidation_discount = data["liquidation_discount"]
    liquidation_time = data["liquidation_time"]
    new_plan_form = FundraisingPlan(initiator_id=initiator_id, plan721_id=plan721_id, title=title,
                                    threshold_amount=threshold_amount, target_amount=target_amount,
                                    category=category, fundraising_start_date=plan_start_date_datetime,
                                    fundraising_end_date=plan_end_date_datetime, execution_start_date=execution_start_date_datetime,
                                    execution_end_date=execution_end_date_datetime,
                                    profitsharing_investor=profitsharing_investor,
                                    profitsharing_initiator=profitsharing_initiator,
                                    profitsharing_platform=profitsharing_platform, content=content,
                                    product_number=product_number, image=image, wallet_address=wallet_address,
                                    liquidation_discount=liquidation_discount, liquidation_time=liquidation_time)
    new_plan_form.save()
    plan_db_new_id = FundraisingPlan.objects.last().id
    for i in range(int(product_number)):
        j = str(i+1)
        title = data["product"+j+"_title"]
        price = data["product"+j+"_price"]
        cost = data["product"+j+"_cost"]
        image = data["product"+j+"_image"]
        content = data["product"+j+"_content"]

        new_products = Products.objects.bulk_create([
            Products(initiator_id=initiator_id, title=title,
                     price=price, cost=cost, image=image, content=content, plan_id=plan_db_new_id, product_id=j),
        ])

    # update etherscan_url to table tx_hash
    plan = FundraisingPlan.objects.get(id=plan_db_new_id)
    plan.tx_hash = etherscan_url
    plan.save()

    return JsonResponse({'message': '募資計畫新增成功', 'etherscan_url': etherscan_url})


@csrf_exempt
def post_create_fundraising_store_plan(request):
    '''
    Create new fundraising plan for chain-store type
    '''
    data = request.POST.dict()
    user_addr = data['wallet_address']
    print(user_addr)
    # 發行721 取得回傳的新id
    estimate_gas = fundraising_contract.functions.createFundRaisingPlan(
        user_addr, '').estimateGas()
    tx = fundraising_contract.functions.createFundRaisingPlan(user_addr, '').buildTransaction({
        'gas': estimate_gas,
        'nonce': web3.eth.get_transaction_count(platform_account_address),
    })
    signed_tx = web3.eth.account.sign_transaction(tx, private_key)
    tx_hash = web3.eth.send_raw_transaction(signed_tx.rawTransaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(tx_hash, timeout=1000)
    tx_json = Web3.toJSON(tx_receipt)
    tx_json_loads = json.loads(tx_json)
    print(tx_json_loads)
    new_plan721_id = int(tx_json_loads["logs"][0]["topics"][3], 16)
    print(new_plan721_id)

    etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
        tx_json_loads["logs"][0]["transactionHash"]

    # 取得表單資料
    initiator_id = int(data["initiator_id"])
    plan721_id = new_plan721_id
    title = data["title"]
    threshold_amount = int(data["threshold_amount"])
    target_amount = int(data["target_amount"])
    category = "加盟及分店"

    plan_start_date = data["fundraising_start_date"]
    plan_start_date_formatted = datetime.strptime(plan_start_date, '%Y-%m-%d')
    plan_start_date_datetime = datetime.combine(
        plan_start_date_formatted, datetime.min.time())

    plan_end_date = data["fundraising_end_date"]
    plan_end_date_formatted = datetime.strptime(plan_end_date, '%Y-%m-%d')
    plan_end_date_datetime = datetime.combine(
        plan_end_date_formatted, datetime.max.time())

    execution_start_date = data["execution_start_date"]
    execution_start_date_formatted = datetime.strptime(
        execution_start_date, '%Y-%m-%d')
    execution_start_date_datetime = datetime.combine(
        execution_start_date_formatted, datetime.min.time())

    profit_sharing_start_date = data["profit_sharing_start_date"] + '-01'
    profit_sharing_start_date_formatted = datetime.strptime(
        profit_sharing_start_date, '%Y-%m-%d')

    profitsharing_investor = int(data["profitsharing_investor"])
    profitsharing_initiator = int(data["profitsharing_initiator"])
    profitsharing_platform = int(data["profitsharing_platform"])
    content = data["content"]
    store_number = data["store_number"]
    image = data["cover_image"]
    wallet_address = data["wallet_address"]
    liquidation_discount = data["liquidation_discount"]
    liquidation_time = data["liquidation_time"]
    revenue_standard = int(data["revenue_standard"])
    profit_sharing_frequency = 3
    new_plan_form = FundraisingPlan(initiator_id=initiator_id, plan721_id=plan721_id, title=title,
                                    threshold_amount=threshold_amount, target_amount=target_amount,
                                    category=category, fundraising_start_date=plan_start_date_datetime,
                                    fundraising_end_date=plan_end_date_datetime, execution_start_date=execution_start_date_datetime,
                                    profit_sharing_start_date=profit_sharing_start_date_formatted,
                                    profitsharing_investor=profitsharing_investor,
                                    profitsharing_initiator=profitsharing_initiator,
                                    profitsharing_platform=profitsharing_platform, content=content,
                                    product_number=store_number, image=image, wallet_address=wallet_address,
                                    liquidation_discount=liquidation_discount, liquidation_time=liquidation_time,
                                    profit_sharing_frequency=profit_sharing_frequency, revenue_standard=revenue_standard)
    new_plan_form.save()
    plan_db_new_id = FundraisingPlan.objects.last().id
    for i in range(int(store_number)):
        j = str(i+1)
        title = data["store"+j+"_title"]
        cost = data["store"+j+"_cost"]
        image = data["store"+j+"_image"]
        content = data["store"+j+"_content"]

        new_products = Products.objects.bulk_create([
            Products(initiator_id=initiator_id, title=title,
                     cost=cost, image=image, content=content, plan_id=plan_db_new_id, product_id=j),
        ])

    # 更新 etherscan_url 至table tx_hash
    plan = FundraisingPlan.objects.get(id=plan_db_new_id)
    plan.tx_hash = etherscan_url
    plan.save()

    return JsonResponse({'message': '募資計畫新增成功', 'etherscan_url': etherscan_url})


'''
投資計畫
'''


@csrf_exempt
def issue_invest_token(to_address, amount):
    '''
    呼叫投資憑證合約，發送 865 token
    '''
    # make transaction
    estimate_gas = investment_token_contract.functions.get865FromContract(
        to_address, amount).estimateGas()
    transaction = investment_token_contract.functions.get865FromContract(to_address, amount).buildTransaction({
        'chainId': 3,
        'gas': estimate_gas,
        'nonce': web3.eth.get_transaction_count(platform_account_address),
    })
    signed_tx = web3.eth.account.sign_transaction(
        transaction, private_key)
    tx_hash = web3.eth.send_raw_transaction(signed_tx.rawTransaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(
        tx_hash, timeout=1000)
    tx_json = Web3.toJSON(tx_receipt)
    tx_json_loads = json.loads(tx_json)
    print(tx_json_loads)

    etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
        tx_json_loads["transactionHash"]
    return etherscan_url


def get_transfer_invest_token_page(request, plan_id, product_id):
    '''
    檢視轉移投資憑證之頁面
    '''
    # user = User.objects.get(id=request.user.id)
    invest_records = InvestmentRecord.objects.filter(
        user_id=request.user.id, plan_id=plan_id, product_id=product_id)
    # 計算出此人在此產品擁有的憑證數 sum(invest)
    total_invest_token = 0
    for i in invest_records:
        if i.type == 'invest' or i.type == 'receive':
            total_invest_token = total_invest_token + i.amount
        else:
            total_invest_token = total_invest_token - i.amount
    print(total_invest_token)
    fundraising_plan = FundraisingPlan.objects.get(id=plan_id)
    product = Products.objects.get(plan_id=plan_id, product_id=product_id)
    return render(request, "transfer-invest-token.html", context={"plan": fundraising_plan, "product": product, "token_number": total_invest_token})


@csrf_exempt
def transfer_invest_token(request, plan_id, product_id):
    if request.POST:
        '''
        呼叫投資憑證合約，轉移投資憑證給他人
        '''
        data = request.POST.dict()
        print(data)
        signature = data['signature']
        signature.encode('utf-8')
        sigNonce = int(data["sigNonce"])
        amount = int(data["erc-amount-input"])
        from_address = data["wallet_address"]
        to_address = data["transfer-to-address"]

        # 1. A轉移投資憑證給B

        estimate_gas = investment_token_contract.functions.transferPreSigned(
            signature, to_address,  amount, 0, sigNonce).estimateGas()
        transaction = investment_token_contract.functions.transferPreSigned(
            signature, to_address,  amount, 0, sigNonce).buildTransaction({
                'chainId': 3,
                'gas': estimate_gas,
                'gasPrice': web3.eth.gas_price,
                'nonce': web3.eth.get_transaction_count(platform_account_address),
            })
        signed_tx = web3.eth.account.signTransaction(
            transaction, private_key=private_key)
        tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
        tx_receipt = web3.eth.wait_for_transaction_receipt(
            tx_hash, timeout=1000)
        tx_json = Web3.toJSON(tx_receipt)
        tx_json_loads = json.loads(tx_json)
        print(tx_json_loads)

        etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
            tx_json_loads["transactionHash"]

        # 2. 存MySQL 轉出人/計畫/產品/金額/type=transfer
        transfer_record = InvestmentRecord(user_id=request.user.id, user_wallet=from_address,
                                           plan_id=plan_id, product_id=product_id, amount=amount, etherscan_url=etherscan_url, type="transfer", invest_token_url=etherscan_url)
        transfer_record.save()
        # 3. 存MySQL 轉入人/計畫/產品/金額/type=receive
        member = Member.objects.get(wallet_address=to_address)
        to_user_id = member.user_id
        receive_record = InvestmentRecord(user_id=to_user_id, user_wallet=to_address,
                                          plan_id=plan_id, product_id=product_id, amount=amount, etherscan_url=etherscan_url, type="receive", invest_token_url=etherscan_url)
        receive_record.save()

        return JsonResponse({"message": "轉移投資憑證成功"})


def get_burn_invest_token(request):
    '''
    檢視burn invest token頁面
    '''
    return render(request, "burn-invest-token.html", context={})


@csrf_exempt
def post_burn_invest_token(request):
    if request.POST:
        '''
        呼叫投資憑證合約，轉移 865 token 給 平台帳號
        '''
        data = request.POST.dict()
        print(data)
        signature = data['signature']
        signature.encode('utf-8')
        sigNonce = int(data["sigNonce"])
        amount = int(data["erc-amount-input"])
        from_address = data["wallet_address"]
        to_address = data["transfer-to-address"]

        # 1. A轉移投資憑證給B

        estimate_gas = investment_token_contract.functions.transferPreSigned(
            signature, to_address,  amount, 0, sigNonce).estimateGas()
        transaction = investment_token_contract.functions.transferPreSigned(
            signature, to_address,  amount, 0, sigNonce).buildTransaction({
                'chainId': 3,
                'gas': estimate_gas,
                'gasPrice': web3.eth.gas_price,
                'nonce': web3.eth.get_transaction_count(platform_account_address),
            })
        signed_tx = web3.eth.account.signTransaction(
            transaction, private_key=private_key)
        tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
        tx_receipt = web3.eth.wait_for_transaction_receipt(
            tx_hash, timeout=1000)
        tx_json = Web3.toJSON(tx_receipt)
        tx_json_loads = json.loads(tx_json)
        print(tx_json_loads)

        etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
            tx_json_loads["transactionHash"]

        return JsonResponse({"message": "burn 投資憑證成功"})


@csrf_exempt
def get_invest_plan_page(request, id):
    '''
    檢視投資特定計畫之頁面
    '''
    # platform_token = Member.objects.get(user_id=request.user.id).platform_token
    user = User.objects.get(id=request.user.id)
    # user.platform_token = platform_token
    fundraising_plan = FundraisingPlan.objects.get(id=id)
    products = Products.objects.filter(plan_id=id)
    return render(request, "invest-plan.html", context={"plan": fundraising_plan, "products": products, "user": user})


@csrf_exempt
def post_invest_fundraising_products(request, id):
    '''
    送出投資某商品之交易
    '''
    data = request.POST.dict()
    print(data)
    # # 1. 轉出平台幣
    signature = data['signature']
    signature.encode('utf-8')
    sigNonce = int(data["sigNonce"])
    total_investment = int(data["amount"])

    estimate_gas = platform_token_contract.functions.transferPreSigned(
        signature, platform_account_address, total_investment, 0, sigNonce).estimateGas()
    transaction = platform_token_contract.functions.transferPreSigned(
        signature, platform_account_address, total_investment, 0, sigNonce).buildTransaction({
            'chainId': 3,
            'gas': estimate_gas,
            'gasPrice': web3.eth.gas_price,
            'nonce': web3.eth.get_transaction_count(platform_account_address),
        })
    signed_tx = web3.eth.account.signTransaction(
        transaction, private_key=private_key)
    tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(
        tx_hash, timeout=1000)
    tx_json = Web3.toJSON(tx_receipt)
    tx_json_loads = json.loads(tx_json)
    print(tx_json_loads)
    # 2. 發行投資token
    invest_token_url = issue_invest_token(
        data["wallet_address"], total_investment)
    # 資料存MySQL
    wallet_address = data["wallet_address"]
    products_indexes = list(data)

    for i in products_indexes[:-4]:
        product_id = int(i[2:])
        if len(data[i]) != 0:
            product_amount = int(data[i])
            # 存投資記錄
            transaction = fundraising_investment_contract.functions.issueInvestToken(wallet_address, int(id), product_id, product_amount).buildTransaction({
                'chainId': 3,
                'gas': 700000,
                'nonce': web3.eth.get_transaction_count(platform_account_address),
            })
            signed_tx = web3.eth.account.sign_transaction(
                transaction, private_key)
            tx_hash = web3.eth.send_raw_transaction(signed_tx.rawTransaction)
            tx_receipt = web3.eth.wait_for_transaction_receipt(
                tx_hash, timeout=1000)
            tx_json = Web3.toJSON(tx_receipt)
            tx_json_loads = json.loads(tx_json)
            print(tx_json_loads)

            etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
                tx_json_loads["logs"][0]["transactionHash"]
            print(etherscan_url)
            invest = InvestmentRecord(user_id=request.user.id, user_wallet=wallet_address,
                                      plan_id=id, product_id=product_id, amount=product_amount, etherscan_url=etherscan_url, type="invest", invest_token_url=invest_token_url)
            invest.save()
    plan = FundraisingPlan.objects.get(id=id)
    plan.current_money = plan.current_money + total_investment
    plan.save()
    check_if_reach_condition(id)

    return JsonResponse({'message': '投資成功'})


'''
正式計畫
'''


def get_countdown_to_a_certain_day(end_date):
    '''
    取得募資倒數之日、時、分數值
    '''
    difference = end_date - datetime.now()
    days, hours, minutes = difference.days, difference.seconds // 3600, difference.seconds // 60 % 60
    countdown = {
        "days": days,
        "hours": hours,
        "minutes": minutes
    }
    return countdown


def run_check_crontab_daily():
    '''
    每日檢查計畫是否到期之排程事件
    '''
    plan_last_id = FundraisingPlan.objects.last().id
    for i in range(plan_last_id):
        plan = FundraisingPlan.objects.get(id=id)
        # 如果是商品募資計畫
        if plan.category == '計畫及商品':
            check_if_reach_condition(i)


def check_if_reach_condition(id):
    '''
    檢查特定計畫是否達到轉正式計畫之條件
    '''
    plan = FundraisingPlan.objects.get(id=id)
    # 如果計畫現有投資>=目標金額 || (end_date-today == -1 and 現有投資>=門檻金額) -> 轉正式計畫
    countdown_fundraising_end = get_countdown_to_a_certain_day(
        plan.fundraising_end_date)
    if plan.current_money >= plan.target_amount or (countdown_fundraising_end["days"] <= -1
                                                    and plan.current_money >= plan.threshold_amount):
        to_official_plan(id)

    # 如果計畫募資到期 且 現有投資 < 門檻金額 -> close
    if countdown_fundraising_end["days"] <= -1 and plan.current_money < plan.threshold_amount:
        close_plan(id)

    # 如果計畫執行到期 -> close
    countdown_executing_end = get_countdown_to_a_certain_day(
        plan.execution_end_date)
    if countdown_executing_end["days"] <= -1:
        close_plan(id)


def to_official_plan(id):
    '''
    轉正式計畫
    '''
    # mysql 計畫status改成 executing
    plan = FundraisingPlan.objects.get(id=id)
    plan.status = 'executing'
    # 發行正式計畫721 取得回傳的新id
    user = Member.objects.get(user_id=plan.initiator_id)
    user_addr = user.wallet_address
    tx = official_contract.functions.createOfficialPlan(user_addr, '').buildTransaction({
        'gas': 700000,
        'nonce': web3.eth.get_transaction_count(platform_account_address),
    })
    signed_tx = web3.eth.account.sign_transaction(tx, private_key)
    tx_hash = web3.eth.send_raw_transaction(signed_tx.rawTransaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(tx_hash, timeout=1000)
    tx_json = Web3.toJSON(tx_receipt)
    tx_json_loads = json.loads(tx_json)
    new_plan721_id = int(tx_json_loads["logs"][0]["topics"][3], 16)
    etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
        tx_json_loads["logs"][0]["transactionHash"]
    # 註銷 募資合約 的721token
    # fundraising_contract.functions.burnFundRaisingPlan(plan.plan721_id)
    # 更新 tx_hash 的 url 以及 plan721_id
    plan.tx_hash = etherscan_url
    plan.plan721_id = new_plan721_id
    plan.save()


@csrf_exempt
def close_plan(request):
    data = request.POST.dict()
    plan_id = int(data["plan_id"])
    plan = FundraisingPlan.objects.get(id=plan_id)
    plan.status = 'closed'
    plan.save()
    run_profit_sharing(plan_id)
    return JsonResponse({'message': '計畫結束'})


def burn_invest_token():
    # TODO 註銷投資憑證
    return True


def refund_money_to_investors(id):
    # TODO 退款給投資人
    return True


'''
分潤
'''


def run_profit_sharing(plan_id):
    plan = FundraisingPlan.objects.get(id=plan_id)
    # 呼叫合約 轉865
    # 總收益*比例 -> 平台帳號
    # 總收益*比例 -> 發起人帳號
    # 每位投資人 總收益*比例*(投資額/總投資額)
    # [{product_id:1,
    #   investors:[
    #   {user_id:1,user_addr:'',invest_percentage:0.2},
    #   {user_id:2,user_addr:''invest_percentage:0.9}]
    #   },
    # ]

    products = Products.objects.filter(plan_id=plan_id)
    revenue_all_products = 0
    product_invest_record = []

    for product in products:
        revenue_all_products = revenue_all_products + product.price * product.sold_amount
        invest_sum_of_this_product = InvestmentRecord.objects.filter(
            plan_id=plan_id, product_id=product.product_id, type='invest').aggregate(Sum('amount'))
        temp = {}
        temp["product_id"] = product.product_id
        temp["investors"] = []
        investors_of_this_product = InvestmentRecord.objects.filter(
            plan_id=plan_id, product_id=product.product_id).exclude(type='transfer').values('user_id').distinct()

        for investor in investors_of_this_product:
            invest_sum = InvestmentRecord.objects.filter(
                plan_id=plan_id, product_id=product.product_id, user_id=investor["user_id"]).aggregate(Sum('amount'))
            transfer_sum = InvestmentRecord.objects.filter(
                plan_id=plan_id, product_id=product.product_id, user_id=investor["user_id"], type='transfer').aggregate(Sum('amount'))
            if(transfer_sum["amount__sum"]):
                invest_sum["amount__sum"] = invest_sum["amount__sum"] - \
                    (transfer_sum["amount__sum"]*2)
            print(investor["user_id"])
            print(invest_sum["amount__sum"])

            data = {}
            data["user_id"] = investor["user_id"]
            data["invest_percentage"] = (
                invest_sum["amount__sum"] / invest_sum_of_this_product["amount__sum"])
            temp["investors"].append(data)
        product_invest_record.append(temp)
    print(product_invest_record)

    revenue_to_platform = plan.profitsharing_platform / 100 * revenue_all_products
    revenue_to_initiator = plan.profitsharing_initiator / 100 * revenue_all_products
    revenue_for_all_investors = plan.profitsharing_investor / 100 * revenue_all_products

    # 轉token給投資人 並存分潤記錄
    for record in product_invest_record:
        for investor in record["investors"]:
            amount = int(revenue_for_all_investors *
                         investor["invest_percentage"])
            url = transfer_profit_to_investor(amount, investor["user_id"])
            profit_sharing_record = ProfitSharingRecord(
                user_id=investor["user_id"], profit=amount, plan_id=plan_id, product_id=record["product_id"], etherscan_url=url)
            profit_sharing_record.save()

    # TODO 轉錢給發起人和平台帳號


def transfer_profit_to_investor(amount, user_id):
    addr = Member.objects.get(user_id=user_id).wallet_address
    url = transfer_865token_from_contract(amount, addr)
    return url


def get_profit_sharing_record(request):
    data = request.POST.dict()
    plan_id = data["plan_id"]
    product_id = data["product_id"]
    user_id = request.user.id


'''
計畫下之ERC1155項目
'''


@csrf_exempt
def issue_ERC1155_product(request):
    data = request.POST.dict()

    plan721_id = int(data["plan721_id"])
    product_name = data["product_name"]
    amount = int(data["amount"])
    plan = FundraisingPlan.objects.get(plan721_id=plan721_id)
    product = Products.objects.get(
        plan_id=plan.id, title=product_name)
    product_id = product.product_id
    # 如果計畫是正式，發行ERC1155商品
    is_plan_executing = True if (plan.status == 'executing') else False
    if is_plan_executing:

        # 呼叫商品合約之mintERC1155token
        initiator_addr = plan.wallet_address
        estimate_gas = product_contract.functions.mintERC1155Token(
            initiator_addr, amount, plan721_id, product_id, product.cost, product.price).estimateGas()
        transaction = product_contract.functions.mintERC1155Token(
            initiator_addr, amount, plan721_id, product_id, product.cost, product.price).buildTransaction({
                'chainId': 3,
                'gas': estimate_gas,
                'gasPrice': web3.eth.gas_price,
                'nonce': web3.eth.get_transaction_count(platform_account_address),
            })
        signed_tx = web3.eth.account.signTransaction(
            transaction, private_key=private_key)
        tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
        tx_receipt = web3.eth.wait_for_transaction_receipt(
            tx_hash, timeout=1000)
        logs = product_contract.events.MintNFT().processReceipt(tx_receipt)
        log_json = Web3.toJSON(logs)
        log_json_loads = json.loads(log_json)
        print(log_json_loads)
        print(log_json_loads[0]["args"]["nft_id"])

        product_1155_id = int(log_json_loads[0]["args"]["nft_id"])
        print("product_1155_id")
        print(product_1155_id)

        etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
            log_json_loads[0]["transactionHash"]

        product.etherscan_url = etherscan_url
        product.product_1155_id = product_1155_id
        product.plan721_id = plan721_id
        product.issued_amount = amount
        product.save()
        return JsonResponse({"etherscan_url": etherscan_url})
    else:
        return JsonResponse({"message": "計畫尚未正式執行"})


@csrf_exempt
def get_remaining_ERC1155_products(request):
    data = request.POST.dict()
    # 呼叫合約 products
    ERC1155_id = data["product1155_id"]
    res = product_contract.functions.getProductAmount(int(ERC1155_id)).call()
    print(res)
    return JsonResponse({"message": res})


@csrf_exempt
def buy_product(request):
    '''
    購買商品/販售商品API
    '''
    data = request.POST.dict()
    plan721_id = int(data["plan721_id"])
    product1155_id = int(data["product1155_id"])
    amount = int(data["amount"])
    price = int(data["price"])
    discount = int(data["discount"])
    cost = int(data["cost"])

    buyer_address = ""
    if data["buyer_address"]:
        buyer_address = data["buyer_address"]

    buyer_id = 0
    if data["buyer_id"]:
        buyer_id = int(data["buyer_id"])
    plan = FundraisingPlan.objects.get(plan721_id=plan721_id)
    initiator_addr = plan.wallet_address

    # 呼叫合約
    estimate_gas = product_contract.functions.buyProduct(
        initiator_addr,
        product1155_id,
        amount,
        plan721_id,
        buyer_address,
        buyer_id,
        price,
        discount,
        cost).estimateGas()
    transaction = product_contract.functions.buyProduct(
        initiator_addr,
        product1155_id,
        amount,
        plan721_id,
        buyer_address,
        buyer_id,
        price,
        discount,
        cost).buildTransaction({
            'chainId': 3,
            'gas': estimate_gas,
            'gasPrice': web3.eth.gas_price,
            'nonce': web3.eth.get_transaction_count(platform_account_address),
        })
    signed_tx = web3.eth.account.signTransaction(
        transaction, private_key=private_key)
    tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(
        tx_hash, timeout=1000)
    logs = product_contract.events.BuyProduct().processReceipt(tx_receipt)
    log_json = Web3.toJSON(logs)
    log_json_loads = json.loads(log_json)
    print(log_json_loads)

    etherscan_url = 'https://ropsten.etherscan.io/tx/' + \
        log_json_loads[0]["transactionHash"]

    record = SalesRecord(
        buyer_uid=buyer_id,
        buyer_wallet=buyer_address,
        plan721_id=plan721_id,
        product1155_id=product1155_id,
        amount=amount,
        etherscan_url=etherscan_url)
    record.save()

    product = Products.objects.get(
        plan721_id=plan721_id, product_1155_id=product1155_id)
    product.sold_amount = product.sold_amount + amount
    product.save()

    return JsonResponse({"etherscan_url": etherscan_url})


'''
其他
'''


def get_transfer_token(request):
    return render(request, "transfer-token.html")


@csrf_exempt
def post_transfer_token(request):
    data = request.POST.dict()
    signature = data['signature']
    signature.encode('utf-8')
    sigNonce = int(data["sigNonce"])
    amount = int(data["amount"])

    estimate_gas = platform_token_contract.functions.transferPreSigned(
        signature, platform_account_address, amount, 0, sigNonce).estimateGas()
    transaction = platform_token_contract.functions.transferPreSigned(
        signature, platform_account_address, amount, 0, sigNonce).buildTransaction({
            'chainId': 3,
            'gas': estimate_gas,
            'gasPrice': web3.eth.gas_price,
            'nonce': web3.eth.get_transaction_count(platform_account_address),
        })
    signed_tx = web3.eth.account.signTransaction(
        transaction, private_key=private_key)
    tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(
        tx_hash, timeout=1000)
    tx_json = Web3.toJSON(tx_receipt)
    tx_json_loads = json.loads(tx_json)
    print(tx_json_loads)
    return JsonResponse({'message': '轉錢'})


@csrf_exempt
def show_test_page(request):
    # run_scheduel_task()
    # return render(request, "test.html")
    plan_id = 5
    plan = FundraisingPlan.objects.get(id=plan_id)
    # 呼叫合約 轉865
    # 總收益*比例 -> 平台帳號
    # 總收益*比例 -> 發起人帳號
    # 每位投資人 總收益*比例*(投資額/總投資額)
    # [{product_id:1,
    #   investors:[
    #   {user_id:1,user_addr:'',invest_percentage:0.2},
    #   {user_id:2,user_addr:''invest_percentage:0.9}]
    #   },
    # ]

    return JsonResponse({'message': 'test-page'})
