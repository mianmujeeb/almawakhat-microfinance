from django.contrib import admin
from .models import *

# Register your models here.
@admin.register(EMIChallanProfile)
class EMIChallanProfileAdmin(admin.ModelAdmin):

    list_display = ('title',)
    

@admin.register(EMIChallanBankAccount)
class EMIChallanBankAccountAdmin(admin.ModelAdmin):

    list_display = ('name',)
    search_fields = ('name',)


@admin.register(EMIChallanParticular)
class EMIChallanParticularAdmin(admin.ModelAdmin):

    list_display = ('name',)
    search_fields = ('name',)


@admin.register(FinancingMode)
class FinancingModeAdmin(admin.ModelAdmin):

    list_display = ('name',)
    search_fields = ('name',)

    

@admin.register(ApplicantProduct)
class ApplicantProductAdmin(admin.ModelAdmin):

    list_display = ('applicant', 'product', 'financing_mode')
    list_filter = ('applicant', 'product', 'financing_mode')
    search_fields = ('applicant', 'product', 'financing_mode')
    
    
class ApplicantProductChallanDetailInline(admin.TabularInline):
    model = ApplicantProductChallanDetail
@admin.register(ApplicantProductChallan)
class ApplicantProductChallanAdmin(admin.ModelAdmin):

    list_display = ('applicant', 'product', 'status', 'challan_number', 'principal_outstanding_amount', 'payable_till_due_date')
    list_filter = ('applicant', 'product', 'status')
    inlines = [
        ApplicantProductChallanDetailInline,
    ]
    search_fields = ('challan_number', 'refrence_number')