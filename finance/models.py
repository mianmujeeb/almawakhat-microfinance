import datetime
from django.db import models
from django.contrib.auth.models import User
from applicants.models import *
from inventory.models import *






# Create your models here.
class FinancingMode(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)

    class Meta:

        verbose_name = 'Financing Mode'
        verbose_name_plural = 'Financing Modes'
        db_table = 'Financing Modes'

    def __str__(self):
        return self.name
    
    
class EMIChallanParticular(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)

    class Meta:

        verbose_name = 'EMI Challan Particular'
        verbose_name_plural = 'EMI Challan Particulars'

    def __str__(self):
        return self.name
    
    
class EMIChallanProfile(models.Model):
    title = models.CharField(max_length=100)
    logo = models.ImageField(upload_to='challan/logo')

    class Meta:

        verbose_name = 'EMI Challan Profile'
        verbose_name_plural = 'EMI Challan Profiles'

    def __str__(self):
        return self.title



class EMIChallanBankAccount(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    name = models.CharField(max_length=100)
    account_number = models.CharField(max_length=100)

    class Meta:

        verbose_name = 'EMI Challan Bank Account'
        verbose_name_plural = 'EMI Challan Bank Accounts'

    def __str__(self):
        return self.name


class ApplicantProduct(models.Model):
    applicant = models.ForeignKey(Applicant, on_delete=models.CASCADE, related_name='applicant_products')
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='product')
    financing_mode = models.ForeignKey(FinancingMode, on_delete=models.CASCADE, related_name='applicant_products')
    financing_amount = models.DecimalField(max_digits=100, decimal_places=2)
    security_amount = models.DecimalField(max_digits=100, decimal_places=2)
    tenure = models.IntegerField()
    rent = models.IntegerField()
    installment_start_date = models.DateField()
    emi = models.IntegerField()
    date_added = models.DateTimeField(auto_now_add=True)
    added_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='applicant_product_added_by')
    date_updated = models.DateTimeField(auto_now=True)
    updated_by = models.ForeignKey(User, on_delete=models.CASCADE, null=True, related_name='applicant_product_updated_by')

    class Meta:

        verbose_name = 'Applicant Product'
        verbose_name_plural = 'Applicant Products'

    def __str__(self):
        return self.product.name



class ApplicantProductChallan(models.Model):
    
    STATUS_CHOICES = (
        (1, 'Pending'),
        (2, 'Paid'),
        (3, 'Unpaid'),
    )
    status = models.IntegerField(choices=STATUS_CHOICES, default=1)
    applicant = models.ForeignKey(Applicant, on_delete=models.CASCADE, related_name='challans_by_applicant')
    product = models.ForeignKey(ApplicantProduct, on_delete=models.CASCADE, related_name='challans')
    challan_number = models.CharField(max_length=999)
    voucher_numebr = models.CharField(max_length=999)
    reference_numebr = models.CharField(max_length=999)
    issue_date = models.DateField(auto_now_add=True)
    due_date = models.DateField()
    principal_outstanding_amount = models.IntegerField(null=True, blank=True)
    payable_till_due_date = models.IntegerField(null=True, blank=True)
    payable_after_due_date = models.IntegerField(null=True, blank=True)

    class Meta:

        verbose_name = 'Applicant Product Challan'
        verbose_name_plural = 'Applicant Product Challans'

    def __str__(self):
        return self.challan_number


class ApplicantProductChallanDetail(models.Model):
    challan = models.ForeignKey(ApplicantProductChallan, on_delete=models.CASCADE, related_name='challan_details')
    particular = models.ForeignKey(EMIChallanParticular, on_delete=models.CASCADE)
    amount = models.IntegerField()

    class Meta:

        verbose_name = 'Applicant Product Challan Detail'
        verbose_name_plural = 'Applicant Product Challan Details'

    def __str__(self):
        return self.challan.challan_number
