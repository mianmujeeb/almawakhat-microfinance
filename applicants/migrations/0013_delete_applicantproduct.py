# Generated by Django 4.0.4 on 2022-07-21 11:29

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('applicants', '0012_rename_emi_applicantproduct_emi'),
    ]

    operations = [
        migrations.DeleteModel(
            name='ApplicantProduct',
        ),
    ]
