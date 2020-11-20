from rest_framework import serializers

from .models import rest

class RestSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = rest
        fields = ('id','name', 'sentiment','anger','sad','fear','happy','disgust','surprise','neutral','chat' ,'unique')