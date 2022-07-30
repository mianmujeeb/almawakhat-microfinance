from doctest import BLANKLINE_MARKER
from django.db import models
from settings.models import *
from django.contrib.auth.models import User
from inventory.models import *




# Create your models here.
class Applicant(models.Model):
    STAUTS_CHOICES = (
        (1, 'Active'),
        (2, 'Inactive'),
    )
    GENDER_CHOICES = (
        (1, 'Male'),
        (2, 'Female'),
        (3, 'Other'),
    )
    MARITAL_STATUS_CHOICES = (
        (1, 'Married'),
        (2, 'Widowed'),
        (3, 'Separated'),
        (4, 'Divorced'),
        (5, 'Single'),
    )
    JOB_STATUS_CHOICES = (
        (1, 'Employeed'),
        (2, 'Unemployeed'),
    )
    RESIDENCE_STATUS_CHOICES = (
        (1, 'Personal'),
        (2, 'Rent'),
    )
    ORGANIZATION_TYPEs_CHOICES = (
        (1, 'Gov'),
        (2, 'Private'),
    )
    
    status = models.IntegerField(choices=STAUTS_CHOICES, default=1)
    refrence_number = models.CharField(max_length=100)
    salutation = models.IntegerField()
    name = models.CharField(max_length=120)
    father_husband_name = models.CharField(max_length=120)
    mother_name = models.CharField(max_length=120)
    cnic = models.CharField(max_length=20)
    dob = models.DateField()
    gender = models.IntegerField(choices=GENDER_CHOICES)
    marital_status = models.IntegerField(choices=MARITAL_STATUS_CHOICES)
    phone = models.CharField(max_length=20)
    whatsapp = models.CharField(max_length=30)
    email = models.EmailField()
    education = models.CharField(max_length=150)
    education_institute = models.CharField(max_length=120)
    education_verification = models.FileField(upload_to="education_verification/")
    job_status = models.IntegerField(choices=JOB_STATUS_CHOICES)
    residence_status = models.IntegerField(choices=RESIDENCE_STATUS_CHOICES)
    monthly_rent = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    mailing_address = models.CharField(max_length=255)
    residing_duration = models.IntegerField()
    current_address = models.CharField(max_length=255)
    profession = models.CharField(max_length=100)
    organization = models.CharField(max_length=150)
    organization_type = models.IntegerField(choices=ORGANIZATION_TYPEs_CHOICES)
    doj = models.DateField()
    experience = models.IntegerField()
    monthly_income = models.DecimalField(max_digits=50, decimal_places=2)
    office_phone = models.CharField(max_length=20)
    office_email = models.EmailField()
    office_address = models.CharField(max_length=255)
    previous_loan = models.DecimalField(max_digits=100, decimal_places=2)
    previous_loan_deduction = models.DecimalField(max_digits=100, decimal_places=2)
    monthly_other_income = models.DecimalField(max_digits=100, decimal_places=2)
    monthly_expense = models.DecimalField(max_digits=100, decimal_places=2)
    remarks = models.TextField(null=True, blank=True)
    photo = models.ImageField(upload_to='Applicants/')
    date_added = models.DateTimeField(auto_now_add=True)
    added_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='applicant_added_by')
    date_updated = models.DateTimeField(auto_now=True)
    updated_by = models.ForeignKey(User, on_delete=models.CASCADE, null=True, related_name='applicant_updated_by')
    

    class Meta:

        verbose_name = 'Applicant'
        verbose_name_plural = 'Applicants'
        db_table = 'Applicants'

    def __str__(self):
        return self.name


class ApplicantBankAccount(models.Model):
    ACC_TYPE_CHOICES = (
        (1, 'Current'),
        (2, 'Saving'),
        (3, 'Money Market Account'),
        (4, 'Certificate of Deposit'),
    )
    applicant = models.ForeignKey(Applicant, on_delete=models.CASCADE, related_name='applicant_bank_accounts')
    name = models.CharField(max_length=100)
    branch = models.CharField(max_length=200)
    account_type = models.IntegerField(choices=ACC_TYPE_CHOICES)
    account_title = models.CharField(max_length=100)
    account_number = models.CharField(max_length=150)
    account_opening_date = models.DateField()

    class Meta:

        verbose_name = 'Applicant Bank Account'
        verbose_name_plural = 'Applicant Bank Accounts'
        db_table = 'Applicant Bank Accounts'

    def __str__(self):
        return self.applicant.name





class ApplicantGuarantor(models.Model):
    applicant = models.ForeignKey(Applicant, on_delete=models.CASCADE, related_name="applicant_guarantor")
    name = models.CharField(max_length=150)
    relation = models.CharField(max_length=50)
    cnic = models.CharField(max_length=20)
    phone = models.CharField(max_length=20)
    whatsapp = models.CharField(max_length=20)
    email = models.EmailField()
    city = models.ForeignKey(City, on_delete=models.CASCADE, related_name='applicant_gurantors')
    address = models.CharField(max_length=250)
    years_know = models.IntegerField()
    photo = models.ImageField(upload_to='gurantors/pictures')
    cnic_photo_front = models.ImageField(upload_to='gurantors/cnic')
    cnic_photo_back = models.ImageField(upload_to='gurantors/cnic')
    
    

    class Meta:

        verbose_name = 'Applicant Guarantor'
        verbose_name_plural = 'Applicant Guarantors'
        db_table = 'Applicant Guarantors'

    def __str__(self):
        return self.name







