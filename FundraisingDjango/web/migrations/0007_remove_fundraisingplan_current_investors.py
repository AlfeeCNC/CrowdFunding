# Generated by Django 3.2.5 on 2021-08-06 21:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0006_investmentrecord_etherscan_url'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='fundraisingplan',
            name='current_investors',
        ),
    ]
