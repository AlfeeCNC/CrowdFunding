# Generated by Django 3.2.5 on 2021-08-24 22:39

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0013_products_product_1155_id'),
    ]

    operations = [
        migrations.RenameField(
            model_name='salesrecord',
            old_name='plan_id',
            new_name='plan721_id',
        ),
        migrations.RenameField(
            model_name='salesrecord',
            old_name='product_id',
            new_name='product1155_id',
        ),
    ]