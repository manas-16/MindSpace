# Generated by Django 3.1.1 on 2020-09-03 15:01

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Mind_Space', '0001_initial'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Choice',
        ),
        migrations.DeleteModel(
            name='Question',
        ),
    ]
