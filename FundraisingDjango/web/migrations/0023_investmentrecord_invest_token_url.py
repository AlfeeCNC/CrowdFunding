# Generated by Django 3.2.5 on 2021-10-23 23:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0022_investmentrecord_type'),
    ]

    operations = [
        migrations.AddField(
            model_name='investmentrecord',
            name='invest_token_url',
            field=models.CharField(default='', max_length=255),
        ),
    ]
