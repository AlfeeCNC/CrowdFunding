from django.db import models
from django.template.defaultfilters import slugify
from django.contrib.auth.models import User
from django.urls import reverse
from django.db import connections
from datetime import datetime
from datetime import date
from django.utils import timezone

# $ python manage.py migrate --fake web zero
# $ python manage.py makemigrations
# $ python manage.py migrate


class Test1(models.Model):
    # id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    end_date = models.DateTimeField(default=timezone.now, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "test"


class FundraisingPlan(models.Model):
    # id = models.AutoField(primary_key=True)
    # 共同欄位
    initiator_id = models.IntegerField()
    plan721_id = models.CharField(max_length=255)
    title = models.CharField(max_length=100)
    threshold_amount = models.IntegerField()
    target_amount = models.IntegerField()
    category = models.CharField(max_length=100)
    fundraising_start_date = models.DateTimeField(default=timezone.now)
    fundraising_end_date = models.DateTimeField(default=timezone.now)
    execution_start_date = models.DateTimeField(default=timezone.now)
    profitsharing_investor = models.IntegerField()
    profitsharing_initiator = models.IntegerField()
    profitsharing_platform = models.IntegerField()
    content = models.TextField()
    current_money = models.IntegerField(default=0)
    product_number = models.IntegerField(default=0)
    image = models.CharField(max_length=255, default='')
    status = models.CharField(max_length=50, default="fundraising")
    tx_hash = models.CharField(max_length=255, default="")
    wallet_address = models.CharField(max_length=255, default="")
    created_at = models.DateTimeField(auto_now_add=True)
    liquidation_time = models.IntegerField(default=30)
    liquidation_discount = models.IntegerField(default=0)
    # product
    execution_end_date = models.DateTimeField(
        default=timezone.now, blank=True, null=True)
    # store
    profit_sharing_start_date = models.DateTimeField(
        default=timezone.now, blank=True, null=True)
    profit_sharing_frequency = models.IntegerField(
        default=3, blank=True, null=True)
    revenue_standard = models.IntegerField(default=0, blank=True, null=True)

    class Meta:
        db_table = "fund_raising_plan"


class Products(models.Model):
    # id = models.AutoField(primary_key=True)
    initiator_id = models.IntegerField()
    title = models.CharField(max_length=50)
    price = models.IntegerField(default=0)
    image = models.CharField(max_length=255)
    content = models.CharField(max_length=255)
    plan_id = models.IntegerField(default=0)
    product_id = models.IntegerField(default=0)
    issued_amount = models.IntegerField(default=0)
    sold_amount = models.IntegerField(default=0)
    plan721_id = models.CharField(max_length=255, default="")
    etherscan_url = models.CharField(max_length=255, default="")
    product_1155_id = models.CharField(max_length=255, default="")
    cost = models.IntegerField(default=0)

    class Meta:
        db_table = "product"


class Member(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    blacklist = models.BooleanField(default=False)
    wallet_address = models.CharField(max_length=255, default="")


class InvestmentRecord(models.Model):
    user_id = models.IntegerField()
    user_wallet = models.CharField(max_length=255, default="")
    plan_id = models.IntegerField()
    product_id = models.IntegerField()
    amount = models.IntegerField()
    etherscan_url = models.CharField(max_length=255, default="")
    created_at = models.DateTimeField(auto_now_add=True)
    type = models.CharField(max_length=255, default="invest")
    invest_token_url = models.CharField(max_length=255, default="")

    class Meta:
        db_table = "investment_record"


class SalesRecord(models.Model):
    buyer_uid = models.IntegerField(blank=True, null=True)
    buyer_wallet = models.CharField(
        max_length=255, default="", blank=True, null=True)
    plan721_id = models.IntegerField()
    product1155_id = models.IntegerField()
    amount = models.IntegerField()
    etherscan_url = models.CharField(max_length=255, default="")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "sales_record"


class ProfitSharingRecord(models.Model):
    user_id = models.IntegerField()
    plan = models.ForeignKey(FundraisingPlan, on_delete=models.CASCADE)
    product = models.ForeignKey(Products, on_delete=models.CASCADE)
    profit = models.IntegerField()
    identity = models.CharField(max_length=255, default="")
    etherscan_url = models.CharField(max_length=255, default="")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "profit_sharing_record"
