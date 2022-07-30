import datetime
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.hashers import make_password
from django.contrib import messages
from django.conf import settings
from django.core.mail import EmailMessage
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.core.mail import EmailMultiAlternatives
from settings.models import *
from .forms import *
from django.contrib.auth.models import User
from .decorators import unauthenticated_user
from django.contrib.auth.decorators import login_required, permission_required





# Create your views here.
@unauthenticated_user
def login(request):
    
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        print(username, password)
        user = authenticate(username=username, password=password)
        if user is not None:
            auth_login(request, user)
            messages.success(request, 'Welcome on the board')
            if 'next' in request.POST:
                return redirect(request.POST['next'])
            else:
                return redirect('settings:dashboard')
        else:
            messages.warning(request, 'Invalid credentials')
            
    return render(request, 'login.html')


def logout(request):
    auth_logout(request)
    messages.success(request, 'Logged out successfully')
    return redirect('settings:login')


@login_required
def dashboard(request):
    return render(request, 'dashboard.html')


@login_required
def currencies(request):
    currencies = Currency.objects.all().order_by('-id')
    
    form = CurrencyForm()
    
    if request.method == 'POST':
        
        if 'addCurrency' in request.POST:
            form = CurrencyForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'Currency added successfully')
                return redirect('settings:currencies')
            
        if 'updateCurrency' in request.POST:
            id = request.POST.get('id')
            currency = get_object_or_404(Currency, id=id)
            currency.status = request.POST.get('status')
            currency.name = request.POST.get('name')
            currency.code = request.POST.get('code')
            currency.symbol = request.POST.get('symbol')
            currency.position = request.POST.get('position')
            currency.fractional_units = request.POST.get('fractional_units')
            currency.save()
            messages.success(request, 'Currency updated successfully')
            return redirect('settings:currencies')
    
        
        if 'deleteCurrency' in request.POST:
            id = request.POST.get('id')
            currency = get_object_or_404(Currency, id=id)
            currency.delete()
            messages.info(request, 'Currency deleted successfully')
            return redirect('settings:currencies')

    context = {
        'currencies' : currencies,
        'form' : form,
    }
    return render(request, 'settings/currencies.html', context)


@login_required
def regions(request):
    regions = Region.objects.all().order_by('-id')
    
    form = RegionForm()
    
    if request.method == 'POST':
        if 'addRegion' in request.POST:
            form = RegionForm(request.POST)
            if form.is_valid():
                region = form.save()
                messages.success(request, 'Region added successfully')
                return redirect('settings:regions')
            
        if 'updateRegion' in request.POST:
            id = request.POST.get('id')
            region = get_object_or_404(Region, id=id)
            region.status = request.POST.get('status')
            region.name = request.POST.get('name')
            region.code_digit = request.POST.get('code_digit')
            region.code_alpha = request.POST.get('code_alpha')
            region.save()
            messages.success(request, 'Region updated successfully')
            return redirect('settings:regions')
    
        
        if 'deleteRegion' in request.POST:
            id = request.POST.get('id')
            region = get_object_or_404(Region, id=id)
            region.delete()
            messages.info(request, 'Region deleted successfully')
            return redirect('settings:regions')

    context = {
        'regions' : regions,
        'form' : form,
    }
    return render(request, 'settings/regions.html', context)


@login_required
def countries(request):
    countries = Country.objects.all()
    form = CountryForm()
    
    if request.method == 'POST':
        
        if 'addCountry' in request.POST:
            form = CountryForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'Country added successfully')
                return redirect('settings:countries')
            
        if 'deleteCountry' in request.POST:
            country = get_object_or_404(Country, id=request.POST.get('id'))
            country.delete()
            messages.info(request, 'Country deleted successfully')
            return redirect('settings:countries')

    
    context = {
        'countries' : countries,
        'form' : form,
    }
    return render(request, 'settings/countries.html', context)


@login_required
def updateCountry(request, pk):
    instance = get_object_or_404(Country, id=pk)
    form = CountryForm(instance=instance)
    
    if request.method == 'POST':
        form = CountryForm(request.POST, instance=instance)
        if form.is_valid():
            form.save()
            messages.success(request, 'Country updated successfully')
            return redirect('settings:countries')
        
    context = {
        'instance' : instance,
        'form' : form,
    }
    return render(request, 'settings/update-country.html', context)


