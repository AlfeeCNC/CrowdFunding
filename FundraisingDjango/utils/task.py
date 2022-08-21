from datetime import date
from web.views import run_check_crontab_daily
from web.models import Test1
from datetime import datetime


def run_task():
    run_check_crontab_daily()
