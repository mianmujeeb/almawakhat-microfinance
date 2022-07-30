from django.urls import path
from .views import *

urlpatterns = [
    path('emi-challan-profile', emiChallanProfile, name='emi-challan-profile'),
    path('emi-challan-bank-accounts', emiChallanBankAccounts, name='emi-challan-bank-accounts'),
    path('emi-challan-particulars', emiChallanParticulars, name='emi-challan-particulars'),
    path('financing-modes', financingModes, name='financing-modes'),
    path('challan/<str:challan_number>/print', printChallan, name='print-challan'),
    
    
    path('get-challan-detail-on-creation-ajax', getChallanDetailOnCreationAjax, name='get-challan-detail-on-creation-ajax')
    
]