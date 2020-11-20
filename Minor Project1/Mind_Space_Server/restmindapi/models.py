from django.db import models
from django.contrib.auth.models import User


class rest(models.Model):
    name = models.CharField(max_length=20,default="name")
    sentiment = models.CharField(max_length=10,default="neutral")
    anger = models.FloatField(default=0.0)
    sad = models.FloatField(default=0.0)
    fear = models.FloatField(default=0.0)
    happy = models.FloatField(default=0.0)
    disgust = models.FloatField(default=0.0)
    surprise = models.FloatField(default=0.0)
    neutral = models.FloatField(default=0.0)
    chat = models.TextField(max_length=2000,default="")
    unique = models.CharField(max_length=10,default="abcde12345")
    def __str__(self):
        return self.name