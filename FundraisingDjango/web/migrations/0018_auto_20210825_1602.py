# Generated by Django 3.2.5 on 2021-08-25 16:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0017_auto_20210825_0001'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='member',
            name='platform_token',
        ),
        migrations.AlterField(
            model_name='salesrecord',
            name='buyer_wallet',
            field=models.CharField(blank=True, default='', max_length=255, null=True),
        ),
    ]
