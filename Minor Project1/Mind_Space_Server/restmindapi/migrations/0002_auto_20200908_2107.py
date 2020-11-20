# Generated by Django 3.1.1 on 2020-09-08 15:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('restmindapi', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='rest',
            name='anger',
            field=models.FloatField(default=0.0),
        ),
        migrations.AddField(
            model_name='rest',
            name='chat',
            field=models.CharField(default='', max_length=2000),
        ),
        migrations.AddField(
            model_name='rest',
            name='disgust',
            field=models.FloatField(default=0.0),
        ),
        migrations.AddField(
            model_name='rest',
            name='fear',
            field=models.FloatField(default=0.0),
        ),
        migrations.AddField(
            model_name='rest',
            name='happy',
            field=models.FloatField(default=0.0),
        ),
        migrations.AddField(
            model_name='rest',
            name='neutral',
            field=models.FloatField(default=0.0),
        ),
        migrations.AddField(
            model_name='rest',
            name='sad',
            field=models.FloatField(default=0.0),
        ),
        migrations.AddField(
            model_name='rest',
            name='surprise',
            field=models.FloatField(default=0.0),
        ),
        migrations.AlterField(
            model_name='rest',
            name='name',
            field=models.CharField(default='name', max_length=20),
        ),
        migrations.AlterField(
            model_name='rest',
            name='sentiment',
            field=models.CharField(default='neutral', max_length=10),
        ),
    ]
