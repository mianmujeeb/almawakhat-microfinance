from django.contrib import admin
from .models import *
from finance.models import *



# Register your models here.

class ApplicantBankAccountInline(admin.StackedInline):
    model = ApplicantBankAccount
class ApplicantGuarantorInline(admin.StackedInline):
    model = ApplicantGuarantor
class ApplicantProductInline(admin.StackedInline):
    model = ApplicantProduct    

    
@admin.register(Applicant)
class ApplicantAdmin(admin.ModelAdmin):

    list_display = ('name', 'father_husband_name', 'cnic', 'phone', 'whatsapp', 'email')
    inlines = [
        ApplicantBankAccountInline,
        ApplicantGuarantorInline,
        ApplicantProductInline
    ]
    