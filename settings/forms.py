from django import forms
from .models import *




class CurrencyForm(forms.ModelForm):

    class Meta:

        model = Currency
        fields = '__all__'



class RegionForm(forms.ModelForm):

    class Meta:

        model = Region
        fields = '__all__'
        
        
class CountryForm(forms.ModelForm):

    class Meta:

        model = Country
        fields = '__all__'
        labels = {
            'iso2digit' : 'ISO 2 Digit',
            'iso3digit' : 'ISO 3 Digit',
        }


class StateForm(forms.ModelForm):

    class Meta:

        model = State
        fields = '__all__'



class SubStateForm(forms.ModelForm):

    class Meta:

        model = SubState
        fields = '__all__'
        
        
        
class CityForm(forms.ModelForm):

    class Meta:

        model = City
        fields = '__all__'
