from rest_framework import serializers
from .models import Rest


class RestSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Rest
        fields = ('mobile_no')