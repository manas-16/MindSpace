# Generated by Django 3.1.1 on 2020-09-23 14:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('restmindapi', '0003_auto_20200910_2024'),
    ]

    operations = [
        migrations.AddField(
            model_name='rest',
            name='mobile_no',
            field=models.TextField(default='0000000000', max_length=13),
        ),
    ]
