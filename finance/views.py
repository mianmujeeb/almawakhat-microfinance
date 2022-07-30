from django.shortcuts import render
import numpy_financial as np
from django.urls import reverse
from django.shortcuts import render, redirect, get_object_or_404
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
from .models import *
from finance.models import *
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required

# Create your views here.
@login_required
def financingModes(request):
    modes = FinancingMode.objects.all().order_by('-id')
    form = FinancingModeForm()
    
    if request.method == 'POST':
        
        if 'addMode' in request.POST:
            form = FinancingModeForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'Financing mode added successfully')
                return redirect('finance:financing-modes')
            
        if 'updateMode' in request.POST:
            id = request.POST.get('id')
            mode = get_object_or_404(FinancingMode, id=id)
            mode.status = request.POST.get('status')
            mode.name = request.POST.get('name')
            mode.description = request.POST.get('description')
            mode.save()
            messages.success(request, 'Financing mode updated successfully')
            return redirect('finance:financing-modes')
    
        
        if 'deleteMode' in request.POST:
            id = request.POST.get('id')
            city = get_object_or_404(FinancingMode, id=id)
            city.delete()
            messages.info(request, 'Financing mode deleted successfully')
            return redirect('finance:financing-modes')

    
    context = {
        'modes' : modes,
        'form' : form,
    }
    return render(request, 'finance/financing-modes.html', context)



@login_required
def emiChallanParticulars(request):
    modes = EMIChallanParticular.objects.all().order_by('-id')
    form = EMIChallanParticularForm()
    
    if request.method == 'POST':
        
        if 'addMode' in request.POST:
            form = EMIChallanParticularForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'Particular added successfully')
                return redirect('finance:emi-challan-particulars')
            
        if 'updateMode' in request.POST:
            id = request.POST.get('id')
            mode = get_object_or_404(EMIChallanParticular, id=id)
            mode.status = request.POST.get('status')
            mode.name = request.POST.get('name')
            mode.description = request.POST.get('description')
            mode.save()
            messages.success(request, 'Particular updated successfully')
            return redirect('finance:emi-challan-particulars')
    
        
        if 'deleteMode' in request.POST:
            id = request.POST.get('id')
            city = get_object_or_404(EMIChallanParticular, id=id)
            city.delete()
            messages.info(request, 'Particular deleted successfully')
            return redirect('finance:emi-challan-particulars')

    
    context = {
        'modes' : modes,
        'form' : form,
    }
    return render(request, 'finance/settings/emi-challan-particulars.html', context)



@login_required
def emiChallanProfile(request):
    instance = EMIChallanProfile.objects.first()
    
    if instance:
        form = EMIChallanProfileForm(instance=instance)
    else:
        form = EMIChallanProfileForm()
    
    
    if request.method == 'POST':
        if instance:
            form = EMIChallanProfileForm(request.POST, request.FILES, instance=instance)
        else:
            form = EMIChallanProfileForm(request.POST, request.FILES)
            
        if form.is_valid():
            form.save()
            messages.success(request, 'EMI Challan Profile Updated Successfully')
            return redirect('finance:emi-challan-profile')

    
    context = {
        'instance' : instance,
        'form' : form,
    }
    return render(request, 'finance/settings/emi-challan-profile.html', context)



@login_required
def emiChallanBankAccounts(request):
    modes = EMIChallanBankAccount.objects.all().order_by('-id')
    form = EMIChallanBankAccountForm()
    
    if request.method == 'POST':
        
        if 'addMode' in request.POST:
            form = EMIChallanBankAccountForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'Bank account added successfully')
                return redirect('finance:emi-challan-bank-accounts')
            
        if 'updateMode' in request.POST:
            id = request.POST.get('id')
            mode = get_object_or_404(EMIChallanBankAccount, id=id)
            mode.status = request.POST.get('status')
            mode.name = request.POST.get('name')
            mode.account_number = request.POST.get('account_number')
            mode.save()
            messages.success(request, 'Bank account updated successfully')
            return redirect('finance:emi-challan-bank-accounts')
    
        
        if 'deleteMode' in request.POST:
            id = request.POST.get('id')
            city = get_object_or_404(EMIChallanBankAccount, id=id)
            city.delete()
            messages.info(request, 'Bank account deleted successfully')
            return redirect('finance:emi-challan-bank-accounts')

    
    context = {
        'modes' : modes,
        'form' : form,
    }
    return render(request, 'finance/settings/emi-challan-bank-accounts.html', context)








@login_required
def printChallan(request, challan_number):
    profile = EMIChallanProfile.objects.first()
    bank_accounts = EMIChallanBankAccount.objects.filter(status=1)
    particulars = EMIChallanParticular.objects.filter(status=1)
    challan = get_object_or_404(ApplicantProductChallan, challan_number=challan_number)
    
    context = {
        'range': range(3),
        'profile' : profile,
        'bank_accounts' : bank_accounts,
        'challan' : challan,
        'particulars' : particulars,
    }
    return render(request, 'finance/challan.html', context)












@login_required
def getChallanDetailOnCreationAjax(request):
    details = EMIChallanParticular.objects.all()
    if request.GET.get('id'):
        applicant_product = get_object_or_404(ApplicantProduct, id=request.GET.get('id'))
        challans = ApplicantProductChallan.objects.filter(product=applicant_product)
        
        if challans:
            last_challan = challans.last()
            previous_outstanding = last_challan.previous_outstanding_amount
        
        else:
            previous_outstanding = applicant_product.financing_amount
    
    context = {
        'previous_outstanding' : previous_outstanding,
        'applicant_product' : applicant_product,
        'details' : details,
    }
    return render(request, 'finance/snippets/challan-details-on-creation.html', context)



