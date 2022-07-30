from django import forms
from .models import *


class DateInput(forms.DateInput):
    input_type = 'date'

class TimeInput(forms.TimeInput):
    input_type = 'time'
    
    

class FinancingModeForm(forms.ModelForm):

    class Meta:

        model = FinancingMode
        fields = ('status', 'name', 'description')
        
        
        

class EMIChallanParticularForm(forms.ModelForm):

    class Meta:

        model = EMIChallanParticular
        fields = ('status', 'name', 'description')
        
        
        
class EMIChallanParticularForm(forms.ModelForm):

    class Meta:

        model = EMIChallanParticular
        fields = ('status', 'name', 'description')
        


class EMIChallanProfileForm(forms.ModelForm):

    class Meta:

        model = EMIChallanProfile
        fields = ('title', 'logo')


class EMIChallanBankAccountForm(forms.ModelForm):

    class Meta:

        model = EMIChallanBankAccount
        fields = ('status', 'name', 'account_number')
        


class ApplicantProductChallanUpdateForm(forms.ModelForm):

    class Meta:

        model = ApplicantProductChallan
        fields = ('status', 'due_date')
        widgets = {
            'due_date' : DateInput()
        }
