from django import forms
from .models import *
from finance.models import *


class DateInput(forms.DateInput):
    input_type = 'date'

class TimeInput(forms.TimeInput):
    input_type = 'time'
    

class ApplicantForm(forms.ModelForm):

    class Meta:

        model = Applicant
        fields = ('status', 'refrence_number', 'salutation', 'name', 'father_husband_name', 'mother_name', 
                    'cnic', 'dob', 'gender', 'marital_status', 'phone', 'whatsapp', 'email', 'education',
                    'education_institute', 'education_verification', 'job_status', 'residence_status', 'monthly_rent',
                    'mailing_address', 'residing_duration', 'current_address', 'profession', 'organization', 'organization_type', 
                    'doj', 'experience', 'monthly_income', 'office_phone', 'office_email', 'office_address', 'previous_loan', 'previous_loan_deduction',
                    'monthly_other_income', 'monthly_expense', 'remarks', 'photo')
        labels = {
            'father__husband_name' : 'Father/Husband Name',
            'dob': 'Date of birth',
            'doj' : 'Date of joining',
            'cnic' : 'CNIC',
            }
        widgets = {
            'dob' : DateInput(),
            'doj' : DateInput,
        }
        
        
class ApplicantBankAccountForm(forms.ModelForm):

    class Meta:

        model = ApplicantBankAccount
        fields = ('name', 'branch', 'account_type', 'account_title', 'account_number', 'account_opening_date')
        widgets = {
            'account_opening_date' : DateInput()
        }
        labels = {
            'name' : 'Bank name'
        }


class ApplicantGuarantorForm(forms.ModelForm):

    class Meta:

        model = ApplicantGuarantor
        fields = ('name', 'relation', 'cnic', 'phone', 'whatsapp', 'email', 'city', 'address', 'years_know', 'photo', 'cnic_photo_front', 'cnic_photo_back')
        labels = {
            'cnic' : 'CNIC',
            'cnic_photo_front' : 'CNIC Photo Front',
            'cnic_photo_back' : 'CNIC Photo Back',
        }
        
        
        
class ApplicantProductForm(forms.ModelForm):

    class Meta:

        model = ApplicantProduct
        fields = ('product', 'financing_mode', 'financing_amount', 'security_amount', 'tenure', 'rent', 'installment_start_date')
        widgets = {
            'installment_start_date' : DateInput()
        }
