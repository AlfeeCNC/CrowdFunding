# Generated by Django 3.2.5 on 2021-08-10 17:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0010_profitsharingrecord'),
    ]

    operations = [
        migrations.AddField(
            model_name='profitsharingrecord',
            name='etherscan_url',
            field=models.CharField(default='', max_length=255),
        ),
    ]