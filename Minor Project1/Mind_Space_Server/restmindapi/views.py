from django.shortcuts import render
from django.http import HttpResponseRedirect
from rest_framework import viewsets
from rest_framework.response import Response
from django.contrib.auth.models import User
from .serializers import RestSerializer
from .models import rest
from . import nlpmodel


class RestViewSet(viewsets.ModelViewSet):
    queryset = rest.objects.all().order_by('name')
    serializer_class = RestSerializer
    app_request = dict()
    x = 0
    def create(self,request):
        serializer = RestSerializer(data=request.data)
        if serializer.is_valid():
            x = dict(request.data)
            serializer.save()
            if isinstance(x['name'],str):
                print(x['name'])
                self.name = x['name']
                self.unique = x['unique']
                self.text = x['chat']
            else:
                self.name = x['name'][0]
                self.unique = x['unique'][0]
                self.text = x['chat'][0]
                print(x)
            new_object = rest.objects.filter(name=self.name).filter(unique=self.unique)
            print(new_object)
            self.id = new_object.values('id')[0]['id']
            #self.text = new_object.values('chat')[0]['chat']
            print(self.id)
            nlpmodel.nlcheck(self.text)
            rest.objects.filter(pk=self.id).update(happy=0.5)
            rest.objects.filter(pk=self.id).update(sad=0.01)
            rest.objects.filter(pk=self.id).update(fear=0.002)
            rest.objects.filter(pk=self.id).update(disgust=0.03)
            rest.objects.filter(pk=self.id).update(surprise=0.15)
            rest.objects.filter(pk=self.id).update(anger=0.005)
            rest.objects.filter(pk=self.id).update(neutral=0.025)
            rest.objects.filter(pk=self.id).update(sentiment="positive")
            return Response(serializer.data)
        return Response(serializer.errors)
    def get(self,request):
       data = {"name":"john"}




"""     self.x = 0
        if self.request.method =="POST":
            self.x += 1
            if self.request.data !={} and self.app_request == {}:
                self.app_request = dict(self.request.data.items())
                self.app_request.pop('csrfmiddlewaretoken')
                print(self.app_request)
            self.x += 1
            if self.x>1:
                new_object = rest.objects.filter(name=dict(self.request.data.items())['name'])
                self.id = new_object.values('id')[0]['id']
                print(self.id)
                rest.objects.filter(pk=self.id).update(happy=0.5)
                rest.objects.filter(pk=self.id).update(sad=0.01)
                rest.objects.filter(pk=self.id).update(fear=0.002)
                rest.objects.filter(pk=self.id).update(disgust=0.03)
                rest.objects.filter(pk=self.id).update(surprise=0.15)
                rest.objects.filter(pk=self.id).update(anger=0.005)
                rest.objects.filter(pk=self.id).update(neutral=0.025)
                rest.objects.filter(pk=self.id).update(sentiment="positive")"""


"""    def transfer(self, request, format=None):
        if request.method == 'GET':
            usernames = ['manas']
            return Response(usernames)
        elif request.method == 'POST':
            serializer = RestSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)"""