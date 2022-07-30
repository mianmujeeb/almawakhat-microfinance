from django.urls import path
from .views import *


urlpatterns = [
    path('login', login, name='login'),
    path('logout', logout, name='logout'),
    
    path('', dashboard, name='dashboard'),
    
    path('currencies', currencies, name='currencies'),
    
    path('regions', regions, name='regions'),
    
    path('countries', countries, name='countries'),
    path('country/update/<int:pk>', updateCountry, name='update-country'),
    
    path('states', states, name='states'),
    
    path('sub-states', subStates, name='sub-states'),
    
    path('cities', cities, name='cities'),
    
    path('users', users, name='users'),
    path('update-user/<str:username>', updateUser, name='update-user'),
    
]