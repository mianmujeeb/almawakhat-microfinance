from django.contrib import admin
from .models import *

# Register your models here.
@admin.register(Currency)
class CurrencyAdmin(admin.ModelAdmin):

    list_display = ('name', 'code', 'symbol', 'position', 'fractional_units', 'status')
    list_filter = ('status',)
    search_fields = ('name',)
    
    
    
@admin.register(Region)
class RegionAdmin(admin.ModelAdmin):

    list_display = ('name', 'code_digit', 'code_alpha','status')
    list_filter = ('status',)
    search_fields = ('name',)
    
    
    
@admin.register(Country)
class CountryAdmin(admin.ModelAdmin):

    list_display = ('name', 'iso2digit', 'iso3digit','status')
    list_filter = ('status',)
    search_fields = ('name',)
    
    
    
@admin.register(State)
class StateAdmin(admin.ModelAdmin):

    list_display = ('name', 'code_digit', 'code_alpha','status')
    list_filter = ('status',)
    search_fields = ('name',)
    
    
    
@admin.register(SubState)
class SubStateAdmin(admin.ModelAdmin):

    list_display = ('name', 'latitude', 'longitude','status')
    list_filter = ('status',)
    search_fields = ('name',)
    
    
    
@admin.register(City)
class CityAdmin(admin.ModelAdmin):

    list_display = ('name', 'latitude', 'longitude','status')
    list_filter = ('status',)
    search_fields = ('name',)