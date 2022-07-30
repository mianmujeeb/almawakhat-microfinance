import datetime
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
from finance.forms import *
from .models import *
from finance.models import *
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required


# Create your views here.

@login_required
def applicants(request):
    applicants = Applicant.objects.all()
    
    context = {
        'applicants' : applicants 
    }
    return render(request, 'applicants/applicants.html', context)


login_required
def addApplicantStep1(request):
    form = ApplicantForm()
    
    if request.method == 'POST':
        form = ApplicantForm(request.POST, request.FILES)
        if form.is_valid():
            applicant = form.save(commit=False)
            applicant.added_by = request.user
            applicant.save()
            messages.success(request, 'Applicant added successfuly')
            return redirect('applicants:add-applicant-2', applicant.id)
    
    context = {
        'form' : form,
    }
    return render(request, 'applicants/add-applicant-1.html', context)


@login_required
def addApplicantStep2(request, pk):
    instance = get_object_or_404(Applicant, id=pk)
    account_form = ApplicantBankAccountForm()
    
    if request.method == 'POST':
        form = ApplicantBankAccountForm(request.POST, request.FILES)
        
        if form.is_valid():
            a = form.save(commit=False)
            a.applicant = instance
            a.save()
            messages.success(request, 'Bank account addedd successfully')
            return redirect('applicants:add-applicant-3', instance.id)
            
    
    context = {
        'account_form' : account_form,
    }
    return render(request, 'applicants/add-applicant-2.html', context)


@login_required
def addApplicantStep3(request, pk):
    instance = get_object_or_404(Applicant, id=pk)
    guarantor_form = ApplicantGuarantorForm()
    
    if request.method == 'POST':
        form = ApplicantGuarantorForm(request.POST, request.FILES)
        
        if form.is_valid():
            a = form.save(commit=False)
            a.applicant = instance
            a.save()
            messages.success(request, 'Applicant addedd successfully')
            return redirect('applicants:applicants')
    
    context = {
        'guarantor_form' : guarantor_form,
    }
    return render(request, 'applicants/add-applicant-3.html', context)



@login_required
def editApplicant(request, pk):
    challan_heads = EMIChallanParticular.objects.all()
    instance = get_object_or_404(Applicant, id=pk)
    general_info_form = ApplicantForm(instance=instance)
    guarantor_form = ApplicantGuarantorForm()
    account_form = ApplicantBankAccountForm()
    product_form = ApplicantProductForm()
    active_div = None
    
    if request.method == 'POST':
        
        if 'generalInfo' in request.POST:
            form1 = ApplicantForm(request.POST, request.FILES, instance=instance)
            if form1.is_valid():
                form1.save()
                active_div = "generalInfo"
                messages.success(request, "Applicant's general info is successsfully updated")
            
        if 'passwordReset' in request.POST:
            active_div = "security"
            pass
        
        if 'addGuarantor' in request.POST:
            active_div = "guarantors"
            guarantor_form = ApplicantGuarantorForm(request.POST, request.FILES)
            
            if guarantor_form.is_valid():
                a = guarantor_form.save(commit=False)
                a.applicant = instance
                a.save()
                messages.success(request, 'Guarantor added successfully')
                
        if 'updateGuarantor' in request.POST:
            active_div = "guarantors"
            guarantor = get_object_or_404(ApplicantGuarantor, id=request.POST.get('guarantor_id'))
            guarantor_form = ApplicantGuarantorForm(request.POST, request.FILES, instance=guarantor)
            
            if guarantor_form.is_valid():
                a = guarantor_form.save()
                messages.success(request, 'Gauarantor updated successfully')
        
        if 'addBankAccount' in request.POST:
            active_div = "bankAccounts"
            account_form = ApplicantBankAccountForm(request.POST)
            
            if account_form.is_valid():
                a = account_form.save(commit=False)
                a.applicant = instance
                a.save()
                messages.success(request, 'Bank account added successfully')
        
        if 'updateBankAccount' in request.POST:
            active_div = "bankAccounts"
            account = get_object_or_404(ApplicantBankAccount, id=request.POST.get('bank_account_id'))
            account_form = ApplicantBankAccountForm(request.POST, instance=account)
            
            if account_form.is_valid():
                a = account_form.save()
                messages.success(request, 'Bank account details updated successfully')
        
        if 'addProduct' in request.POST:
            active_div = "products"
            product_form = ApplicantProductForm(request.POST)
            
            if product_form.is_valid():
                intrest_rate = product_form.cleaned_data['rent']/100
                months = product_form.cleaned_data['tenure']
                financing_amount = product_form.cleaned_data['financing_amount']
                negative_emi = np.pmt(intrest_rate/12, months, round(financing_amount))
                emi = round(negative_emi * (-1))
                
                a = product_form.save(commit=False)
                a.applicant = instance
                a.emi = emi
                a.added_by = request.user
                a.save()
                
                messages.success(request, 'Product added successfully')
                
        if 'addChallan' in request.POST:
            active_div = "challans"
            product = get_object_or_404(ApplicantProduct, id=request.POST.get('product'))
            due_date = request.POST.get('due_date')
            
            timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
            
            challan = ApplicantProductChallan.objects.create(
                applicant = instance, 
                product = product, 
                challan_number = f'{instance.refrence_number}-{product.product.code}-{timestamp}',
                voucher_numebr = 123, 
                reference_numebr = instance.refrence_number,
                due_date = due_date,
            )
            
            total = 0
            for i in challan_heads:
                amount = request.POST.get(f'{i.name}')
                print(type(amount))
                print(amount)
                if amount:
                    ApplicantProductChallanDetail.objects.create(
                        challan = challan,
                        particular = i,
                        amount = amount
                    )
                    total = total + int(amount)
                else:
                    ApplicantProductChallanDetail.objects.create(
                        challan = challan,
                        particular = i,
                        amount = 0
                    )
                
            
            challan.payable_till_due_date = total
            challan.payable_after_due_date = total+1000
            challan.save()
            
            messages.success(request, 'Challan added successfully')
                    
        if 'updateChallan' in request.POST:
            active_div = "challans"
            challan = get_object_or_404(ApplicantProductChallan, id=request.POST.get('challan_id'))
            challan.status = request.POST.get('status')
            challan.due_date = request.POST.get('due_date')
            challan.save()
            
            details = ApplicantProductChallanDetail.objects.filter(challan=challan)
            
            total = 0
            for i in details:
                amount = request.POST.get(f'{i.particular.name}')
                i.amount = amount
                i.save()
                total = total + int(amount)
            
            challan.payable_till_due_date = total
            challan.payable_after_due_date = total+1000
            challan.save()
            
            messages.success(request, 'Challan updated successfully')    
        
        
        
    context = {
        'active_div' : active_div,
        'instance' : instance,
        'challan_heads' : challan_heads,
        'general_info_form' : general_info_form,
        'guarantor_form' : guarantor_form,
        'account_form' : account_form,
        'product_form' : product_form,
    }
    return render(request, 'applicants/edit-applicant.html', context)


