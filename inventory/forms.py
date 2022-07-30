from django import forms
from .models import *


class ProductCategoryForm(forms.ModelForm):

    class Meta:

        model = ProductCategory
        fields = '__all__'


class ProductForm(forms.ModelForm):

    class Meta:

        model = Product
        fields = ('status', 'code', 'name', 'category', 'brand', 'model', 'price', 'description')
