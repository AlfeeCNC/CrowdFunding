# Generated by Django 3.2.5 on 2021-09-12 21:31

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0020_auto_20210912_2128'),
    ]

    operations = [
        migrations.AlterField(
            model_name='fundraisingplan',
            name='execution_end_date',
            field=models.DateTimeField(blank=True, default=django.utils.timezone.now, null=True),
        ),
        migrations.AlterField(
            model_name='fundraisingplan',
            name='profit_sharing_frequency',
            field=models.IntegerField(blank=True, default=3, null=True),
        ),
        migrations.AlterField(
            model_name='fundraisingplan',
            name='profit_sharing_start_date',
            field=models.DateTimeField(blank=True, default=django.utils.timezone.now, null=True),
        ),
        migrations.AlterField(
            model_name='fundraisingplan',
            name='revenue_standard',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
    ]