@login_required
def editApplicantGuarantor(request):
    print(request.GET.get('id'))
    instance = get_object_or_404(ApplicantGuarantor, id=request.GET.get('id'))
    form = ApplicantGuarantorForm(instance=instance)
    
    context = {
        'form' : form,
        'instance' : instance,
    }
    return render(request, 'applicants/snippets/edit-applicant-gurantor.html', context)


@login_required
def deleteApplicantGuarantor(request, pk):
    instance = get_object_or_404(ApplicantGuarantor, id=pk)
    applicant_id = instance.applicant.id
    instance.delete()
    messages.info(request, 'Guarantor deleted successfully')
    return redirect('applicants:edit-applicant', applicant_id)


@login_required
def editApplicantBankAccount(request):
    instance = get_object_or_404(ApplicantBankAccount, id=request.GET.get('id'))
    form = ApplicantBankAccountForm(instance=instance)
    
    context = {
        'form' : form,
        'instance' : instance,
    }
    return render(request, 'applicants/snippets/edit-applicant-bank-account.html', context)


@login_required
def deleteApplicantBankAccount(request, pk):
    instance = get_object_or_404(ApplicantBankAccount, id=pk)
    applicant_id = instance.applicant.id
    instance.delete()
    messages.info(request, 'Bank account deleted successfully')
    return redirect('applicants:edit-applicant', applicant_id)


@login_required
def applicantProductDetail(request):
    instance = get_object_or_404(ApplicantProduct, id=request.GET.get('id'))
    
    context = {
        'instance' : instance
    }
    return render(request, 'applicants/snippets/applicant-product-detail.html', context)


@login_required
def deleteApplicantProduct(request, pk):
    instance = get_object_or_404(ApplicantProduct, id=pk)
    applicant_id = instance.applicant.id
    instance.delete()
    messages.info(request, 'Product deleted successfully')
    return redirect('applicants:edit-applicant', applicant_id)



@login_required
def updateApplicantProductChallan(request):
    challan = get_object_or_404(ApplicantProductChallan, challan_number=request.GET.get('challan_number'))
    form = ApplicantProductChallanUpdateForm(instance=challan)
    
    context = {
        'challan' : challan,
        'form' : form,
    }
    return render(request, 'applicants/snippets/update-applicant-product-challan.html', context)


@login_required
def deleteApplicantProductChallan(request, pk):
    instance = get_object_or_404(ApplicantProductChallan, id=pk)
    applicant_id = instance.applicant.id
    instance.delete()
    messages.info(request, 'Challan deleted successfully')
    return redirect('applicants:edit-applicant', applicant_id)


