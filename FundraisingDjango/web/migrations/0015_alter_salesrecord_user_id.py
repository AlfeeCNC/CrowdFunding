# Generated by Django 3.2.5 on 2021-08-24 22:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0014_auto_20210824_2239'),
    ]

    operations = [
        migrations.AlterField(
            model_name='salesrecord',
            name='user_id',
            field=models.IntegerField(blank=True),
        ),
    ]