@login_required
def states(request):
    countries = Country.objects.all().order_by('name')
    states = State.objects.all().order_by('-id')
    
    form = StateForm()
    
    if request.method == 'POST':
        
        if 'addState' in request.POST:
            form = StateForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'State added successfully')
                return redirect('settings:states')
            
        if 'updateState' in request.POST:
            id = request.POST.get('id')
            state = get_object_or_404(State, id=id)
            state.status = request.POST.get('status')
            state.name = request.POST.get('name')
            state.latitude = request.POST.get('latitude')
            state.longitude = request.POST.get('longitude')
            state.code_digit = request.POST.get('code_digit')
            state.code_alpha = request.POST.get('code_alpha')
            state.country = Country.objects.get(id=request.POST.get('country'))
            state.save()
            messages.success(request, 'State updated successfully')
            return redirect('settings:states')
    
        
        if 'deleteState' in request.POST:
            id = request.POST.get('id')
            state = get_object_or_404(State, id=id)
            state.delete()
            messages.info(request, 'State deleted successfully')
            return redirect('settings:states')

    context = {
        'countries' : countries,
        'states' : states,
        'form' : form,
    }
    return render(request, 'settings/states.html', context)


@login_required
def subStates(request):
    countries = Country.objects.all().order_by('name')
    states = State.objects.all().order_by('name')
    sub_states = SubState.objects.all().order_by('-id')
    
    form = SubStateForm()
    
    if request.method == 'POST':
        
        if 'addSubState' in request.POST:
            form = SubStateForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'Sub State added successfully')
                return redirect('settings:sub-states')
            
        if 'updateSubState' in request.POST:
            id = request.POST.get('id')
            sub_state = get_object_or_404(SubState, id=id)
            sub_state.status = request.POST.get('status')
            sub_state.name = request.POST.get('name')
            sub_state.latitude = request.POST.get('latitude')
            sub_state.longitude = request.POST.get('longitude')
            sub_state.state = State.objects.get(id=request.POST.get('state'))
            sub_state.country = Country.objects.get(id=request.POST.get('country'))
            sub_state.save()
            messages.success(request, 'Sub State updated successfully')
            return redirect('settings:sub-states')
    
        
        if 'deleteSubState' in request.POST:
            id = request.POST.get('id')
            state = get_object_or_404(SubState, id=id)
            state.delete()
            messages.info(request, 'Sub State deleted successfully')
            return redirect('settings:sub-states')

    context = {
        'countries' : countries,
        'states' : states,
        'sub_states' : sub_states,
        'form' : form,
    }
    return render(request, 'settings/sub-states.html', context)


@login_required
def cities(request):
    cities = City.objects.all().order_by('-id')
    countries = Country.objects.all().order_by('name')
    sub_states = SubState.objects.all().order_by('name')
    states = State.objects.all().order_by('name')
    
    form = CityForm()
    
    if request.method == 'POST':
        
        if 'addCity' in request.POST:
            form = CityForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'City added successfully')
                return redirect('settings:cities')
            
        if 'updateCity' in request.POST:
            id = request.POST.get('id')
            city = get_object_or_404(City, id=id)
            city.status = request.POST.get('status')
            city.name = request.POST.get('name')
            city.latitude = request.POST.get('latitude')
            city.longitude = request.POST.get('longitude')
            city.code_digit = request.POST.get('code_digit')
            city.code_alpha = request.POST.get('code_alpha')
            city.sub_state = SubState.objects.get(id=request.POST.get('sub_state'))
            city.state = State.objects.get(id=request.POST.get('state'))
            city.country = Country.objects.get(id=request.POST.get('country'))
            city.save()
            messages.success(request, 'City updated successfully')
            return redirect('settings:cities')
    
        
        if 'deleteCity' in request.POST:
            id = request.POST.get('id')
            city = get_object_or_404(City, id=id)
            city.delete()
            messages.info(request, 'City deleted successfully')
            return redirect('settings:cities')

    context = {
        'cities' : cities,
        'countries' : countries,
        'sub_states' : sub_states,
        'states' : states,
        'form' : form,
    }
    return render(request, 'settings/cities.html', context)


@login_required
def users(request):
    users = User.objects.all()
    
    context ={
        'users' : users,
    }
    return render(request, 'users/users.html', context)


@login_required
def updateUser(request, username):
    user = User.objects.get(username=username)
    
    context = {
        'instance' : user,
    }
    return render(request, 'users/update-user.html', context)