from django.db import models
from django.contrib.auth.models import User
from ckeditor.fields import RichTextField

# Create your models here.



    
    
class Vendor(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=20)
    email = models.EmailField(null=True, blank=True)
    address = models.CharField(max_length=300)
    date_added = models.DateTimeField(auto_now_add=True)
    address = models.ForeignKey(User, on_delete=models.CASCADE, related_name='vendor_added_by')
    date_updated = models.DateTimeField(auto_now=True)
    updated_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='vendor_updated_by', null=True, blank=True)

    class Meta:

        verbose_name = 'Vendor'
        verbose_name_plural = 'Vendors'

    def __str__(self):
        return self.name
    
    
    
class VendorContactPerson(models.Model):
    vendor = models.ForeignKey(Vendor, on_delete=models.CASCADE, related_name='contact_persons')
    name = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=20)
    whatsapp = models.CharField(max_length=20)
    email = models.EmailField(null=True, blank=True)
    

    class Meta:

        verbose_name = 'Vendor Contact Person'
        verbose_name_plural = 'Vendor Contact Persons'

    def __str__(self):
        return self.name
    
    
    
class PurchaseOrder(models.Model):
    PAID_METHOD_CHOICES = (
        (1, 'Bank'),
        (2, 'Cash'),
        (3, 'A/C Account'),
    )
    order_number = models.CharField(max_length=100)
    vendor = models.ForeignKey(Vendor, on_delete=models.CASCADE, related_name='purchase_orders')
    dated = models.DateField()
    tax = models.DecimalField(max_digits=100, decimal_places=2, null=True)
    advance = models.DecimalField(max_digits=100, decimal_places=2, null=True)
    paid_date = models.DateField(null=True)
    paid_method = models.IntegerField(choices=PAID_METHOD_CHOICES, null=True)
    deposit_slip = models.CharField(max_length=100, null=True)  
    date_added = models.DateTimeField(auto_now_add=True)
    address = models.ForeignKey(User, on_delete=models.CASCADE, related_name='purchase_order_added_by')
    date_updated = models.DateTimeField(auto_now=True)
    updated_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='purchase_order_updated_by', null=True, blank=True)

    class Meta:

        verbose_name = 'Purchase Order'
        verbose_name_plural = 'Purchase Orders'

    def __str__(self):
        pass




class ProductCategory(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=100)
    description = models.CharField(max_length=300, null=True, blank=True)

    class Meta:

        verbose_name = 'Product Category'
        verbose_name_plural = 'Product Categories'
        db_table = 'Product Categories'

    def __str__(self):
        return self.name



class Product(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    code = models.CharField(max_length=20)
    # vendor = models.ForeignKey(Vendor, on_delete=models.CASCADE, related_name="related_products")
    # quantity = models.IntegerField()
    name = models.CharField(max_length=100)
    category = models.ForeignKey(ProductCategory, on_delete=models.CASCADE, related_name="related_products")
    brand = models.CharField(max_length=150)
    model = models.CharField(max_length=150)
    price = models.FloatField()
    description = RichTextField(null=True, blank=True)
    picture = models.ImageField(null=True, blank=True, upload_to="Products/")
    date_added = models.DateTimeField(auto_now_add=True)
    added_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='products_added_by')
    date_updated = models.DateTimeField(auto_now=True, null=True)
    updated_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='products_updated_by', null=True)

    class Meta:

        verbose_name = 'Product'
        verbose_name_plural = 'Products'
        db_table = 'Products'

    def __str__(self):
        return self.name

    
