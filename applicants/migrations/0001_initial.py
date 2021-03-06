# Generated by Django 4.0.4 on 2022-06-21 06:53

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('settings', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Applicant',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', models.IntegerField(choices=[(1, 'Active'), (2, 'Inactive')], default=1)),
                ('refrence_number', models.CharField(max_length=100)),
                ('salutation', models.IntegerField()),
                ('name', models.CharField(max_length=120)),
                ('father_husband_name', models.CharField(max_length=120)),
                ('mother_name', models.CharField(max_length=120)),
                ('cnic', models.CharField(max_length=20)),
                ('dob', models.DateField()),
                ('gender', models.IntegerField(choices=[(1, 'Male'), (2, 'Female'), (3, 'Other')])),
                ('marital_status', models.IntegerField(choices=[(1, 'Married'), (2, 'Widowed'), (3, 'Separated'), (4, 'Divorced'), (5, 'Single')])),
                ('phone', models.CharField(max_length=20)),
                ('whatsapp', models.CharField(max_length=30)),
                ('email', models.EmailField(max_length=254)),
                ('education', models.BooleanField()),
                ('education_institute', models.CharField(max_length=120)),
                ('education_verification', models.CharField(max_length=50)),
                ('job_status', models.IntegerField(choices=[(1, 'Employeed'), (2, 'Unemployeed')])),
                ('residence_status', models.IntegerField(choices=[(1, 'Personal'), (2, 'Rent')])),
                ('monthly_rent', models.DecimalField(blank=True, decimal_places=2, max_digits=15, null=True)),
                ('mailing_address', models.CharField(max_length=255)),
                ('residing_duration', models.DateField()),
                ('current_address', models.CharField(max_length=255)),
                ('profession', models.CharField(max_length=100)),
                ('organization', models.CharField(max_length=150)),
                ('organization_type', models.IntegerField(choices=[(1, 'Gov'), (2, 'Private')])),
                ('doj', models.DateField()),
                ('experience', models.IntegerField()),
                ('monthly_income', models.DecimalField(decimal_places=2, max_digits=50)),
                ('office_phone', models.CharField(max_length=20)),
                ('office_email', models.EmailField(max_length=254)),
                ('office_address', models.CharField(max_length=255)),
                ('previous_loan', models.DecimalField(decimal_places=2, max_digits=100)),
                ('previous_loan_deduction', models.DecimalField(decimal_places=2, max_digits=100)),
                ('monthly_otherincome', models.DecimalField(decimal_places=2, max_digits=100)),
                ('monthly_expense', models.DecimalField(decimal_places=2, max_digits=100)),
                ('remarks', models.TextField(blank=True, null=True)),
                ('photo', models.ImageField(upload_to='Applicants/')),
                ('date_added', models.DateTimeField(auto_now_add=True)),
                ('date_updated', models.DateTimeField(auto_now=True)),
                ('added_by', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='applicant_added_by', to=settings.AUTH_USER_MODEL)),
                ('updated_by', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='applicant_updated_by', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Applicant',
                'verbose_name_plural': 'Applicants',
                'db_table': 'Applicants',
            },
        ),
        migrations.CreateModel(
            name='MODELNAME',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'verbose_name': 'MODELNAME',
                'verbose_name_plural': 'MODELNAMEs',
            },
        ),
        migrations.CreateModel(
            name='ApplicantGuarantor',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=150)),
                ('relation', models.CharField(max_length=50)),
                ('cnic', models.CharField(max_length=20)),
                ('mobile', models.CharField(max_length=20)),
                ('whatsapp', models.CharField(max_length=20)),
                ('email', models.EmailField(max_length=254)),
                ('address', models.CharField(max_length=250)),
                ('years_know', models.IntegerField()),
                ('photo', models.ImageField(upload_to='gurantors/pictures')),
                ('cnic_photo', models.ImageField(upload_to='gurantors/cnic')),
                ('applicant', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='applicant_guarantor', to='applicants.applicant')),
                ('city', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='related_applicant_gurantors', to='settings.city')),
            ],
            options={
                'verbose_name': 'Applicant Guarantor',
                'verbose_name_plural': 'Applicant Guarantors',
                'db_table': 'Applicant Guarantors',
            },
        ),
        migrations.CreateModel(
            name='ApplicantBankAccount',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('branch', models.CharField(max_length=200)),
                ('account_type', models.IntegerField(choices=[(1, 'Current'), (2, 'Saving'), (3, 'Money Market Account'), (4, 'Certificate of Deposit')])),
                ('account_title', models.CharField(max_length=100)),
                ('account_number', models.CharField(max_length=150)),
                ('account_opening_date', models.DateField()),
                ('applicant', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='applicant_bank_accounts', to='applicants.applicant')),
            ],
            options={
                'verbose_name': 'Applicant Bank Account',
                'verbose_name_plural': 'Applicant Bank Accounts',
                'db_table': 'Applicant Bank Accounts',
            },
        ),
    ]
