from django.contrib import admin
from .models import *




# Register your models here.
@admin.register(ProductCategory)
class ProductCategoryAdmin(admin.ModelAdmin):

    list_display = ('name', 'status')
    list_filter = ('status',)
    search_fields = ('name',)
    
    
    
@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):

    list_display = ('name', 'brand', 'model', 'status')
    list_filter = ('status', 'category')
    search_fields = ('name', 'brand', 'model', 'code')
    
    
    
    
class VendorContactPersonInline(admin.TabularInline):
    model = VendorContactPerson
@admin.register(Vendor)
class VendorAdmin(admin.ModelAdmin):
    '''Admin View for Vendor'''

    list_display = ('name',)
    inlines = [
        VendorContactPersonInline,
    ]
    
    
    

    