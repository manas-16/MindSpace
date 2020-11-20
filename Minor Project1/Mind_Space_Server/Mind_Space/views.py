from django.http import HttpResponse
from django.template import loader
from django.contrib.auth import logout
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib.auth.forms import AuthenticationForm


def index(request):
    template = loader.get_template('Mind_Space/index.html')
    return HttpResponse(template)

def restsignin(request):
    if request.user.is_authenticated:
        return render(request, 'rest.html')
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('/')
        else:
            form = AuthenticationForm(request.POST)
            return render(request, 'rest.html', {'form': form})
    else:
        form = AuthenticationForm()
        return render(request, 'signin.html', {'form': form})

def signout(request):
    logout(request)
    return redirect('/')

from rest_framework import viewsets

from .serializers import RestSerializer
from .models import Rest


class RestViewSet(viewsets.ModelViewSet):
    queryset = Rest.objects.all().order_by('user_id')
    serializer_class = RestSerializer