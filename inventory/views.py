import datetime
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.hashers import make_password
from django.contrib import messages
from django.conf import settings
from django.core.mail import EmailMessage
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.core.mail import EmailMultiAlternatives
from settings.models import *
from .models import *
from .forms import *
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required, permission_required

# Create your views here.
@login_required
def productCategories(request):
    categories = ProductCategory.objects.all().order_by('-id')
    form = ProductCategoryForm()
    
    if request.method == 'POST':
        
        if 'addCat' in request.POST:
            form = ProductCategoryForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'Category added successfully')
                return redirect('inventory:product-categories')
            
        if 'updateCat' in request.POST:
            id = request.POST.get('id')
            category = get_object_or_404(ProductCategory, id=id)
            category.status = request.POST.get('status')
            category.name = request.POST.get('name')
            category.description = request.POST.get('description')
            category.save()
            messages.success(request, 'Category updated successfully')
            return redirect('inventory:product-categories')
    
        
        if 'deleteCat' in request.POST:
            id = request.POST.get('id')
            category = get_object_or_404(ProductCategory, id=id)
            category.delete()
            messages.info(request, 'Category deleted successfully')
            return redirect('inventory:product-categories')
    
    context = {
        'categories' : categories,
        'form' : form,
    }
    return render(request, 'inventory/product-categories.html', context)



@login_required
def products(request):
    products = Product.objects.all().order_by('-id')
    form = ProductForm()
    
    if request.method == 'POST':
        
        if 'addProd' in request.POST:
            form = ProductForm(request.POST)
            if form.is_valid():
                product = form.save(commit=False)
                product.added_by = request.user
                product.save()
                messages.success(request, 'Product added successfully')
                return redirect('inventory:products')
            
        
        if 'deleteProd' in request.POST:
            id = request.POST.get('id')
            category = get_object_or_404(Product, id=id)
            category.delete()
            messages.info(request, 'Product deleted successfully')
            return redirect('inventory:products')
    
    context = {
        'products' : products,
        'form' : form,
    }
    return render(request, 'inventory/products.html', context)



@login_required
def updateProduct(request, id):
    product = get_object_or_404(Product, id=id)
    form = ProductForm(instance=product)
    
    if request.method == 'POST':
        form = ProductForm(request.POST, instance=product)
        
        if form.is_valid():
            instance = form.save(commit=False)
            instance.updated_by = request.user
            instance.save()
            messages.success(request, 'Product updated successfully')
            return redirect('inventory:products')
    
    context = {
        'instance' : product,
        'form' : form,
    }
    return render(request, 'inventory/update-product.html', context)