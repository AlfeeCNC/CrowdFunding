from __future__ import absolute_import, unicode_literals
from celery import shared_task
from datetime import datetime
from . import views


# run redis server
# redis-server /usr/local/etc/redis.conf

# 刪除所有排程tasks
# kill -9 $(ps aux | grep celery | grep -v grep | awk '{print $2}' | tr '\n'  ' ') > /dev/null 2>&1

# 執行排程任務
# celery -A FundraisingDjango beat -l info --logfile=celery.beat.log --detach
# celery -A FundraisingDjango worker -l info --logfile=celery.log --detach


@shared_task(name="check_plans_daily")
def check_plans():
    views.run_check_crontab_daily()
