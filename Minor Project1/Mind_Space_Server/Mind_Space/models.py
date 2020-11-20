from django.db import models
from django.contrib.auth import get_user_model
from django.contrib.auth.models import User

class Rest(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    mobile_no = models.CharField(max_length=30, blank=True)
